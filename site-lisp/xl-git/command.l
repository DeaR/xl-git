;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/command.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-11 20:02:37 DeaR>

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
  (require "xl-git/utils")
  (require "xl-git/output"))

(in-package :git)

(export '(*git-output-bufname*
          *git-output-split-vertical-p*
          define-git-command
          git-add
          git-bisect
          git-branch
          git-checkout
          git-clone
          git-commit
          git-commit-all
          git-commit-amend
          git-diff
          git-diff-file
          git-fetch
          git-grep
          git-help
          git-init
          ; git-log
          ; git-glog
          git-merge
          git-mv
          git-pull
          git-push
          git-rebase
          git-reset
          git-rm
          git-show
          git-status
          git-tag))



(defvar *git-output-bufname* "*Git*"
  "出力バッファ名")

(defvar *git-output-split-vertical-p* t
  "出力バッファは縦に分割する")



(defmacro define-git-command (command &key symbol document prompt file-arg mode)
  "シンプルなgitコマンド生成"
  `(let ((symbol (concat "git-"
                         (if ',symbol
                             (symbol-name ',symbol)
                           (if (listp ,command)
                               (format nil "~{~A~}" ,command)
                             (substitute-string ,command " " ""))))))
     (setf (symbol-function (intern symbol :git))
           #'(lambda ()
               ,document
               (interactive)
               (git::git-command-wrapper ,command
                                         :prompt ,prompt
                                         :file-arg ,file-arg
                                         :mode ,mode)))))
(setf (get 'define-git-command 'lisp-indent-hook) 'defun)

(defun git-command-wrapper (command &key prompt file-arg
                                    (mode #'git-output-mode))
  "シンプルなgitコマンド実体"
  (let ((args (if (or prompt
                      *prefix-args*
                      (not (file-visited-p)))
                  (read-string (if (listp command)
                                   (format nil "git~{ ~A~}: " command)
                                 (format nil "git ~A: " command)))
                (if file-arg
                    (format nil "\"~A\"" (file-namestring (get-buffer-file-name)))
                  "")))
        (buffer (get-buffer-create *git-output-bufname*)))
    (erase-buffer buffer)
    (git-make-process (if (listp command)
                          (append command (list args))
                        (format nil "~A ~A" command args))
                      :output buffer)
    (unless (or (get-buffer-window buffer)
                (> (count-windows) 1))
      (split-window nil *git-output-split-vertical-p*))
    (pop-to-buffer buffer nil *git-output-split-vertical-p*)
    (funcall mode)))

(define-git-command '("add")
  :document "Add file contents to the index."
  :file-arg t)

(define-git-command '("bisect")
  :document "Find by binary search the change that introduced a bug."
  :prompt t)

(define-git-command '("branch")
  :document "List, create, or delete branches.")

(define-git-command '("checkout")
  :document "Checkout a branch or paths to the working tree.")

(define-git-command '("clone")
  :document "Clone a repository into a new directory."
  :prompt t)

(define-git-command '("commit")
  :document "Record changes to the repository.")

(define-git-command '("commit" "-a")
  :symbol #:commit-all
  :document "Record changes to the repository.
Tell the command to automatically stage files that have been modified and deleted, but new files you have not told git about are not affected.")

(define-git-command '("commit" "--amend")
  :symbol #:commit-amend
  :document "Record changes to the repository.
Used to amend the tip of the current branch. Prepare the tree object you would want to replace the latest commit as usual (this includes the usual -i/-o and explicit paths), and the commit log editor is seeded with the commit message from the tip of the current branch. The commit you create replaces the current tip - if it was a merge, it will have the parents of the current tip as parents - so the current top commit is discarded.")

(define-git-command '("diff")
  :document "Show changes between commits, commit and working tree, etc."
  :mode #'git-diff-mode)

(define-git-command '("diff")
  :symbol #:diff-file
  :document "Show changes between commits, commit and working tree, etc."
  :file-arg t
  :mode #'git-diff-mode)

(define-git-command '("fetch")
  :document "Download objects and refs from another repository.")

(define-git-command '("grep")
  :document "Print lines matching a pattern.")

(define-git-command '("help")
  :document "display help information about git.")

(define-git-command '("init")
  :document "Create an empty git repository or reinitialize an existing one.")

; (define-git-command '("log")
;   :document "Show commit logs."
;   :mode #'git-log-mode)

; (define-git-command '("log" "--graph" "--oneline" "--decorate" "--branches")
;   :symbol #:glog
;   :document "Show commit logs."
;   :mode #'git-log-mode)

(define-git-command '("merge")
  :document "Join two or more development histories together.")

(define-git-command '("mv")
  :document "Move or rename a file, a directory, or a symlink.")

(define-git-command '("pull")
  :document "Fetch from and merge with another repository or a local branch.")

(define-git-command '("push")
  :document "Update remote refs along with associated objects.")

(define-git-command '("rebase")
  :document "Forward-port local commits to the updated upstream head.")

(define-git-command '("reset")
  :document "Reset current HEAD to the specified state.")

(define-git-command '("rm")
  :document "Remove files from the working tree and from the index.")

(define-git-command '("show")
  :document "Show various types of objects.")

(define-git-command '("status")
  :document "Show the working tree status."
  :mode #'git-status-mode)

(define-git-command '("tag")
  :document "Create, list, delete or verify a tag object signed with GPG.")



(provide "xl-git/command")
