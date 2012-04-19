;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/commit.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-19 20:48:20 DeaR>

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
          git-commit-start))



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

(defvar *git-commit-argl* nil
  "git-commitの引数保存用")



(defun git-commit (&optional args)
  "Record changes to the repository."
  (interactive)
  (git-commit-0 "commit" args))

(defun git-commit-0 (cmd &optional args)
  "git-commitの実体"
  (let* ((args (or args
                   (git-read-args cmd)))
         (argl (split-string args #\SPC))
         (all (or (find "-a" argl :test #'string=)
                  (find "--all" argl :test #'string=)))
         (amend (find "--amend" argl :test #'string=))
         (file (or (second (member "-F" argl :test #'string=))
                   (and (find "--file=\\(.*\\)" argl :test #'string-match)
                        (match-string 1))))
         (edit (or (find "-e" argl :test #'string=)
                   (find "--edit" argl :test #'string=)))
         (message (or (second (member "-m" argl :test #'string=))
                      (and (find "--message=\\(.*\\)" argl :test #'string-match)
                           (match-string 1))))
         (reuse (or (second (member "-C" argl :test #'string=))
                    (and (find "--reuse-message=\\(.*\\)" argl :test #'string-match)
                         (match-string 1))))
         (reedit (or (second (member "-c" argl :test #'string=))
                     (and (find "--reedit-message=\\(.*\\)" argl :test #'string-match)
                          (match-string 1))))
         (fixup (and (find "--fixup=\\(.*\\)" argl :test #'string-match)
                     (match-string 1)))
         (squash (and (find "--squash=\\(.*\\)" argl :test #'string-match)
                      (match-string 1)))
         (signoff (or (find "-s" argl :test #'string=)
                      (find "--signoff" argl :test #'string=)))
         (template (or (second (member "-t" argl :test #'string=))
                       (and (find "--template=\\(.*\\)" argl :test #'string-match)
                            (match-string 1))
                       (git-config "commit.template")))
         (dry-run (find "--dry-run" argl :test #'string=))
         (tracked (assoc-if #'(lambda (k)
                                (or (eq k :modified)
                                    (eq k :added)
                                    (eq k :deleted)
                                    (eq k :renamed)
                                    (eq k :copied)))
                            (git-status-list))))
    (if (and (not dry-run)
             (or amend
                 edit
                 reedit
                 squash
                 (and (not file)
                      (not message)
                      (not reuse)
                      (not fixup)))
             (or all
                 amend
                 tracked)
             (or (not template)
                 (= 0 (git-call-process (concat "-f " (string-trim "'\"\n" template))
                                        :binary "test"
                                        :output (get-buffer-create *git-temp-bufname*)
                                        :show :hide :wait t)))
             (or (not file)
                 (= 0 (git-call-process (concat "-f " (string-trim "'\"" file))
                                        :binary "test"
                                        :output (get-buffer-create *git-temp-bufname*)
                                        :show :hide :wait t))
                 (not (or reuse
                          reedit
                          fixup
                          squash
                          message)))
             (or (not reuse)
                 (= 0 (git-call-process '("log" "-1" "--format='%B'" (string-trim "'\"" reuse))
                                        :output (get-buffer-create *git-temp-bufname*)
                                        :show :hide :wait t))
                 (not (or file
                          reedit
                          fixup
                          squash
                          message)))
             (or (not reedit)
                 (= 0 (git-call-process '("log" "-1" "--format='%B'" (string-trim "'\"" reedit))
                                        :output (get-buffer-create *git-temp-bufname*)
                                        :show :hide :wait t))
                 (not (or file
                          reuse
                          fixup
                          squash
                          message)))
             (or (not fixup)
                 (= 0 (git-call-process '("log" "-1" "--format='%B'" (string-trim "'\"" fixup))
                                        :output (get-buffer-create *git-temp-bufname*)
                                        :show :hide :wait t))
                 (not (or file
                          reuse
                          reedit
                          squash
                          message)))
             (or (not squash)
                 (= 0 (git-call-process '("log" "-1" "--format='%B'" (string-trim "'\"" squash))
                                        :output (get-buffer-create *git-temp-bufname*)
                                        :show :hide :wait t))
                 (not (or file
                          reuse
                          reedit
                          fixup
                          message)))
             (or (not message)
                 (not (or file
                          reuse
                          reedit
                          fixup
                          squash))))
        (let ((dir (default-directory))
              (buffer (get-buffer-create *git-output-bufname*)))
          (when (= (count-windows) 1)
            (split-window nil *git-output-split-vertical-p*))
          (pop-to-buffer buffer)
          (git-commit-message-mode)
          (setup-temp-buffer buffer)
          (set-default-directory dir buffer)
          (set-buffer-fileio-encoding *git-process-encoding* buffer)
          (set-buffer-eol-code *git-process-eol-code* buffer)
          (erase-buffer buffer)
          (insert (git-commit-template argl all amend file edit message reuse reedit
                                       fixup squash signoff template dry-run tracked))
          (make-local-variable '*git-commit-argl*)
          (setf *git-commit-argl*
                (dotimes (idx (length argl) (delete nil argl))
                  (let ((arg (nth idx argl)))
                    (cond ((eq arg nil))
                          ((or (string-equal "-c" arg)
                               (string= "-F" arg)
                               (string= "-m" arg)
                               (string= "-t" arg))
                           (setf (nth idx argl) nil
                                 (nth (1+ idx) argl) nil))
                          ((or (string= "-e" arg)
                               (string= "--edit" arg)
                               (string= "-s" arg)
                               (string= "--signoff" arg)
                               (string-match "--file=.*" arg)
                               (string-match "--message=.*" arg)
                               (string-match "--reuse-message=.*" arg)
                               (string-match "--reedit-message=.*" arg)
                               (string-match "--fixup=.*" arg)
                               (string-match "--squash=.*" arg)
                               (string-match "--template=.*" arg))
                           (setf (nth idx argl) nil))))))
          (goto-char (point-min)))
      (git-command-0 cmd args))))

(defun git-commit-template (argl all amend file edit message reuse reedit
                                 fixup squash signoff template dry-run tracked)
  "commit templateの取得"
  (concat (cond (amend
                 (multiple-value-bind (exec-code out)
                     (git-call-process '("log" "-1" "--format='%B'")
                                       :output (get-buffer-create *git-temp-bufname*)
                                       :show :hide :wait t)
                   out))
                (reuse
                 (multiple-value-bind (exec-code out)
                     (git-call-process '("log" "-1" "--format='%B'" (string-trim "'\"" reuse))
                                       :output (get-buffer-create *git-temp-bufname*)
                                       :show :hide :wait t)
                   out))
                (reedit
                 (multiple-value-bind (exec-code out)
                     (git-call-process '("log" "-1" "--format='%B'" (string-trim "'\"" reedit))
                                       :output (get-buffer-create *git-temp-bufname*)
                                       :show :hide :wait t)
                   out))
                (fixup
                 (multiple-value-bind (exec-code out)
                     (git-call-process '("log" "-1" "--format='%B'" (string-trim "'\"" fixup))
                                       :output (get-buffer-create *git-temp-bufname*)
                                       :show :hide :wait t)
                   (concat "fixup! " out)))
                (squash
                 (multiple-value-bind (exec-code out)
                     (git-call-process '("log" "-1" "--format='%B'" (string-trim "'\"" squash))
                                       :output (get-buffer-create *git-temp-bufname*)
                                       :show :hide :wait t)
                   (concat "squash! " out)))
                (file
                 (multiple-value-bind (exec-code out)
                     (git-call-process (string-trim "'\"" file)
                                       :binary "cat"
                                       :output (get-buffer-create *git-temp-bufname*)
                                       :show :hide :wait t)
                   (format nil "~A~%" out)))
                (template
                 (multiple-value-bind (exec-code out)
                     (git-call-process (string-trim "'\"\n" template)
                                       :binary "cat"
                                       :output (get-buffer-create *git-temp-bufname*)
                                       :show :hide :wait t)
                   (format nil "~A~%" out)))
                (message
                 (format nil "~A~%" (string-trim "'\"" message)))
                (t
                 "\n"))
          (when signoff
            (format nil "Sined-off-by: ~A <~A>~%~%"
                    (git-config "user.name")
                    (git-config "user.email")))
          "# Please enter the commit message for your changes. Lines starting\n"
          "# with '#' will be ignored, and an empty message aborts the commit.\n"
          (multiple-value-bind (exec-code out)
              (git-call-process (append '("commit" "--dry-run") argl)
                                :output (get-buffer-create *git-temp-bufname*)
                                :show :hide :wait t)
            out)))

(defun git-commit-message-regexp-keyword-list ()
  "コミットメッセージモードのregexp-keyword-list"
  (append (compile-regexp-keyword-list
           `(("^#.*$"
              nil :comment)))
          (git-diff-regexp-keyword-list)))

(defun git-commit-message-mode ()
  "コミットメッセージモード"
  (interactive)
  (kill-all-local-variables)
  (setf mode-name "GitMessage")
  (setf buffer-mode 'git-commit-message-mode)
  (unless (local-variable-p '#0=regexp-keyword-list)
    (make-local-variable '#0#))
  (setf #0# (append #0# (git-commit-message-regexp-keyword-list)))
  (use-keymap *git-commit-message-mode-map*)
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
         (buffer (switch-to-buffer *git-output-bufname*)))
    (write-file file t)
    (git-command-0 "commit" (format nil "~{~A ~}-F ~A --cleanup=strip"
                                    *git-commit-argl* file-rel))))

(provide "xl-git/commit")
