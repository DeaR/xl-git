;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/log.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-20 12:48:16 DeaR>

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

(export '(*git-log-color-line*
          *git-log-color-sha*
          *git-log-color-brace*
          *git-log-color-head*
          *git-log-color-branch*
          *git-log-color-remote-branch*
          *git-log-color-tag*
          *git-log-default-limit*
          *git-log-mode-hook*
          git-log
          git-glog))



(defvar *git-log-color-line* '(:color 1)
  "graph logの線の色")

(defvar *git-log-color-sha* '(:color 3)
  "logのSHAの色")

(defvar *git-log-color-brace* '(:color 3)
  "logの括弧の色")

(defvar *git-log-color-head* '(:color 6 0 :bold)
  "logのHEADの色")

(defvar *git-log-color-branch* '(:color 2 0 :bold)
  "logのブランチ名の色")

(defvar *git-log-color-remote-branch* '(:color 1 0 :bold)
  "logのリモートブランチ名の色")

(defvar *git-log-color-tag* '(:color 3 0 :bold)
  "logのタグ名の色")

(defvar *git-log-default-limit* 100
  "logのデフォルト件数")

(defvar *git-log-mode-hook* nil
  "git-log-mode起動時に実行されます")



(defun git-log-regexp-keyword-list ()
  "git logモードのregexp-keyword-list"
  (compile-regexp-keyword-list
   `(("^[ */|\\]+ "
      nil ,*git-log-color-line*)
     ("\\(commit[: ]+\\)?[0-9a-f]\\{4,40\\}"
      nil ,*git-log-color-sha*)
     ("(\\(HEAD,? ?\\)?\\(\\(tag: [^, ():]+,? ?\\)*\\)\\(\\(origin/[^, ():]+,? ?\\)*\\)\\(\\([^():]+\\)*\\))"
      nil ((0 . ,*git-log-color-brace*)
           (1 . ,*git-log-color-head*)
           (2 . ,*git-log-color-tag*)
           (4 . ,*git-log-color-remote-branch*)
           (6 . ,*git-log-color-branch*))))))

(defun git-log-mode (&optional (arg nil sv))
  "git logモード"
  (interactive)
  (kill-all-local-variables)
  (setf mode-name "GitLog")
  (setf buffer-mode 'git-log-mode)
  (unless (local-variable-p '#0=regexp-keyword-list)
    (make-local-variable '#0#))
  (setf #0# (append #0# (git-log-regexp-keyword-list)))
  (run-hooks '*git-log-mode-hook*))

(provide "xl-git/log")
