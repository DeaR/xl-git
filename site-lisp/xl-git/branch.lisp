;; -*- mode: lisp; package: xl-git; encoding: shift_jis -*-

;; @name        xl-git/branch.lisp
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
  (require "xl-git/utils"))

(in-package :xl-git)

(export '(*git-branch-color-current*
          *git-branch-color-remote*
          *git-branch-mode-hook*))



(defvar *git-branch-color-current* '(:color 2)
  "branchの現在ブランチの色")

(defvar *git-branch-color-remote* '(:color 1)
  "branchのリモートブランチの色")

(defvar *git-branch-mode-hook* nil
  "git-branch-mode起動時に実行されます")



(defun git-branch-regexp-keyword-list ()
  "git branchモードのregexp-keyword-list"
  (append (compile-regexp-keyword-list
           `(("^\\* \\([^ ]+\\)$"
              nil ,*git-branch-color-current* nil 1)))
          (compile-regexp-keyword-list
           (mapcar #'(lambda (b)
                       `(,(concat "^[ *] \\(\\(remotes/\\)?" b "\\)")
                         nil ,*git-branch-color-remote* nil 1))
                   (git-get-remote-branch)))))

(defun git-branch-mode (&optional (arg nil sv))
  "git branchモード"
  (interactive)
  (kill-all-local-variables)
  (setf mode-name "GitBranch")
  (setf buffer-mode 'git-branch-mode)
  (unless (local-variable-p '#0=regexp-keyword-list)
    (make-local-variable '#0#))
  (setf #0# (append #0# (git-branch-regexp-keyword-list)))
  (run-hooks '*git-branch-mode-hook*))

(provide "xl-git/branch")
