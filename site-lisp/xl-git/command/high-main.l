;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/command/high-main.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-20 19:22:11 DeaR>

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
  (require "xl-git/branch")
  (require "xl-git/diff")
  (require "xl-git/log")
  (require "xl-git/status"))

(in-package :git)

(export '(git
          git-add
          git-add-file
          git-am
          git-archive
          git-bisect
          git-branch
          git-bundle
          git-checkout
          git-checkout-file
          git-cherry-pick
          git-clean
          git-clone
          git-commit
          git-describe
          git-diff
          git-diff-file
          git-fetch
          git-format-patch
          git-gc
          git-glog
          git-grep
          git-init
          git-log
          git-merge
          git-mv
          git-mv-file
          git-notes
          git-pull
          git-push
          git-push-current
          git-push-matching
          git-push-tracking
          git-rebase
          git-reset
          git-reset-file
          git-revert
          git-rm
          git-rm-file
          git-shortlog
          git-show
          git-stash
          ; git-status
          git-submodule
          git-tag))



(define-git-command nil
  (:documentation "Git is a fast, scalable, distributed revision control system with
an unusually rich command set that provides both high-level operations and full access to internals.")
  (:completion "--version" "--help" "-c" "--exec-path" "--html-path" "--man-path" "--info-path"
   "-p" "--paginate" "--no-pager" "--git-dir=" "--work-tree=" "--bare" "--no-replace-objects"))

(define-git-command ("add")
  (:documentation "Add file contents to the index.")
  (:completion "-n" "--dry-run" "-v" "--verbose" "-f" "--force" "-i" "--interactive" "-p" "--patch"
   "-e, --edit" "-u" "--update" "-A" "--all" "-N" "--intent-to-add" "--refresh" "--ignore-errors"
   "--ignore-missing" "--"))

(define-git-command ("add")
  (:name :git-add-file)
  (:documentation "Add file contents to the index.")
  (:completion "-n" "--dry-run" "-v" "--verbose" "-f" "--force" "-i" "--interactive" "-p" "--patch"
   "-e, --edit" "-u" "--update" "-A" "--all" "-N" "--intent-to-add" "--refresh" "--ignore-errors"
   "--ignore-missing" "--")
  (:file-arg t))

(define-git-command ("am")
  (:documentation "Apply a series of patches from a mailbox.")
  (:completion "-s" "--signoff" "-k" "--keep" "--keep-cr" "--no-keep-cr" "-c" "--scissors"
   "--no-scissors" "-q" "--quiet" "-u" "--utf8" "--no-utf8" "-3" "--3way" "--ignore-date"
   "--ignore-space-change" "--ignore-whitespace" "--whitespace=" "-C" "-p" "--directory="
   "--reject" "-i" "--interactive" "--committer-date-is-author-date" "--ignore-date" "--skip"
   "--continue" "-r" "--resolved" "--resolvemsg=" "--abort"))

(define-git-command ("archive")
  (:documentation "Create an archive of files from a named tree.")
  (:completion "--format=" "-l" "--list" "-v" "--verbose" "--prefix=" "-o" "--output="
   "--worktree-attributes" "--remote=" "--exec="))

(define-git-command ("bisect")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion "bad" "good" "help" "log" "replay" "reset" "run" "skip" "start" "--no-checkout" "view" "visualize" "-p" "--stat"))

(define-git-command ("branch")
  (:documentation "List, create, or delete branches.")
  (:completion "-d" "-D" "-l" "-f" "--force" "-m" "-M" "--color" "--no-color" "-r" "-a"
   "-v" "--verbose" "--abbrev=" "--no-abbrev" "-t" "--track" "--no-track" "--set-upstream"
   "--contains" "--merged" "--no-merged")
  (:mode git-branch-mode))

(define-git-command ("bundle")
  (:documentation "Move objects and refs by archive.")
  (:completion ))

(define-git-command ("checkout")
  (:documentation "Checkout a branch or paths to the working tree.")
  (:completion ))

(define-git-command ("checkout")
  (:name :git-checkout-file)
  (:documentation "Checkout a branch or paths to the working tree.")
  (:completion )
  (:file-arg t))

(define-git-command ("cherry-pick")
  (:documentation "Apply the changes introduced by some existing commits.")
  (:completion ))

(define-git-command ("clean")
  (:documentation "Remove untracked files from the working tree.")
  (:completion ))

(define-git-command ("clone")
  (:documentation "Clone a repository into a new directory.")
  (:completion )
  (:dir-prompt t)
  (:no-std-handles t))

(define-git-command ("commit")
  (:documentation "Record changes to the repository.")
  (:completion ))

(define-git-command ("describe")
  (:documentation "Show the most recent tag that is reachable from a commit.")
  (:completion ))

(define-git-command ("diff")
  (:documentation "Show changes between commits, commit and working tree, etc.")
  (:completion )
  (:mode git-diff-mode))

(define-git-command ("diff")
  (:name :git-diff-file)
  (:documentation "Show changes between commits, commit and working tree, etc.")
  (:completion )
  (:file-arg t)
  (:mode git-diff-mode))

(define-git-command ("fetch")
  (:documentation "Download objects and refs from another repository.")
  (:completion )
  (:no-std-handles t))

(define-git-command ("format-patch")
  (:documentation "Prepare patches for e-mail submission.")
  (:completion ))

(define-git-command ("gc")
  (:documentation "Cleanup unnecessary files and optimize the local repository.")
  (:completion ))

(define-git-command ("grep")
  (:documentation "Print lines matching a pattern.")
  (:completion ))

(define-git-command ("init")
  (:documentation "Create an empty git repository or reinitialize an existing one.")
  (:completion )
  (:dir-prompt t))

(define-git-command ("log" (format nil "-~D" *git-log-default-limit*))
  (:name :git-log)
  (:documentation "Show commit logs.")
  (:completion )
  (:mode git-log-mode))

(define-git-command ("log" (format nil "-~D" *git-log-default-limit*)
                     "--graph" "--oneline" "--decorate" "--branches")
  (:name :git-glog)
  (:documentation "Show commit logs.")
  (:completion )
  (:mode git-log-mode))

(define-git-command ("merge")
  (:documentation "Join two or more development histories together.")
  (:completion ))

(define-git-command ("mv")
  (:documentation "Move or rename a file, a directory, or a symlink.")
  (:completion ))

(define-git-command ("mv")
  (:name :git-mv-file)
  (:documentation "Move or rename a file, a directory, or a symlink.")
  (:completion )
  (:file-arg 2))

(define-git-command ("notes")
  (:documentation "Add or inspect object notes.")
  (:completion ))

(define-git-command ("pull")
  (:documentation "Fetch from and merge with another repository or a local branch.")
  (:completion )
  (:no-std-handles t))

(define-git-command ("push")
  (:documentation "Update remote refs along with associated objects.")
  (:completion )
  (:no-std-handles t))

(define-git-command ("push " "matching")
  (:documentation "Update remote refs along with associated objects.

Push all matching branches.")
  (:completion )
  (:no-std-handles t))

(define-git-command ("push" "tracking")
  (:documentation "Update remote refs along with associated objects.

Push the current branch to whatever it is tracking.")
  (:completion )
  (:no-std-handles t))

(define-git-command ("push" "current")
  (:documentation "Update remote refs along with associated objects.

Push the current branch.")
  (:completion )
  (:no-std-handles t))

(define-git-command ("rebase")
  (:documentation "Forward-port local commits to the updated upstream head.")
  (:completion ))

(define-git-command ("reset")
  (:documentation "Reset current HEAD to the specified state.")
  (:completion ))

(define-git-command ("reset")
  (:name :git-reset-file)
  (:documentation "Reset current HEAD to the specified state.")
  (:completion )
  (:file-arg t))

(define-git-command ("revert")
  (:documentation "Revert some existing commits.")
  (:completion ))

(define-git-command ("rm")
  (:documentation "Remove files from the working tree and from the index.")
  (:completion ))

(define-git-command ("rm")
  (:name :git-rm-file)
  (:documentation "Remove files from the working tree and from the index.")
  (:completion )
  (:file-arg t))

(define-git-command ("shortlog")
  (:documentation "Summarize git log output.")
  (:completion ))

(define-git-command ("show")
  (:documentation "Show various types of objects.")
  (:completion ))

(define-git-command ("stash")
  (:documentation "Stash the changes in a dirty working directory away.")
  (:completion ))

; -> xl-git/status.l
; (define-git-command ("status")
;   (:documentation "Show the working tree status.")
;   (:completion "-s" "--short" "-b" "--branch" "--porcelain" "-u" "--untracked-files"
;    "--ignore-submodules" "--ignored" "-z")
;   (:mode git-status-mode))

(define-git-command ("submodule")
  (:documentation "Initialize, update or inspect submodules.")
  (:completion ))

(define-git-command ("tag")
  (:documentation "Create, list, delete or verify a tag object signed with GPG.")
  (:completion ))

(provide "xl-git/command/high-main")
