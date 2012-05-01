;; -*- mode: lisp; package: xl-git; encoding: shift_jis -*-

;; @name        xl-git/command/high-main.lisp
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
  (require "xl-git/utils")
  (require "xl-git/branch")
  (require "xl-git/diff")
  (require "xl-git/log")
  (require "xl-git/status"))

(in-package :xl-git)

(export '(git
          git-add
          git-add-file
          git-am
          git-archive
          git-bisect-bad
          git-bisect-good
          git-bisect-help
          git-bisect-log
          git-bisect-replay
          git-bisect-reset
          git-bisect-run
          git-bisect-skip
          git-bisect-start
          git-bisect-view
          git-bisect-visualize
          git-branch
          git-bundle-create
          git-bundle-listheads
          git-bundle-unbundle
          git-bundle-verify
          git-checkout
          git-checkout-file
          git-cherry-pick
          git-citool
          git-clean
          git-clone
          git-commit
          git-describe
          git-diff
          git-diff-file
          git-fetch
          git-format-patch
          git-gc
          git-grep
          git-gui
          git-gui-blame
          git-gui-browser
          git-gui-citool
          git-init
          git-log
          git-merge
          git-mv
          git-mv-file
          git-notes-add
          git-notes-append
          git-notes-copy
          git-notes-edit
          git-notes-get-ref
          git-notes-list
          git-notes-merge
          git-notes-prune
          git-notes-remove
          git-notes-show
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
          git-submodule-add
          git-submodule-foreach
          git-submodule-init
          git-submodule-status
          git-submodule-summary
          git-submodule-sync
          git-submodule-update
          git-tag
          gitk))



(define-git-command nil
  (:documentation "Git is a fast, scalable, distributed revision control system with
an unusually rich command set that provides both high-level operations and full access to internals.")
  (:completion "--version" "--help" "-c" "--exec-path" "--html-path" "--man-path" "--info-path"
   "-p" "--paginate" "--no-pager" "--git-dir=" "--work-tree=" "--bare" "--no-replace-objects"))

(define-git-command ("add")
  (:documentation "Add file contents to the index.")
  (:completion "-n" "--dry-run" "-v" "--verbose" "-f" "--force" "-i" "--interactive" "-p" "--patch"
   "-e, --edit" "-u" "--update" "-A" "--all" "-N" "--intent-to-add" "--refresh" "--ignore-errors"
   "--ignore-missing"))

(define-git-command ("add")
  (:name :git-add-file)
  (:documentation "Add file contents to the index.")
  (:completion "-n" "--dry-run" "-v" "--verbose" "-f" "--force" "-i" "--interactive" "-p" "--patch"
   "-e, --edit" "-u" "--update" "-A" "--all" "-N" "--intent-to-add" "--refresh" "--ignore-errors"
   "--ignore-missing")
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

(define-git-command ("bisect" "bad")
  (:documentation "Find by binary search the change that introduced a bug."))

(define-git-command ("bisect" "good")
  (:documentation "Find by binary search the change that introduced a bug."))

(define-git-command ("bisect" "help")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:no-prompt t))

(define-git-command ("bisect" "log")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:no-prompt t))

(define-git-command ("bisect" "replay")
  (:documentation "Find by binary search the change that introduced a bug."))

(define-git-command ("bisect" "reset")
  (:documentation "Find by binary search the change that introduced a bug."))

(define-git-command ("bisect" "run")
  (:documentation "Find by binary search the change that introduced a bug."))

(define-git-command ("bisect" "skip")
  (:documentation "Find by binary search the change that introduced a bug."))

(define-git-command ("bisect" "start")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion "--no-checkout"))

(define-git-command ("bisect" "view")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion "-p" "--stat"))

(define-git-command ("bisect" "visualize")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion "-p" "--stat"))

(define-git-command ("branch")
  (:documentation "List, create, or delete branches.")
  (:completion "-d" "-D" "-l" "-f" "--force" "-m" "-M" "--color" "--no-color" "-r" "-a"
   "-v" "--verbose" "--abbrev=" "--no-abbrev" "-t" "--track" "--no-track" "--set-upstream"
   "--contains" "--merged" "--no-merged")
  (:mode git-branch-mode))

(define-git-command ("bundle" "create")
  (:documentation "Move objects and refs by archive.

Used to create a bundle named file. This requires the git-rev-list-args arguments to define the bundle contents."))

(define-git-command ("bundle" "list-heads")
  (:documentation "Move objects and refs by archive.

Lists the references defined in the bundle.
If followed by a list of references, only references matching those given are printed out."))

(define-git-command ("bundle" "unbundle")
  (:documentation "Move objects and refs by archive.

Passes the objects in the bundle to git index-pack for storage in the repository, then prints the names of all defined references.
If a list of references is given, only references matching those in the list are printed.
This command is really plumbing, intended to be called only by git fetch."))

(define-git-command ("bundle" "verify")
  (:documentation "Move objects and refs by archive.

Used to check that a bundle file is valid and will apply cleanly to the current repository.
This includes checks on the bundle format itself as well as checking that the prerequisite commits exist and
are fully linked in the current repository.
git bundle prints a list of missing commits, if any, and exits with a non-zero status."))

(define-git-command ("checkout")
  (:documentation "Checkout a branch or paths to the working tree.")
  (:completion "-q" "--quiet" "-f" "--force" "--ours" "--theirs" "-b" "-B" "-t" "--track"
   "-l" "--detach" "--orphan" "-m" "--merge" "--conflict=" "-p" "--patch"))

(define-git-command ("checkout")
  (:name :git-checkout-file)
  (:documentation "Checkout a branch or paths to the working tree.")
  (:completion "-q" "--quiet" "-f" "--force" "--ours" "--theirs" "-b" "-B" "-t" "--track"
   "-l" "--detach" "--orphan" "-m" "--merge" "--conflict=" "-p" "--patch")
  (:file-arg t))

(define-git-command ("cherry-pick")
  (:documentation "Apply the changes introduced by some existing commits.")
  (:completion "-e" "--edit" "-x" "-r" "-m parent-number" "--mainline parent-number" "-n" "--no-commit"
   "-s" "--signoff" "--ff" "--strategy=" "-X" "--strategy-option="))

(define-git-command ("citool")
  (:documentation "Graphical alternative to git-commit.")
  (:no-std-handles t :hide))

(define-git-command ("clean")
  (:documentation "Remove untracked files from the working tree.")
  (:completion "-d" "-f" "--force" "-n" "--dry-run" "-q" "--quiet" "-e" "--exclude=" "-x" "-X"))

(define-git-command ("clone")
  (:documentation "Clone a repository into a new directory.")
  (:completion "--local" "-l" "--no-hardlinks" "--shared" "-s" "--reference" "--quiet" "-q"
   "--verbose" "-v" "--progress" "--no-checkout" "-n" "--bare" "--mirror" "--origin" "-o"
   "--branch" "-b" "--upload-pack" "-u" "--template=" "--config" "-c" "--depth"
   "--recursive" "--recurse-submodules" "--separate-git-dir=")
  (:dir-prompt t)
  (:no-std-handles t))

(define-git-command ("commit")
  (:documentation "Record changes to the repository.")
  (:completion "-a" "--all" "-p" "--patch" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--fixup=" "--squash=" "--reset-author" "--short" "--porcelain" "-z" "-F" "--file=" "--author="
   "--date=" "-m" "--message=" "-t" "--template=" "-s" "--signoff" "-n" "--no-verify" "--allow-empty"
   "--allow-empty-message" "--cleanup=" "-e" "--edit" "--amend" "-i" "--include" "-o" "--only"
   "-u" "--untracked-files" "-v" "--verbose" "-q" "--quiet" "--dry-run" "--status" "--no-status"))

(define-git-command ("describe")
  (:documentation "Show the most recent tag that is reachable from a commit.")
  (:completion "--dirty" "--all" "--tags" "--contains" "--abbrev=" "--candidates=" "--exact-match"
   "--debug" "--long" "--match" "--always"))

(define-git-command ("diff")
  (:documentation "Show changes between commits, commit and working tree, etc.")
  (:completion "-p" "-u" "--patch" "-U" "--unified=" "--raw" "--patch-with-raw" "--patience" "--stat"
   "--numstat" "--shortstat" "--dirstat" "--summary" "--patch-with-stat" "-z" "--name-only" "--name-status"
   "--submodule" "--color" "--no-color" "--word-diff" "--word-diff-regex=" "--color-words" "--no-renames"
   "--check" "--full-index" "--binary" "--abbrev" "-B" "--break-rewrites" "-M" "--find-renames" "-C" "--find-copies"
   "--find-copies-harder" "-D" "--irreversible-delete" "-l" "--diff-filter=" "-S" "-G" "--pickaxe-all"
   "--pickaxe-regex" "-O" "-R" "--relative" "-a" "--text" "--ignore-space-at-eol" "-b" "--ignore-space-change"
   "-w" "--ignore-all-space" "--inter-hunk-context=" "--exit-code" "--quiet" "--ext-diff" "--no-ext-diff"
   "--textconv" "--no-textconv" "--ignore-submodules" "--src-prefix=" "--dst-prefix=" "--no-prefix")
  (:mode git-diff-mode))

(define-git-command ("diff")
  (:name :git-diff-file)
  (:documentation "Show changes between commits, commit and working tree, etc.")
  (:completion "-p" "-u" "--patch" "-U" "--unified=" "--raw" "--patch-with-raw" "--patience" "--stat"
   "--numstat" "--shortstat" "--dirstat" "--summary" "--patch-with-stat" "-z" "--name-only" "--name-status"
   "--submodule" "--color" "--no-color" "--word-diff" "--word-diff-regex=" "--color-words" "--no-renames"
   "--check" "--full-index" "--binary" "--abbrev" "-B" "--break-rewrites" "-M" "--find-renames" "-C" "--find-copies"
   "--find-copies-harder" "-D" "--irreversible-delete" "-l" "--diff-filter=" "-S" "-G" "--pickaxe-all"
   "--pickaxe-regex" "-O" "-R" "--relative" "-a" "--text" "--ignore-space-at-eol" "-b" "--ignore-space-change"
   "-w" "--ignore-all-space" "--inter-hunk-context=" "--exit-code" "--quiet" "--ext-diff" "--no-ext-diff"
   "--textconv" "--no-textconv" "--ignore-submodules" "--src-prefix=" "--dst-prefix=" "--no-prefix")
  (:file-arg t)
  (:mode git-diff-mode))

(define-git-command ("fetch")
  (:documentation "Download objects and refs from another repository.")
  (:completion "--all" "-a" "--append" "--depth=" "--dry-run" "-f" "--force" "-k" "--keep" "--multiple"
   "-p" "--prune" "-n" "--no-tags" "-t" "--tags" "--recurse-submodules" "--no-recurse-submodules"
   "--submodule-prefix=" "--recurse-submodules-default=" "-u" "--update-head-ok" "--upload-pack"
   "-q" "--quiet" "-v" "--verbose" "--progress")
  (:no-std-handles t))

(define-git-command ("format-patch")
  (:documentation "Prepare patches for e-mail submission.")
  (:completion "-p" "--no-stat" "-U" "--unified=" "--patience" "--stat" "--numstat" "--shortstat"
   "--dirstat" "--summary" "--no-renames" "--full-index" "--binary" "--abbrev" "-B" "--break-rewrites"
   "-M" "--find-renames" "-C" "--find-copies" "--find-copies-harder" "-D" "--irreversible-delete" "-l"
   "-O" "-a" "--text" "--ignore-space-at-eol" "-b" "--ignore-space-change" "-w" "--ignore-all-space"
   "--inter-hunk-context=" "--ext-diff" "--no-ext-diff" "--textconv" "--no-textconv" "--ignore-submodules"
   "--src-prefix=" "--dst-prefix=" "--no-prefix" "-o" "--output-directory" "-n" "--numbered" "-N" "--no-numbered"
   "--start-number" "--numbered-files" "-k" "--keep-subject" "-s" "--signoff" "--stdout" "--attach" "--no-attach"
   "--inline" "--thread" "--no-thread" "--in-reply-to=Message-Id" "--ignore-if-in-upstream" "--subject-prefix="
   "--to=" "--cc=" "--add-header=" "--cover-letter" "---signature=" "--no-signature=" "--suffix=" "--quiet"
   "--no-binary" "--root"))

(define-git-command ("gc")
  (:documentation "Cleanup unnecessary files and optimize the local repository.")
  (:completion "--aggressive" "--auto" "--prune=" "--no-prune" "--quiet"))

(define-git-command ("grep")
  (:documentation "Print lines matching a pattern.")
  (:completion "--cached" "--no-index" "-a" "--text" "-i" "--ignore-case" "-I" "--max-depth" "-w" "--word-regexp"
   "-v" "--invert-match" "-h" "-H" "--full-name" "-E" "--extended-regexp" "-G" "--basic-regexp" "-P" "--perl-regexp"
   "-F" "--fixed-strings" "-n" "--line-number" "-l" "--files-with-matches" "--name-only" "-L" "--files-without-match"
   "-O" "--open-files-in-pager" "-z" "--null" "-c" "--count" "--color" "--no-color" "--break" "--heading"
   "-A" "-B" "-C" "-p" "--show-function" "-f" "-e" "--and" "--or" "--not" "--all-match" "-q" "--quiet"))

(define-git-command ("gui")
  (:documentation "A portable graphical interface to Git.")
  (:completion "blame" "browser" "citool")
  (:no-std-handles t :hide))

(define-git-command ("gui" "blame")
  (:documentation "A portable graphical interface to Git.

Start a blame viewer on the specified file on the given version
(or working directory if not specified).")
  (:no-std-handles t :hide))

(define-git-command ("gui" "browser")
  (:documentation "A portable graphical interface to Git.

Start a tree browser showing all files in the specified commit (or HEAD by default).
Files selected through the browser are opened in the blame viewer.")
  (:no-std-handles t :hide))

(define-git-command ("gui" "citool")
  (:documentation "A portable graphical interface to Git.

Start git gui and arrange to make exactly one commit before exiting and returning to the shell.
The interface is limited to only commit actions,
slightly reducing the application’s startup time and simplifying the menubar.")
  (:no-std-handles t :hide))

(define-git-command ("init")
  (:documentation "Create an empty git repository or reinitialize an existing one.")
  (:completion "-q" "--quiet" "--bare" "--template=" "--separate-git-dir=" "--shared")
  (:dir-prompt t))

(define-git-command ("log" (format nil "-~D" *git-log-default-limit*))
  (:name :git-log)
  (:documentation "Show commit logs.")
  (:completion "--follow" "--no-decorate" "--decorate" "--source" "--full-diff" "--log-size" "-n"
   "--max-count=" "--skip=" "--since=" "--after=" "--until=" "--before" "--author" "--committer="
   "--grep=" "--all-match" "-i" "--regexp-ignore-case" "-E" "--extended-regexp" "-F" "--fixed-strings"
   "--remove-empty" "--merges" "--no-merges" "--min-parents=" "--max-parents=" "--no-min-parents"
   "--no-max-parents" "--first-parent" "--not" "--all" "--branches" "--tags" "--remotes" "--glob="
   "--ignore-missing" "--bisect" "--stdin" "--cherry-mark" "--cherry-pick" "--left-only" "--right-only"
   "--cherry" "-g" "--walk-reflogs" "--merge" "--boundary" "--simplify-by-decoration" "--full-history"
   "--dense" "--sparse" "--simplify-merges" "--ancestry-path" "--topo-order" "--date-order" "--reverse"
   "--objects" "--objects-edge" "--unpacked" "--no-walk" "--do-walk" "--pretty" "--format=" "--abbrev-commit"
   "--no-abbrev-commit" "--oneline" "--encoding" "--notes" "--no-notes" "--show-notes" "--standard-notes"
   "--no-standard-notes" "--relative-date" "--date=" "--parents" "--children" "--left-right" "--graph"
   "-c" "--cc" "-m" "-r" "-t" "-s" "-p" "-u" "--patch" "-U" "--unified=" "--raw" "--patch-with-raw"
   "--patience" "--stat" "--numstat" "--shortstat" "--dirstat" "--summary" "--patch-with-stat" "-z"
   "--name-only" "--name-status" "--submodule" "--color" "--no-color" "--word-diff" "--word-diff-regex="
   "--color-words" "--no-renames" "--check" "--full-index" "--binary" "--abbrev" "-B" "-M" "--find-renames"
   "-C" "--find-copies" "--find-copies-harder" "-D" "--irreversible-delete" "-l" "--diff-dilter=" "-S" "-G"
   "--pickaxe-all" "--pickaxe-regex" "-O" "-R" "--relative" "-a" "--text" "--ignore-space-at-eol" "-b"
   "--ignore-space-change" "-w" "--ignore-all-space" "--inter-hunk-context=" "--exit-code" "--quiet"
   "--ext-diff" "--no-ext-diff" "--textconv" "--no-textconv" "--ignore-submodules" "--src-prefix="
   "--dst-prefix=" "--no-prefix")
  (:mode git-log-mode))

(define-git-command ("merge")
  (:documentation "Join two or more development histories together.")
  (:completion "--commit" "--no-commit" "--ff" "--no-ff" "--log" "--no-log" "--stat" "-n" "--no-stat"
   "--squash" "--no-squash" "--ff-only" "-s" "--strategy=" "-X" "--strategy-option=" "--summary"
   "--no-summary" "-q" "--quiet" "-v" "--verbose" "--progress" "--no-progress" "-m" "--rerere-autoupdate"
   "--no-rerere-autoupdate" "--abort"))

(define-git-command ("mv")
  (:documentation "Move or rename a file, a directory, or a symlink.")
  (:completion "-f" "--force" "-k" "-n" "--dry-run"))

(define-git-command ("mv")
  (:name :git-mv-file)
  (:documentation "Move or rename a file, a directory, or a symlink.")
  (:completion "-f" "--force" "-k" "-n" "--dry-run")
  (:file-arg 2))

(define-git-command ("notes" "add")
  (:documentation "Add or inspect object notes.

Add notes for a given object (defaults to HEAD).
Abort if the object already has notes (use -f to overwrite existing notes).
However, if you’re using add interactively (using an editor to supply the notes contents),
then - instead of aborting - the existing notes will be opened in the editor (like the edit subcommand).")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "append")
  (:documentation "Add or inspect object notes.

Append to the notes of an existing object (defaults to HEAD).
Creates a new notes object if needed.")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "copy")
  (:documentation "Add or inspect object notes.

Copy the notes for the first object onto the second object.
Abort if the second object already has notes, or if the first object has none
(use -f to overwrite existing notes to the second object).
This subcommand is equivalent to: git notes add [-f] -C $(git notes list <from-object>) <to-object>")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "edit")
  (:documentation "Add or inspect object notes.

Edit the notes for a given object (defaults to HEAD).")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "get-ref")
  (:documentation "Add or inspect object notes.

Print the current notes ref.
This provides an easy way to retrieve the current notes ref (e.g. from scripts).")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "list")
  (:documentation "Add or inspect object notes.

List the notes object for a given object.
If no object is given, show a list of all note objects and the objects they annotate
(in the format \"<note object> <annotated object>\").
This is the default subcommand if no subcommand is given.")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "merge")
  (:documentation "Add or inspect object notes.

Merge the given notes ref into the current notes ref.
This will try to merge the changes made by the given notes ref (called \"remote\")
since the merge-base (if any) into the current notes ref (called \"local\").")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "prune")
  (:documentation "Add or inspect object notes.

Remove all notes for non-existing/unreachable objects.")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "remove")
  (:documentation "Add or inspect object notes.

Remove the notes for given objects (defaults to HEAD).
When giving zero or one object from the command line,
this is equivalent to specifying an empty note message to the edit subcommand.")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("notes" "show")
  (:documentation "Add or inspect object notes.

Show the notes for a given object (defaults to HEAD).")
  (:completion "-f" "--force" "-m" "--message=" "-F" "--file=" "-C" "--reuse-message=" "-c" "--reedit-message="
   "--ref" "--ignore-missing" "--stdin" "-n" "--dry-run" "-s" "--strategy=" "--commit" "--abort"
   "-q" "--quiet" "-v" "--verbose"))

(define-git-command ("pull")
  (:documentation "Fetch from and merge with another repository or a local branch.")
  (:completion "-q" "--quiet" "-v" "--verbose" "--recurse-submodules" "--no-recurse-submodules"
   "--commit" "--no-commit" "--ff" "--no-ff" "--log" "--no-log" "--stat" "-n" "--no-stat" "--squash" "--no-squash"
   "--ff-only" "-s" "--strategy=" "-X" "--strategy-option=" "--summary" "--no-summary" "-q" "--quiet"
   "-v" "--verbose" "--progress" "--no-progress" "--rebase" "--no-rebase" "--all" "-a" "--append" "--depth="
   "-f" "--force" "-k" "--keep" "--no-tags" "-u" "--update-head-ok" "--upload-pack" "--progress")
  (:no-std-handles t))

(define-git-command ("push")
  (:documentation "Update remote refs along with associated objects.")
  (:completion "--all" "--mirror" "-n" "--dry-run" "--porcelain" "--delete" "--tags" "--receive-pack="
   "--exec=" "-f" "--force" "--repo=" "-u" "--set-upstream" "--thin" "--no-thin" "-q" "--quiet"
   "-v" "--verbose" "--progress")
  (:no-std-handles t))

(define-git-command ("push " "matching")
  (:documentation "Update remote refs along with associated objects.

Push all matching branches.")
  (:completion "--all" "--mirror" "-n" "--dry-run" "--porcelain" "--delete" "--tags" "--receive-pack="
   "--exec=" "-f" "--force" "--repo=" "-u" "--set-upstream" "--thin" "--no-thin" "-q" "--quiet"
   "-v" "--verbose" "--progress")
  (:no-std-handles t))

(define-git-command ("push" "tracking")
  (:documentation "Update remote refs along with associated objects.

Push the current branch to whatever it is tracking.")
  (:completion "--all" "--mirror" "-n" "--dry-run" "--porcelain" "--delete" "--tags" "--receive-pack="
   "--exec=" "-f" "--force" "--repo=" "-u" "--set-upstream" "--thin" "--no-thin" "-q" "--quiet"
   "-v" "--verbose" "--progress")
  (:no-std-handles t))

(define-git-command ("push" "current")
  (:documentation "Update remote refs along with associated objects.

Push the current branch.")
  (:completion "--all" "--mirror" "-n" "--dry-run" "--porcelain" "--delete" "--tags" "--receive-pack="
   "--exec=" "-f" "--force" "--repo=" "-u" "--set-upstream" "--thin" "--no-thin" "-q" "--quiet"
   "-v" "--verbose" "--progress")
  (:no-std-handles t))

(define-git-command ("rebase")
  (:documentation "Forward-port local commits to the updated upstream head.")
  (:completion "--continue" "--abort" "--skip" "-m" "--merge" "-s" "--strategy=" "-X" "--strategy-option="
   "-q" "--quiet" "-v" "--verbose" "--stat" "-n" "--no-stat" "--no-verify" "--verify" "-C" "-f" "--force-rebase"
   "--ignore-whitespace" "--whitespace=" "--committer-date-is-author-date" "--ignore-date" "-i" "--interactive"
   "-p" "--preserve-merges" "--root" "--autosquash" "--no-autosquash" "--no-ff"))

(define-git-command ("reset")
  (:documentation "Reset current HEAD to the specified state.")
  (:completion "-q" "--quit" "--soft" "--mixed" "--hard" "--merge" "--keep"))

(define-git-command ("reset")
  (:name :git-reset-file)
  (:documentation "Reset current HEAD to the specified state.")
  (:completion "-q" "--quit" "--soft" "--mixed" "--hard" "--merge" "--keep")
  (:file-arg t))

(define-git-command ("revert")
  (:documentation "Revert some existing commits.")
  (:completion "-e" "--edit" "-m" "--mainline" "--no-edit" "-n" "--no-commit" "-s" "--signoff"
   "--strategy=" "-X<option>" "--strategy-option="))

(define-git-command ("rm")
  (:documentation "Remove files from the working tree and from the index.")
  (:completion "-f" "--force" "-n" "--dry-run" "-r" "--cached" "--ignore-unmatch" "-q" "--quiet"))

(define-git-command ("rm")
  (:name :git-rm-file)
  (:documentation "Remove files from the working tree and from the index.")
  (:completion "-f" "--force" "-n" "--dry-run" "-r" "--cached" "--ignore-unmatch" "-q" "--quiet")
  (:file-arg t))

(define-git-command ("shortlog")
  (:documentation "Summarize git log output.")
  (:completion "-h" "--help" "-n" "--numbered" "-s" "--summary" "-e" "--email" "--format" "-w"))

(define-git-command ("show")
  (:documentation "Show various types of objects.")
  (:completion "--pretty" "--format=" "--abbrev-commit" "--no-abbrev-commit" "--oneline"
   "--encoding" "--notes" "--no-notes" "--show-notes" "--standard-notes" "--no-standard-notes"))

(define-git-command ("stash" "apply")
  (:documentation "Stash the changes in a dirty working directory away.

Like pop, but do not remove the state from the stash list.")
  (:completion "--index" "-q" "--quiet"))

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

(define-git-command ("stash" "create")
  (:documentation "Stash the changes in a dirty working directory away.

Create a stash (which is a regular commit object) and return its object name,
without storing it anywhere in the ref namespace."))

(define-git-command ("stash" "drop")
  (:documentation "Stash the changes in a dirty working directory away.

Remove a single stashed state from the stash list.
When no <stash> is given, it removes the latest one.
i.e. stash@{0}")
  (:completion "-q" "--quiet"))

(define-git-command ("stash" "list")
  (:documentation "Stash the changes in a dirty working directory away.

List the stashes that you currently have.
Each stash is listed with its name
(e.g. stash@{0} is the latest stash, stash@{1} is the one before, etc.),
the name of the branch that was current when the stash was made,
and a short description of the commit the stash was based on."))

(define-git-command ("stash" "pop")
  (:documentation "Stash the changes in a dirty working directory away.

Remove a single stashed state from the stash list and apply it on top of the current working tree state,
i.e., do the inverse operation of git stash save.
The working directory must match the index.")
  (:completion "--index" "-q" "--quiet"))

(define-git-command ("stash" "save")
  (:documentation "Stash the changes in a dirty working directory away.

Save your local modifications to a new stash, and run git reset --hard to revert them.
The <message> part is optional and gives the description along with the stashed state.
For quickly making a snapshot, you can omit both \"save\" and <message>,
but giving only <message> does not trigger this action to
prevent a misspelled subcommand from making an unwanted stash.")
  (:completion "-p" "--patch" "--keep-index" "--no-keep-index" "-u" "--include-untracked" "-a" "--all"
   "-q" "--quiet"))

(define-git-command ("stash" "show")
  (:documentation "Stash the changes in a dirty working directory away.

Show the changes recorded in the stash as a diff between the stashed state and its original parent.
When no <stash> is given, shows the latest one.
By default, the command shows the diffstat, but it will accept any format known to git diff
(e.g., git stash show -p stash@{1} to view the second most recent stash in patch form)."))

; -> xl-git/status.lisp
; (define-git-command ("status")
;   (:documentation "Show the working tree status.")
;   (:completion "-s" "--short" "-b" "--branch" "--porcelain" "-u" "--untracked-files"
;    "--ignore-submodules" "--ignored" "-z")
;   (:mode git-status-mode))

(define-git-command ("submodule" "add")
  (:documentation "Initialize, update or inspect submodules.

Add the given repository as a submodule at the given path to the changeset to be committed next to
the current project: the current project is termed the \"superproject\".")
  (:completion "-q" "--quiet" "-b" "--branch" "-f" "--force" "--cached" "--files" "-n" "--summary-limit"
   "-N" "--no-fetch" "--merge" "--rebase" "--reference" "--recursive"))

(define-git-command ("submodule" "foreach")
  (:documentation "Initialize, update or inspect submodules.

Evaluates an arbitrary shell command in each checked out submodule.
The command has access to the variables $name, $path, $sha1 and $toplevel: $name is the name of the relevant
submodule section in .gitmodules, $path is the name of the submodule directory relative to the superproject,
$sha1 is the commit as recorded in the superproject, and $toplevel is the absolute path to the top-level of the superproject.
Any submodules defined in the superproject but not checked out are ignored by this command.
Unless given --quiet, foreach prints the name of each submodule before evaluating the command.
If --recursive is given, submodules are traversed recursively
(i.e. the given shell command is evaluated in nested submodules as well).
A non-zero return from the command in any submodule causes the processing to terminate.
This can be overridden by adding || : to the end of the command.")
  (:completion "-q" "--quiet" "-b" "--branch" "-f" "--force" "--cached" "--files" "-n" "--summary-limit"
   "-N" "--no-fetch" "--merge" "--rebase" "--reference" "--recursive"))

(define-git-command ("submodule" "init")
  (:documentation "Initialize, update or inspect submodules.

Initialize the submodules, i.e. register each submodule name and url found in .gitmodules into .git/config.
The key used in .git/config is submodule.$name.url.
This command does not alter existing information in .git/config.
You can then customize the submodule clone URLs in .git/config for your local setup and proceed to
git submodule update; you can also just use git submodule update --init
without the explicit init step if you do not intend to customize any submodule locations.")
  (:completion "-q" "--quiet" "-b" "--branch" "-f" "--force" "--cached" "--files" "-n" "--summary-limit"
   "-N" "--no-fetch" "--merge" "--rebase" "--reference" "--recursive"))

(define-git-command ("submodule" "status")
  (:documentation "Initialize, update or inspect submodules.

Show the status of the submodules.
This will print the SHA-1 of the currently checked out commit for each submodule,
along with the submodule path and the output of git describe for the SHA-1.
Each SHA-1 will be prefixed with - if the submodule is not initialized,
+ if the currently checked out submodule commit does not match the SHA-1 found in
the index of the containing repository and U if the submodule has merge conflicts.
This command is the default command for git submodule.")
  (:completion "-q" "--quiet" "-b" "--branch" "-f" "--force" "--cached" "--files" "-n" "--summary-limit"
   "-N" "--no-fetch" "--merge" "--rebase" "--reference" "--recursive"))

(define-git-command ("submodule" "summary")
  (:documentation "Initialize, update or inspect submodules.

Show commit summary between the given commit (defaults to HEAD) and working tree/index.
For a submodule in question, a series of commits in the submodule between the given
super project commit and the index or working tree (switched by --cached) are shown.
If the option --files is given, show the series of commits in the submodule between
the index of the super project and the working tree of the submodule
(this option doesn’t allow to use the --cached option or to provide an explicit commit).")
  (:completion "-q" "--quiet" "-b" "--branch" "-f" "--force" "--cached" "--files" "-n" "--summary-limit"
   "-N" "--no-fetch" "--merge" "--rebase" "--reference" "--recursive"))

(define-git-command ("submodule" "sync")
  (:documentation "Initialize, update or inspect submodules.

Synchronizes submodules' remote URL configuration setting to the value specified in .gitmodules.
It will only affect those submodules which already have an url entry in .git/config
(that is the case when they are initialized or freshly added).
This is useful when submodule URLs change upstream and you need to update your local repositories accordingly.")
  (:completion "-q" "--quiet" "-b" "--branch" "-f" "--force" "--cached" "--files" "-n" "--summary-limit"
   "-N" "--no-fetch" "--merge" "--rebase" "--reference" "--recursive"))

(define-git-command ("submodule" "update")
  (:documentation "Initialize, update or inspect submodules.

Update the registered submodules, i.e. clone missing submodules and
checkout the commit specified in the index of the containing repository.
This will make the submodules HEAD be detached unless --rebase or --merge is specified or
the key submodule.$name.update is set to rebase or merge.")
  (:completion "-q" "--quiet" "-b" "--branch" "-f" "--force" "--cached" "--files" "-n" "--summary-limit"
   "-N" "--no-fetch" "--merge" "--rebase" "--reference" "--recursive"))

(define-git-command ("tag")
  (:documentation "Create, list, delete or verify a tag object signed with GPG.")
  (:completion "-a" "-s" "-u" "-f" "--force" "-d" "-v" "-n" "-l" "--contains" "-m" "-F"))

(define-git-command nil
  (:binary "gitk")
  (:documentation "The git repository browser. ")
  (:completion "-n" "--max-count=" "--since=" "--until=" "--all" "--merge" "--argscmd=" "--select-commit=")
  (:no-std-handles t :hide))

(provide "xl-git/command/high-main")
