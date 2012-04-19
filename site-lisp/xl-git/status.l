;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/status.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-19 17:22:24 DeaR>

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

(in-package :git)

(export '(*git-status-mode-hook*
          git-status))



(defvar *git-status-mode-hook* nil
  "git-status-mode起動時に実行されます")



(defun git-status-mode (&optional (arg nil sv))
  "git statusモード"
  (interactive)
  (kill-all-local-variables)
  (setf mode-name "GitStatus")
  (setf buffer-mode 'git-status-mode)
  (run-hooks '*git-status-mode-hook*))

(defun git-status (&optional args)
  "Show the working tree status."
  (interactive)
  (git-command-0 '("status")
                 args :mode #'git-status-mode))

(provide "xl-git/status")
