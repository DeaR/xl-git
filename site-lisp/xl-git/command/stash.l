;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/command/stash.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-20 19:08:38 DeaR>

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

(export '(git-stash-apply
          git-stash-apply
          git-stash-branch
          git-stash-clear
          git-stash-create
          git-stash-drop
          git-stash-list
          git-stash-pop
          git-stash-save
          git-stash-show))



(define-git-command ("stash" "save")
  (:documentation "Stash the changes in a dirty working directory away.

Save your local modifications to a new stash, and run git reset --hard to revert them.
The <message> part is optional and gives the description along with the stashed state.
For quickly making a snapshot, you can omit both \"save\" and <message>,
but giving only <message> does not trigger this action to
prevent a misspelled subcommand from making an unwanted stash.")
  (:completion ))

(define-git-command ("stash" "list")
  (:documentation "Stash the changes in a dirty working directory away.

List the stashes that you currently have.
Each stash is listed with its name
(e.g. stash@{0} is the latest stash, stash@{1} is the one before, etc.),
the name of the branch that was current when the stash was made,
and a short description of the commit the stash was based on.")
  (:completion ))

(define-git-command ("stash" "show")
  (:documentation "Stash the changes in a dirty working directory away.

Show the changes recorded in the stash as a diff between the stashed state and its original parent.
When no <stash> is given, shows the latest one.
By default, the command shows the diffstat, but it will accept any format known to git diff
(e.g., git stash show -p stash@{1} to view the second most recent stash in patch form).")
  (:completion ))

(define-git-command ("stash" "pop")
  (:documentation "Stash the changes in a dirty working directory away.

Remove a single stashed state from the stash list and apply it on top of the current working tree state,
i.e., do the inverse operation of git stash save.
The working directory must match the index.")
  (:completion ))

(define-git-command ("stash" "apply")
  (:documentation "Stash the changes in a dirty working directory away.

Like pop, but do not remove the state from the stash list.")
  (:completion ))

(define-git-command ("stash" "branch")
  (:documentation "Stash the changes in a dirty working directory away.

Creates and checks out a new branch named <branchname> starting from
the commit at which the <stash> was originally created,
applies the changes recorded in <stash> to the new working tree and index,
then drops the <stash> if that completes successfully.
When no <stash> is given, applies the latest one.")
  (:completion ))

(define-git-command ("stash" "clear")
  (:documentation "Stash the changes in a dirty working directory away.

Remove all the stashed states.
Note that those states will then be subject to pruning, and may be impossible to recover
(see Examples below for a possible strategy).")
  (:completion ))

(define-git-command ("stash" "drop")
  (:documentation "Stash the changes in a dirty working directory away.

Remove a single stashed state from the stash list.
When no <stash> is given, it removes the latest one.
i.e. stash@{0}")
  (:completion ))

(define-git-command ("stash" "create")
  (:documentation "Stash the changes in a dirty working directory away.

Create a stash (which is a regular commit object) and return its object name,
without storing it anywhere in the ref namespace.")
  (:completion ))

(provide "xl-git/command/stash")
