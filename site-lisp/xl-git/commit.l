;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/commit.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-12 20:10:34 DeaR>

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

(export '(git-commit
          git-commit-all
          git-commit-amend))



(defvar-local *git-commit-mode* nil
  "git-commit-mode")
(pushnew '(*git-commit-mode* . "Commit") *minor-mode-alist* :key #'first)



(defun git-commit-mode (&optional (arg nil sv))
  "git commitモード"
  (ed::toggle-mode '*git-commit-mode* arg sv))

(defun git-commit ()
  "Record changes to the repository."
  (interactive)
  (git-command-wrapper '("commit")
                       nil :minor-mode #'git-commit-mode))

(defun git-commit-all ()
  "Record changes to the repository.
Tell the command to automatically stage files that have been modified and deleted, but new files you have not told git about are not affected."
  (interactive)
  (git-command-wrapper '("commit" "-a")
                       nil :minor-mode #'git-commit-mode))

(defun git-commit-amend ()
  "Record changes to the repository.
Used to amend the tip of the current branch. Prepare the tree object you would want to replace the latest commit as usual (this includes the usual -i/-o and explicit paths), and the commit log editor is seeded with the commit message from the tip of the current branch. The commit you create replaces the current tip - if it was a merge, it will have the parents of the current tip as parents - so the current top commit is discarded."
  (interactive)
  (git-command-wrapper '("commit" "--amend")
                       nil :minor-mode #'git-commit-mode))

(provide "xl-git/commit")
