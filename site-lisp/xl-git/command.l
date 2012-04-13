;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/command.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-13 19:22:52 DeaR>

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



(define-git-command nil
  :symbol #:git
  :document "Add file contents to the index."
  :prompt t)

(define-git-command ("add")
  :document "Add file contents to the index."
  :file-arg t)

(define-git-command ("add" "-u")
  :symbol #:git-add-update
  :document "Add file contents to the index.
Only match <filepattern> against already tracked files in the index rather than the working tree.
That means that it will never stage new files, but that it will stage modified new contents of tracked files and that it will remove files from the index if the corresponding files in the working tree have been removed.")

(define-git-command ("add" "-A")
  :symbol #:git-add-all
  :document "Add file contents to the index.
Like -u, but match <filepattern> against files in the working tree in addition to the index.
That means that it will find new files as well as staging modified content and removing files that are no longer in the working tree.")

(define-git-command ("add" "-p")
  :symbol #:git-add-all
  :document "Add file contents to the index.
Interactively choose hunks of patch between the index and the work tree and add them to the index.
This gives the user a chance to review the difference before adding modified contents to the index."
  :no-std-handles t)

(define-git-command ("add")
  :document "Add file contents to the index."
  :file-arg t)

(define-git-command ("bisect")
  :document "Find by binary search the change that introduced a bug."
  :prompt t)

(define-git-command ("branch")
  :document "List, create, or delete branches.")

(define-git-command ("checkout")
  :document "Checkout a branch or paths to the working tree.")

(define-git-command ("checkout")
  :symbol #:git-checkout-file
  :document "Checkout a branch or paths to the working tree."
  :file-arg t)

(define-git-command ("clone")
  :document "Clone a repository into a new directory."
  :prompt t
  :no-std-handles t)

; -> commit.l
; (define-git-command ("commit")
;   :document "Record changes to the repository.")
; 
; (define-git-command ("commit" "-a")
;   :symbol #:git-commit-all
;   :document "Record changes to the repository.
; Tell the command to automatically stage files that have been modified and deleted, but new files you have not told git about are not affected.")
; 
; (define-git-command ("commit" "--amend")
;   :symbol #:git-commit-amend
;   :document "Record changes to the repository.
; Used to amend the tip of the current branch.
; Prepare the tree object you would want to replace the latest commit as usual (this includes the usual -i/-o and explicit paths), and the commit log editor is seeded with the commit message from the tip of the current branch.
; The commit you create replaces the current tip - if it was a merge, it will have the parents of the current tip as parents - so the current top commit is discarded.")

(define-git-command ("commit" "-v")
  :symbol #:git-commit-vervose
  :document "Record changes to the repository.
Show unified diff between the HEAD commit and what would be committed at the bottom of the commit message template.
Note that this diff output doesn’t have its lines prefixed with #."
  :no-std-handles t)

(define-git-command ("diff")
  :document "Show changes between commits, commit and working tree, etc."
  :minor-mode #'git-diff-mode)

(define-git-command ("diff")
  :symbol #:git-diff-file
  :document "Show changes between commits, commit and working tree, etc."
  :file-arg t
  :minor-mode #'git-diff-mode)

(define-git-command ("fetch")
  :document "Download objects and refs from another repository."
  :no-std-handles t)

(define-git-command ("grep")
  :document "Print lines matching a pattern.")

(define-git-command ("help")
  :document "display help information about git.")

(define-git-command ("init")
  :document "Create an empty git repository or reinitialize an existing one.")

; -> log.l
; (define-git-command ("log")
;   :document "Show commit logs."
;   :minor-mode #'git-log-mode)
; 
; (define-git-command ("log" "--graph" "--oneline" "--decorate" "--branches")
;   :symbol #:git-glog
;   :document "Show commit logs."
;   :minor-mode #'git-log-mode)

(define-git-command ("merge")
  :document "Join two or more development histories together.")

(define-git-command ("mv")
  :document "Move or rename a file, a directory, or a symlink."
  :file-arg t)

(define-git-command ("pull")
  :document "Fetch from and merge with another repository or a local branch."
  :no-std-handles t)

(define-git-command ("push")
  :document "Update remote refs along with associated objects."
  :no-std-handles t)

(define-git-command ("push ""matching")
  :symbol #:git-push-matching
  :document "Update remote refs along with associated objects.
Push all matching branches."
  :no-std-handles t)

(define-git-command ("push" "tracking")
  :symbol #:git-push-tracking
  :document "Update remote refs along with associated objects.
Push the current branch to whatever it is tracking."
  :no-std-handles t)

(define-git-command ("push" "current")
  :symbol #:git-push-current
  :document "Update remote refs along with associated objects.
Push the current branch."
  :no-std-handles t)

(define-git-command ("rebase")
  :document "Forward-port local commits to the updated upstream head.")

(define-git-command ("reset")
  :document "Reset current HEAD to the specified state.")

(define-git-command ("rm")
  :document "Remove files from the working tree and from the index."
  :file-arg t)

(define-git-command ("show")
  :document "Show various types of objects."
  :prompt t)

(define-git-command ("stash")
  :document "Stash the changes in a dirty working directory away."
  :prompt t)

(define-git-command ("stash" "save")
  :symbol #:git-stash-save
  :document "Stash the changes in a dirty working directory away.
Save your local modifications to a new stash, and run git reset --hard to revert them.
The <message> part is optional and gives the description along with the stashed state.
For quickly making a snapshot, you can omit both "save" and <message>, but giving only <message> does not trigger this action to prevent a misspelled subcommand from making an unwanted stash.")

(define-git-command ("stash" "list")
  :symbol #:git-stash-list
  :document "Stash the changes in a dirty working directory away.
List the stashes that you currently have.
Each stash is listed with its name (e.g. stash@{0} is the latest stash, stash@{1} is the one before, etc.), the name of the branch that was current when the stash was made, and a short description of the commit the stash was based on.")

(define-git-command ("stash" "show")
  :symbol #:git-stash-show
  :document "Stash the changes in a dirty working directory away.
Show the changes recorded in the stash as a diff between the stashed state and its original parent.
When no <stash> is given, shows the latest one.
By default, the command shows the diffstat, but it will accept any format known to git diff (e.g., git stash show -p stash@{1} to view the second most recent stash in patch form).")

(define-git-command ("stash" "pop")
  :symbol #:git-stash-pop
  :document "Stash the changes in a dirty working directory away.
Remove a single stashed state from the stash list and apply it on top of the current working tree state, i.e., do the inverse operation of git stash save.
The working directory must match the index.")

(define-git-command ("stash" "apply")
  :symbol #:git-stash-apply
  :document "Stash the changes in a dirty working directory away.
Like pop, but do not remove the state from the stash list.")

(define-git-command ("stash" "branch")
  :symbol #:git-stash-branch
  :document "Stash the changes in a dirty working directory away.
Creates and checks out a new branch named <branchname> starting from the commit at which the <stash> was originally created, applies the changes recorded in <stash> to the new working tree and index, then drops the <stash> if that completes successfully.
When no <stash> is given, applies the latest one."
  :prompt t)

(define-git-command ("stash" "clear")
  :symbol #:git-stash-clear
  :document "Stash the changes in a dirty working directory away.
Remove all the stashed states.
Note that those states will then be subject to pruning, and may be impossible to recover (see Examples below for a possible strategy).")

(define-git-command ("stash" "drop")
  :symbol #:git-stash-drop
  :document "Stash the changes in a dirty working directory away.
Remove a single stashed state from the stash list.
When no <stash> is given, it removes the latest one.
i.e. stash@{0}")

(define-git-command ("stash" "create")
  :symbol #:git-stash-create
  :document "Stash the changes in a dirty working directory away.
Create a stash (which is a regular commit object) and return its object name, without storing it anywhere in the ref namespace.")

(define-git-command ("status")
  :document "Show the working tree status."
  :minor-mode #'git-status-mode)

(define-git-command ("tag")
  :document "Create, list, delete or verify a tag object signed with GPG.")



(provide "xl-git/command")
