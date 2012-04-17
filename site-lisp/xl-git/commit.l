;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/commit.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-17 19:11:06 DeaR>

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
  (require "xl-git/process")
  (require "xl-git/utils")
  (require "xl-git/output")
  (require "xl-git/diff"))

(in-package :git)

(export '(*git-commit-message-file*
          *git-commit-message-encoding*
          *git-commit-message-eol-code*
          *git-commit-message-mode-hook*
          *git-commit-message-mode-map*
          git-commit
          git-commit-all
          git-commit-amend
          git-commit-all-amend
          git-commit-verbose))



(defvar *git-commit-message-file* ".git/COMMIT_EDITMSG"
  "コミットメッセージファイル名
リポジトリのトップディレクトリからの相対パス")

(defvar *git-commit-message-encoding* *encoding-utf8n*
  "コミットメッセージの文字コード")

(defvar *git-commit-message-eol-code* *eol-lf*
  "コミットメッセージの改行コード")

(defvar *git-commit-message-mode-hook* nil
  "git-commit-message-mode起動時に実行されます")

(defvar *git-commit-message-mode-map* nil
  "コミットメッセージモードのキーマップ")
(unless *git-commit-message-mode-map*
  (setf *git-commit-message-mode-map* (make-sparse-keymap))
  (define-key *git-commit-message-mode-map* '(#\C-x #\C-s) 'git-commit-start)
  (define-key *git-commit-message-mode-map* '(#\C-c #\C-c) 'git-commit-start)
  (define-key *git-commit-message-mode-map* '(#\C-c #\C-g) 'git-output-quit))



(defun git-commit-template (cmd)
  "commit templateの取得"
  (concat (if (member "--amend" cmd :test #'string=)
              (multiple-value-bind (exec-code out)
                  (git-call-process '("log" "-1" "--format='%B'")
                                    :output (get-buffer-create *git-temp-bufname*)
                                    :show :hide :wait t)
                out)
            (let ((ct (git-config "commit.template"))
                  (file))
              (concat (and ct
                           (file-exist-p (setf file (merge-pathnames ct (git-top-dir))))
                           (save-excursion
                             (let ((buffer (switch-to-buffer *git-temp-bufname*)))
                               (read-file file *git-commit-message-encoding* t)
                               (buffer-substring (point-min) (point-max)))))
                      "\n")))
          "# Please enter the commit message for your changes. Lines starting\n"
          "# with '#' will be ignored, and an empty message aborts the commit.\n"
          (multiple-value-bind (exec-code out)
              (git-call-process (append cmd '("--dry-run"))
                                :output (get-buffer-create *git-temp-bufname*)
                                :show :hide :wait t)
            out)))

(defun git-commit-0 (cmd args)
  "git-commitの実体"
  (if (and (not args)
           (not *prefix-args*)
           (or (member "-a" cmd :test #'string=)
               (member "--all" cmd :test #'string=)
               (member "--amend" cmd :test #'string=)
               (assoc-if #'(lambda (k)
                             (not (or (eq k :unmodified)
                                      (eq k :untracked)
                                      (eq k :ignored))))
                         (git-status-list))))
      (let ((dir (default-directory))
            (file (merge-pathnames *git-commit-message-file*
                                   (git-top-dir)))
            (buffer (get-buffer-create *git-output-bufname*)))
        (when (= (count-windows) 1)
          (split-window nil *git-output-split-vertical-p*))
        (pop-to-buffer buffer)
        (git-commit-message-mode)
        (setup-temp-buffer buffer)
        (set-default-directory dir buffer)
        (set-buffer-fileio-encoding *git-process-encoding* buffer)
        (set-buffer-eol-code *git-process-eol-code* buffer)
        (make-local-variable '*git-commit-command*)
        (setf *git-commit-command* cmd)
        (erase-buffer buffer)
        (insert (git-commit-template cmd))
        (goto-char (point-min)))
    (git-command-wrapper cmd args)))

(defun git-commit (&optional args)
  "Record changes to the repository."
  (interactive)
  (git-commit-0 '("commit") args))

(defun git-commit-all (&optional args)
  "Record changes to the repository.
Tell the command to automatically stage files that have been modified and deleted, but new files you have not told git about are not affected."
  (interactive)
  (git-commit-0 '("commit" "--all") args))

(defun git-commit-amend (&optional args)
  "Record changes to the repository.
Used to amend the tip of the current branch.
Prepare the tree object you would want to replace the latest commit as usual (this includes the usual -i/-o and explicit paths), and the commit log editor is seeded with the commit message from the tip of the current branch.
The commit you create replaces the current tip - if it was a merge, it will have the parents of the current tip as parents - so the current top commit is discarded."
  (interactive)
  (git-commit-0 '("commit" "--amend") args))

(defun git-commit-all-amend (&optional args)
  "Record changes to the repository.
Tell the command to automatically stage files that have been modified and deleted, but new files you have not told git about are not affected.
Used to amend the tip of the current branch.
Prepare the tree object you would want to replace the latest commit as usual (this includes the usual -i/-o and explicit paths), and the commit log editor is seeded with the commit message from the tip of the current branch.
The commit you create replaces the current tip - if it was a merge, it will have the parents of the current tip as parents - so the current top commit is discarded."
  (interactive)
  (git-commit-0 '("commit" "--all" "--amend") args))

(defun git-commit-verbose (&optional args)
  "Record changes to the repository.
Show unified diff between the HEAD commit and what would be committed at the bottom of the commit message template.
Note that this diff output doesn’t have its lines prefixed with #."
  (interactive)
  (git-commit-0 '("commit" "--verbose") args))

(defun git-commit-message-mode ()
  "コミットメッセージモード"
  (interactive)
  (kill-all-local-variables)
  (setf mode-name "GitMessage")
  (set buffer-mode 'git-commit-message-mode)
  (use-keymap *git-commit-message-mode-map*)
  (make-local-variable 'regexp-keyword-list)
  (setf regexp-keyword-list
        (compile-regexp-keyword-list
         `(("^#.*$"
            nil :comment)
           ("^diff .*$"
            nil ,*git-diff-color-header*)
           ("^index .*$"
            nil ,*git-diff-color-header*)
           ("^[+-]\\{3\\} .*$"
            nil ,*git-diff-color-header*)
           ("^\\+.*$"
            nil ,*git-diff-color-add*)
           ("^-.*$"
            nil ,*git-diff-color-remove*)
           ("^@@ .* @@.*$"
            nil ,*git-diff-color-area*))))
  (run-hooks '*git-commit-message-mode-hook*))

(defun git-commit-start ()
  "コミットの開始"
  (interactive)
  (let* ((file (merge-pathnames *git-commit-message-file*
                                (git-top-dir)))
         (rel (git-top-dir-relative))
         (file-rel (concat (unless (string= rel "")
                             (append-trail-slash rel))
                           (substitute-string *git-commit-message-file* "^\\.\\.?/" "")))
         (buffer (switch-to-buffer *git-output-bufname*))
         (cmd *git-commit-command*))
    (write-file file t)
    (git-command-wrapper cmd (format nil "-F ~A --cleanup=strip" file-rel))))

(provide "xl-git/commit")
