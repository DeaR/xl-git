;; -*- mode: lisp; package: xl-git; encoding: shift_jis -*-

;; @name        xl-git/diff.lisp
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
  (require "xl-git/package"))

(in-package :xl-git)

(export '(*git-diff-color-header*
          *git-diff-color-add*
          *git-diff-color-remove*
          *git-diff-color-area*
          *git-diff-mode-hook*))



(defvar *git-diff-color-header* '(:color 0 0 :bold)
  "diffのヘッダの色")

(defvar *git-diff-color-add* '(:color 2)
  "diffの追加行の色")

(defvar *git-diff-color-remove* '(:color 1)
  "diffの削除行の色")

(defvar *git-diff-color-area* '(:color 6)
  "diffの範囲情報の色
@@ -R +R @@")

(defvar *git-diff-mode-hook* nil
  "git-diff-mode起動時に実行されます")



(defun git-diff-regexp-keyword-list ()
  "git diffモードのregexp-keyword-list"
  (compile-regexp-keyword-list
   `(("^diff .*$"
      nil ,*git-diff-color-header*)
     ("^index .*$"
      nil ,*git-diff-color-header*)
     ("^[+-]\\{3\\} .*$"
      nil ,*git-diff-color-header*)
     ("^\\+.*$"
      nil ,*git-diff-color-add*)
     ("^-.*$"
      nil ,*git-diff-color-remove*)
     ("^@@ .* @@.*$"
      nil ,*git-diff-color-area*))))

(defun git-diff-mode (&optional (arg nil sv))
  "git diffモード"
  (interactive)
  (kill-all-local-variables)
  (setf mode-name "GitDiff")
  (setf buffer-mode 'git-diff-mode)
  (unless (local-variable-p '#0=regexp-keyword-list)
    (make-local-variable '#0#))
  (setf #0# (append #0# (git-diff-regexp-keyword-list)))
  (run-hooks '*git-diff-mode-hook*))

(provide "xl-git/diff")
