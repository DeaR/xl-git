;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/branch.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-16 15:41:29 DeaR>

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

(export '(*git-branch-color-current*
          *git-branch-color-remote*))



(defvar *git-branch-color-current* '(:color 2)
  "branch�̌��݃u�����`�̐F")

(defvar *git-branch-color-remote* '(:color 1)
  "branch�̃����[�g�u�����`�̐F")

(defvar-local *git-branch-mode* nil
  "git-branch-mode")
(pushnew '(*git-branch-mode* . "branch") *minor-mode-alist* :key #'first)



(defun git-branch-mode (&optional (arg nil sv))
  "git branch���[�h"
  (ed::toggle-mode '*git-branch-mode* arg sv)
  (if *git-branch-mode*
      (progn
        (make-local-variable 'regexp-keyword-list)
        (setf regexp-keyword-list
              (compile-regexp-keyword-list
               `(("^\\* \\(.*\\)$"
                  nil ,*git-branch-color-current* nil 1)
                 ("remotes/[^ ]+"
                  nil ,*git-branch-color-remote*)))))
    (kill-local-variable 'regexp-keyword-list)))

(provide "xl-git/branch")