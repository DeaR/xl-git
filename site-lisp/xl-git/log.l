;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/log.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-11 20:05:53 DeaR>

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

(export '(*git-log-color-line*
          *git-log-color-sha*
          *git-log-color-brace*
          *git-log-color-head*
          *git-log-color-branch*
          *git-log-color-remote-branch*
          *git-log-color-tag*
          *git-log-default-limit*
          git-log
          git-glog))



(defvar *git-log-color-line* '(:color 1)
  "graph log�̐��̐F")

(defvar *git-log-color-sha* '(:color 3)
  "log��SHA�̐F")

(defvar *git-log-color-brace* '(:color 3)
  "log�̊��ʂ̐F")

(defvar *git-log-color-head* '(:color 6 0 :bold)
  "log��HEAD�̐F")

(defvar *git-log-color-branch* '(:color 2 0 :bold)
  "log�̃u�����`���̐F")

(defvar *git-log-color-remote-branch* '(:color 1 0 :bold)
  "log�̃����[�g�u�����`���̐F")

(defvar *git-log-color-tag* '(:color 3 0 :bold)
  "log�̃^�O���̐F")

(defvar *git-log-default-limit* 100
  "log�̃f�t�H���g����")



(defun git-log-mode (&key
                     (directory (default-directory))
                     (encoding *git-process-encoding*)
                     (eol-code *git-process-eol-code*))
  "git log�o�̓��[�h"
  (git-output-mode :directory directory
                   :encoding encoding
                   :eol-code eol-code)
  (make-local-variable 'regexp-keyword-list)
  (setf regexp-keyword-list
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
                 (6 . ,*git-log-color-branch*)))))))

(defun git-log ()
  "Show commit logs."
  (interactive)
  (git-command-wrapper (list "log" (format nil "-n ~D" *git-log-default-limit*))
                       :mode #'git-log-mode))

(defun git-glog ()
  "Show commit logs.
Draw a text-based graphical representation of the commit history on the left hand side of the output. This may cause extra lines to be printed in between commits, in order for the graph history to be drawn properly."
  (interactive)
  (git-command-wrapper (list "log" (format nil "-n ~D" *git-log-default-limit*)
                             "--graph" "--oneline" "--decorate" "--branches")
                       :mode #'git-log-mode))

(provide "xl-git/log")