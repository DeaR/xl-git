;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/utils.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-20 13:35:17 DeaR>

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

(in-package :git)

(export '(*git-output-bufname*
          *git-output-split-vertical-p*
          *git-temp-bufname*))



(defvar *git-output-bufname* "*Git*"
  "出力バッファ名")

(defvar *git-output-split-vertical-p* t
  "出力バッファは縦に分割する")

(defvar *git-temp-bufname* " *Git Temp*"
  "作業バッファ名")

(define-history-variable *git-prompt-history* nil
  "プロンプトの履歴")



(defmacro define-git-command (command &rest options)
  "シンプルなgitコマンド生成"
  (let ((name (or (second (assoc :name options))
                  (substitute-string (if (listp command)
                                         (format nil "git~{-~A~}" command)
                                       (format nil "git-~A" command))
                                     "[ -]+" "-")))
        (documentation (second (assoc :documentation options))))
    `(progn
       (defun ,(intern (string name)) (&optional args)
         ,documentation
         (interactive)
         (apply #'git::git-command-0
                (list ,@command) args '(,@options))))))

(defun git-command-0 (command args &rest options)
  "シンプルなgitコマンド実体"
  (let* ((completion (rest (assoc :completion options)))
         (dir-prompt (second (assoc :dir-prompt options)))
         (no-prompt (second (assoc :no-prompt options)))
         (file-arg (second (assoc :file-arg options)))
         (mode (second (assoc :mode options)))
         (no-std-handles (second (assoc :no-std-handles options)))
         (dir (if dir-prompt
                  (read-directory-name "Exec directory: ")
                (default-directory)))
         (command (if (listp command)
                      (string-left-trim " " (format nil "~{ ~A~}" command))
                    (string command)))
         (args (or args
                   (unless no-prompt
                     (git-read-args command completion))))
         (cmdline (concat command
                          " "
                          args
                          (when file-arg
                            (format nil " \"~A\""
                                    (file-namestring (or (get-buffer-file-name)
                                                         (read-file-name "File: "))))))))
    (if no-std-handles
        (git-call-process cmdline :exec-directory dir :no-std-handles t :wait t)
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
        (git-make-process cmdline :exec-directory dir :output buffer :show :hide)))))

(defun git-read-args (command &optional completion)
  "argsをプロンプトで取得"
  (let ((command (if (listp command)
                     (string-left-trim " " (format nil "~{ ~A~}" command))
                   (string command)))
        (read) (args))
    (loop
      (setf read (completing-read (format nil "git~[~:; ~]~A~{ ~A~}: " (length command) command (reverse args))
                                  completion
                                  :history 'git-prompt))
      (when (string-match "^[ \t\r\n]*$" read)
        (return (string-left-trim " " (format nil "~{ ~A~}" (nreverse args)))))
      (push read args))))



(setf (get 'git-prompt 'ed::minibuffer-history-variable) '*git-prompt-history*)
(setf (get 'define-git-command 'lisp-indent-hook) 'defun)

(provide "xl-git/utils")
