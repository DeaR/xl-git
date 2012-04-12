;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/utils.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-12 17:14:03 DeaR>

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

(defmacro define-git-command (command &key symbol document prompt file-arg minor-mode)
  "シンプルなgitコマンド生成"
  (let ((name (concat "git-"
                      (if symbol
                          (string symbol)
                        (if (listp command)
                            (format nil "~{~A~}" command)
                          (substitute-string command " " ""))))))
    `(progn
       (export (intern ,name :git) :git)
       (defun ,(intern name :git) (&optional args)
         ,document
         (interactive)
         (git::git-command-wrapper ',command args
                                   :prompt ,prompt
                                   :file-arg ,file-arg
                                   :minor-mode ,minor-mode)))))
(setf (get 'define-git-command 'lisp-indent-hook) 'defun)

(defun git-command-wrapper (command args &key prompt file-arg (minor-mode #'git-output-mode))
  "シンプルなgitコマンド実体"
  (let* ((dir (default-directory))
         (command (if (listp command)
                      (string-trim " " (format nil "~{ ~A~}" command))
                    command))
         (args (or args
                   (and (or prompt
                            *prefix-args*
                            (not (file-visited-p)))
                        (read-string (format nil "git ~A: " command)))
                   (and file-arg
                        (format nil "\"~A\"" (file-namestring (get-buffer-file-name))))
                   "")))
    (with-output-to-temp-buffer (*git-output-bufname* t *git-output-split-vertical-p*)
      (git-output-mode)
      (set-default-directory dir)
      (set-buffer-fileio-encoding *git-process-encoding*)
      (set-buffer-eol-code *git-process-eol-code*)
      (when minor-mode
        (funcall minor-mode))
      (git-make-process (format nil "~A ~A" command args) :output (selected-buffer)))))

(provide "xl-git/utils")
