;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/diff.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-18 15:55:56 DeaR>

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

(in-package :git)

(export '(*git-diff-color-header*
          *git-diff-color-add*
          *git-diff-color-remove*
          *git-diff-color-area*))



(defvar *git-diff-color-header* '(:color 0 0 :bold)
  "diffのヘッダの色")

(defvar *git-diff-color-add* '(:color 2)
  "diffの追加行の色")

(defvar *git-diff-color-remove* '(:color 1)
  "diffの削除行の色")

(defvar *git-diff-color-area* '(:color 6)
  "diffの範囲情報の色
@@ -R +R @@")

(defvar-local *git-diff-mode* nil
  "git-diff-mode")
(pushnew '(*git-diff-mode* . "Diff") *minor-mode-alist* :key #'first)



(defun git-diff-mode (&optional (arg nil sv))
  "git diffモード"
  (ed::toggle-mode '*git-diff-mode* arg sv)
  (set-regexp-keyword-list
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
       nil ,*git-diff-color-area*)))
   *git-diff-mode*))

(provide "xl-git/diff")
