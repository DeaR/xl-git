;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/command/high-main.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-20 17:33:52 DeaR>

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
          git-stash-apply
          git-stash-apply
          git-stash-branch
          git-stash-clear
          git-stash-create
          git-stash-drop
          git-stash-list
          git-stash-pop
          git-stash-save
          git-stash-show
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
  (:documentation "Apply a series of patches from a mailbox."))

(define-git-command ("archive")
  (:documentation "Create an archive of files from a named tree."))

(define-git-command ("bisect")
  (:documentation "Find by binary search the change that introduced a bug."))

(define-git-command ("branch")
  (:documentation "List, create, or delete branches.")
  (:mode git-branch-mode))

(define-git-command ("bundle")
\  (:documentation "Move objects and refs by archive."))

(define-git-command ("checkout")
  (:documentation "Checkout a branch or paths to the working tree."))

(define-git-command ("checkout")
  (:name :git-checkout-file)
  (:documentation "Checkout a branch or paths to the working tree.")
  (:file-arg t))

(define-git-command ("cherry-pick")
  (:documentation "Apply the changes introduced by some existing commits."))

(define-git-command ("clean")
  (:documentation "Remove untracked files from the working tree."))

(define-git-command ("clone")
  (:documentation "Clone a repository into a new directory.")
  (:dir-prompt t)
  (:no-std-handles t))

(define-git-command ("commit")
  (:documentation "Record changes to the repository."))

(define-git-command ("describe")
  (:documentation "Show the most recent tag that is reachable from a commit."))

(define-git-command ("diff")
  (:documentation "Show changes between commits, commit and working tree, etc.")
  (:mode git-diff-mode))

(define-git-command ("diff")
  (:name :git-diff-file)
  (:documentation "Show changes between commits, commit and working tree, etc.")
  (:file-arg t)
  (:mode git-diff-mode))

(define-git-command ("fetch")
  (:documentation "Download objects and refs from another repository.")
  (:no-std-handles t))

(define-git-command ("format-patch")
  (:documentation "Prepare patches for e-mail submission."))

(define-git-command ("gc")
  (:documentation "Cleanup unnecessary files and optimize the local repository."))

(define-git-command ("grep")
  (:documentation "Print lines matching a pattern."))

(define-git-command ("init")
  (:documentation "Create an empty git repository or reinitialize an existing one.")
  (:dir-prompt t))

(define-git-command ("log" (format nil "-~D" *git-log-default-limit*))
  (:name :git-log)
  (:documentation "Show commit logs.")
  (:mode git-log-mode))

(define-git-command ("log" (format nil "-~D" *git-log-default-limit*)
                     "--graph" "--oneline" "--decorate" "--branches")
  (:name :git-glog)
  (:documentation "Show commit logs.")
  (:mode git-log-mode))

(define-git-command ("merge")
  (:documentation "Join two or more development histories together."))

(define-git-command ("mv")
  (:documentation "Move or rename a file, a directory, or a symlink."))

(define-git-command ("mv")
  (:name :git-mv-file)
  (:documentation "Move or rename a file, a directory, or a symlink.")
  (:file-arg 2))

(define-git-command ("notes")
  (:documentation "Add or inspect object notes."))

(define-git-command ("pull")
  (:documentation "Fetch from and merge with another repository or a local branch.")
  (:no-std-handles t))

(define-git-command ("push")
  (:documentation "Update remote refs along with associated objects.")
  (:no-std-handles t))

(define-git-command ("push " "matching")
  (:documentation "Update remote refs along with associated objects.

Push all matching branches.")
  (:no-std-handles t))

(define-git-command ("push" "tracking")
  (:documentation "Update remote refs along with associated objects.

Push the current branch to whatever it is tracking.")
  (:no-std-handles t))

(define-git-command ("push" "current")
  (:documentation "Update remote refs along with associated objects.

Push the current branch.")
  (:no-std-handles t))

(define-git-command ("rebase")
  (:documentation "Forward-port local commits to the updated upstream head."))

(define-git-command ("reset")
  (:documentation "Reset current HEAD to the specified state."))

(define-git-command ("reset")
  (:name :git-reset-file)
  (:documentation "Reset current HEAD to the specified state.")
  (:file-arg t))

(define-git-command ("revert")
  (:documentation "Revert some existing commits."))

(define-git-command ("rm")
  (:documentation "Remove files from the working tree and from the index."))

(define-git-command ("rm")
  (:name :git-rm-file)
  (:documentation "Remove files from the working tree and from the index.")
  (:file-arg t))

(define-git-command ("shortlog")
  (:documentation "Summarize git log output."))

(define-git-command ("show")
  (:documentation "Show various types of objects."))

(define-git-command ("stash")
  (:documentation "Stash the changes in a dirty working directory away."))

(define-git-command ("stash" "save")
  (:documentation "Stash the changes in a dirty working directory away.

Save your local modifications to a new stash, and run git reset --hard to revert them.
The <message> part is optional and gives the description along with the stashed state.
For quickly making a snapshot, you can omit both \"save\" and <message>,
but giving only <message> does not trigger this action to
prevent a misspelled subcommand from making an unwanted stash."))

(define-git-command ("stash" "list")
  (:documentation "Stash the changes in a dirty working directory away.

List the stashes that you currently have.
Each stash is listed with its name
(e.g. stash@{0} is the latest stash, stash@{1} is the one before, etc.),
the name of the branch that was current when the stash was made,
and a short description of the commit the stash was based on."))

(define-git-command ("stash" "show")
  (:documentation "Stash the changes in a dirty working directory away.

Show the changes recorded in the stash as a diff between the stashed state and its original parent.
When no <stash> is given, shows the latest one.
By default, the command shows the diffstat, but it will accept any format known to git diff
(e.g., git stash show -p stash@{1} to view the second most recent stash in patch form)."))

(define-git-command ("stash" "pop")
  (:documentation "Stash the changes in a dirty working directory away.

Remove a single stashed state from the stash list and apply it on top of the current working tree state,
i.e., do the inverse operation of git stash save.
The working directory must match the index."))

(define-git-command ("stash" "apply")
  (:documentation "Stash the changes in a dirty working directory away.

Like pop, but do not remove the state from the stash list."))

(define-git-command ("stash" "branch")
  (:documentation "Stash the changes in a dirty working directory away.

Creates and checks out a new branch named <branchname> starting from
the commit at which the <stash> was originally created,
applies the changes recorded in <stash> to the new working tree and index,
then drops the <stash> if that completes successfully.
When no <stash> is given, applies the latest one."))

(define-git-command ("stash" "clear")
  (:documentation "Stash the changes in a dirty working directory away.

Remove all the stashed states.
Note that those states will then be subject to pruning, and may be impossible to recover
(see Examples below for a possible strategy)."))

(define-git-command ("stash" "drop")
  (:documentation "Stash the changes in a dirty working directory away.

Remove a single stashed state from the stash list.
When no <stash> is given, it removes the latest one.
i.e. stash@{0}"))

(define-git-command ("stash" "create")
  (:documentation "Stash the changes in a dirty working directory away.

Create a stash (which is a regular commit object) and return its object name,
without storing it anywhere in the ref namespace."))

; -> xl-git/status.l
; (define-git-command ("status")
;   (:documentation "Show the working tree status.")
;   (:mode git-status-mode))

(define-git-command ("submodule")
  (:documentation "Initialize, update or inspect submodules."))

(define-git-command ("tag")
  (:documentation "Create, list, delete or verify a tag object signed with GPG."))

(provide "xl-git/command/high-main")
