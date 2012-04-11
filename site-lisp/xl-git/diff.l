;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/diff.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-11 20:03:04 DeaR>

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
  (require "xl-git/output")
  (require "xl-git/command"))

(in-package :git)

(export '(*git-diff-color-add*
          *git-diff-color-remove*
          *git-diff-color-area*))



(defvar *git-diff-color-add* '(:color 2)
  "diff�̒ǉ��s�̐F")

(defvar *git-diff-color-remove* '(:color 1)
  "diff�̍폜�s�̐F")

(defvar *git-diff-color-area* '(:color 6)
  "diff�͈̔͏��̐F
@@ -R +R @@")

(defvar *git-diff-keymap* nil
  "git diff�o�̓��[�h�̃L�[�}�b�v")
(unless *git-diff-keymap*
  (setf *git-diff-keymap* (make-sparse-keymap))
  (define-key *git-diff-keymap* #\q 'git-output-quit))



(defun git-diff-mode (&key
                      (directory (default-directory))
                      (encoding *git-process-encoding*)
                      (eol-code *git-process-eol-code*))
  "git diff�o�̓��[�h"
  (git-output-mode :directory directory
                   :encoding encoding
                   :eol-code eol-code)
  (make-local-variable 'regexp-keyword-list)
  (setf regexp-keyword-list
        (compile-regexp-keyword-list
         `(("^\\+.*$"
            nil ,*git-diff-color-add*)
           ("^\\-.*$"
            nil ,*git-diff-color-remove*)
           ("^@@ .* @@.*$"
            nil ,*git-diff-color-area*))))
  (use-keymap *git-diff-keymap*))

(provide "xl-git/diff")