;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/utils.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-11 20:41:05 DeaR>

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
          *git-temp-bufname*
          define-git-command))



(defvar *git-output-bufname* "*Git*"
  "出力バッファ名")

(defvar *git-output-split-vertical-p* t
  "出力バッファは縦に分割する")

(defvar *git-temp-bufname* " *Git Temp*"
  "作業バッファ名")



(defun git-top-dir (&optional (dir (default-directory)))
  ".gitのパスを取得"
  (multiple-value-bind (exec-code out)
      (git-call-process '("rev-parse" "--show-cdup")
                        :output (get-buffer-create *git-temp-bufname*)
                        :exec-directory dir)
    (unless (= exec-code 0)
      (error out))
    (merge-pathnames (or (first (split-string out #\LFD))
                         "")
                     dir)))

(defun git-relative-pathnames (path)
  ".gitからの相対パスに変換"
  (let ((path (merge-pathnames path)))
    (substring path
               (length (append-trail-slash (git-top-dir (directory-namestring path)))))))

(defmacro define-git-command (command &key symbol document prompt file-arg mode)
  "シンプルなgitコマンド生成"
  `(let ((symbol (intern (concat "git-"
                                 (if ',symbol
                                     (if (stringp ',symbol)
                                         ,symbol
                                       (symbol-name ',symbol))
                                   (if (listp ,command)
                                       (format nil "~{~A~}" ,command)
                                     (substitute-string ,command " " ""))))
                         :git)))
     (export symbol :git)
     (setf (symbol-function symbol)
           #'(lambda ()
               ,document
               (interactive)
               (git::git-command-wrapper ,command
                                         :prompt ,prompt
                                         :file-arg ,file-arg
                                         :mode ,mode)))))
(setf (get 'define-git-command 'lisp-indent-hook) 'defun)

(defun git-command-wrapper (command &key prompt file-arg
                                    (mode #'git-output-mode))
  "シンプルなgitコマンド実体"
  (let ((args (if (or prompt
                      *prefix-args*
                      (not (file-visited-p)))
                  (read-string (if (listp command)
                                   (format nil "git~{ ~A~}: " command)
                                 (format nil "git ~A: " command)))
                (if file-arg
                    (format nil "\"~A\"" (file-namestring (get-buffer-file-name)))
                  "")))
        (buffer (get-buffer-create *git-output-bufname*)))
    (erase-buffer buffer)
    (git-make-process (if (listp command)
                          (append command (list args))
                        (format nil "~A ~A" command args))
                      :output buffer)
    (unless (or (get-buffer-window buffer)
                (> (count-windows) 1))
      (split-window nil *git-output-split-vertical-p*))
    (pop-to-buffer buffer nil *git-output-split-vertical-p*)
    (funcall mode)))



(provide "xl-git/utils")
