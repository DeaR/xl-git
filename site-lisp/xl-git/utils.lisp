;; -*- mode: lisp; package: xl-git; encoding: shift_jis -*-

;; @name        xl-git/utils.lisp
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-05-01 15:42:16 DeaR>

;; Copyright (c) 2012 DeaR <nayuri@kuonn.mydns.jp>
;;
;; Permission is hereby granted, free of charge, to any person obtaining a copy of
;; this software and associated documentation files (the "Software"), to deal in
;; the Software without restriction, including without limitation the rights to
;; use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
;; the Software, and to permit persons to whom the Software is furnished to do so,
;; subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be included in all copies
;; or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
;; INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
;; PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
;; DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "xl-git/package")
  (require "xl-git/process")
  (require "xl-git/output"))

(in-package :xl-git)

(export '(*git-output-bufname*
          *git-output-split-vertical-p*
          *git-temp-bufname*
          *git-completing-prompt*))



(defvar *git-output-bufname* "*Git*"
  "出力バッファ名")

(defvar *git-output-split-vertical-p* t
  "出力バッファは縦に分割する")

(defvar *git-temp-bufname* " *Git Temp*"
  "作業バッファ名")

(defvar *git-completing-prompt* nil
  "引数入力を補完入力にする
non-nil なら completing-read
nil なら read-string")

(define-history-variable *git-prompt-history* nil
  "プロンプトの履歴")

(defconstant +git-branch-name-regexp+ (compile-regexp "^[ *] \\([^ ]+\\)")
  "ブランチ名の正規表現")



(defun git-uninstall ()
  "アンインストールする"
  (unregister-history-variable '*git-prompt-history*)
  (setf *modules* (delete "xl-git" *modules* :test #'string=))
  (setf *modules* (delete "xl-git/" *modules* :test #'string-match))
  (setf *modules* (delete "xl-git-flow" *modules* :test #'string=))
  (unuse-package :xl-git))

(defmacro with-selected-buffer (&body body)
  "BODYの前後でカレントバッファを保存します"
  `(let ((selected-buffer (selected-buffer)))
     (unwind-protect
         (progn
           ,@body)
       (set-buffer selected-buffer))))

(defun relative-pathnames (fn dir)
  "dirを基準にしたfnの相対パスを返す"
  (if (string-equal (pathname-device #0=(merge-pathnames fn))
                    (pathname-device #1=(merge-pathnames dir)))
      (let ((fn (split-string #0# #\/))
            (dir (split-string #1# #\/)))
        (dotimes (i (length fn))
          (unless (string-equal (nth i fn) (nth i dir))
            (return (format nil "~{~A/~}~{~A/~}~{~A~}"
                            (make-list (- (length dir) i) :initial-element "..")
                            (butlast (last fn (- (length fn) i)))
                            (last fn))))))
    #0#))

(defmacro define-git-command (command &rest options)
  "シンプルなgitコマンド生成"
  (let* ((command (if (listp command)
                      command
                    (list command)))
         (binary (or (second (assoc :binary options))
                     *git-binary*))
         (name (or (second (assoc :name options))
                   (substitute-string (format nil "~A~{-~A~}" (pathname-name binary) command) "[ -]+" "-")))
         (package (or (second (assoc :package options))
                      *package*))
         (documentation (second (assoc :documentation options))))
    `(progn
       (defun ,(intern (string name)) (&optional args)
         ,documentation
         (interactive)
         (apply #'xl-git::git-command-0
                (list ,@command) args '(,@options))))))

(defun git-command-0 (command args &rest options)
  "シンプルなgitコマンド実体"
  (let* ((binary (or (second (assoc :binary options))
                     *git-binary*))
         (completion (rest (assoc :completion options)))
         (dir-prompt (second (assoc :dir-prompt options)))
         (no-prompt (second (assoc :no-prompt options)))
         (file-arg (second (assoc :file-arg options)))
         (mode (second (assoc :mode options)))
         (no-std-handles (second (assoc :no-std-handles options)))
         (show (third (assoc :no-std-handles options)))
         (dir (if dir-prompt
                  (read-directory-name "Exec directory: ")
                (default-directory)))
         (command (if (listp command)
                      (string-left-trim " " (format nil "~{ ~A~}" command))
                    (string command)))
         (args (or args
                   (unless no-prompt
                     (git-read-args command completion binary))))
         (file-arg (when file-arg
                     (let ((out `(,(or (get-buffer-file-name) (read-file-name "File: ")))))
                       (when (numberp file-arg)
                         (dotimes (i (1- file-arg))
                           (push (read-file-name (format nil "File ~D: " (+ i 2))) out)))
                       (nreverse out))))
         (cmdline (format nil "~A ~A~{ \"~A\"~}" command args
                          (mapcar #'(lambda (f) (relative-pathnames f dir)) file-arg))))
    (if no-std-handles
        (git-call-process cmdline :binary binary :exec-directory dir
                          :no-std-handles no-std-handles
                          :show (or show :show))
      (let ((buffer (get-buffer-create *git-output-bufname*)))
        (when (= (count-windows) 1)
          (split-window nil *git-output-split-vertical-p*))
        (pop-to-buffer buffer)
        (erase-buffer buffer)
        (when mode
          (funcall mode))
        (git-output-mode)
        (setup-temp-buffer buffer)
        (set-default-directory dir buffer)
        (set-buffer-fileio-encoding *git-process-encoding* buffer)
        (set-buffer-eol-code *git-process-eol-code* buffer)
        (git-make-process cmdline :binary binary :exec-directory dir
                          :output buffer :show (or show :hide))))))

(defun git-read-args (command &optional completion (binary *git-binary*))
  "argsをプロンプトで取得"
  (let ((command (if (listp command)
                     (string-left-trim " " (format nil "~{ ~A~}" command))
                   (string command)))
        (read) (args))
    (if *git-completing-prompt*
        (loop
          (setf read (completing-read (format nil "~A~[~:; ~]~A~{ ~A~}: "
                                              (pathname-name binary) (length command) command (reverse args))
                                      completion :history 'git-prompt))
          (when (string-match "^[ \t\r\n]*$" read)
            (return (string-left-trim " " (format nil "~{ ~A~}" (nreverse args)))))
          (push read args))
      (read-string (format nil "~A~[~:; ~]~A: " (pathname-name binary) (length command) command)
                   :history 'git-prompt))))

(defun git-get-local-branch ()
  "ローカルブランチをリストで取得"
  (multiple-value-bind (exit-code out)
      (git-call-process '("branch")
                        :output (get-buffer-create *git-temp-bufname*)
                        :show :hide :wait t)
    (and (eq exit-code 0)
         (mapcar #'(lambda (s)
                     (and (string-match +git-branch-name-regexp+ s)
                          (match-string 1)))
                 (split-string out #\LFD)))))

(defun git-get-remote-branch ()
  "リモートブランチをリストで取得"
  (multiple-value-bind (exit-code out)
      (git-call-process '("branch" "-r")
                        :output (get-buffer-create *git-temp-bufname*)
                        :show :hide :wait t)
    (and (eq exit-code 0)
         (mapcar #'(lambda (s)
                     (and (string-match +git-branch-name-regexp+ s)
                          (match-string 1)))
                 (split-string out #\LFD)))))



(setf (get 'git-prompt 'ed::minibuffer-history-variable) '*git-prompt-history*)
(setf (get 'define-git-command 'lisp-indent-hook) 'defun)

(provide "xl-git/utils")
