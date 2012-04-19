;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/commit.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-19 19:25:42 DeaR>

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
         (all (or (member "-a" argl :test #'string=)
                  (member "--all" argl :test #'string=)))
         (amend (member "--amend" argl :test #'string=))
         (file (or (second (member "-F" argl :test #'string=))
                   (and (member "--file=\\(.*\\)" argl :test #'string-match)
                        (match-string 1))))
         (edit (or (member "-e" argl :test #'string=)
                   (member "--edit" argl :test #'string=)))
         (message (or (second (member "-m" argl :test #'string=))
                      (and (member "--message=\\(.*\\)" argl :test #'string-match)
                           (match-string 1))))
         (reuse-message (or (second (member "-C" argl :test #'string=))
                            (and (member "--reuse-message=\\(.*\\)" argl :test #'string-match)
                                 (match-string 1))))
         (reedit-message (or (second (member "-c" argl :test #'string=))
                             (and (member "--reedit-message=\\(.*\\)" argl :test #'string-match)
                                  (match-string 1))))
         (trackd (assoc-if #'(lambda (k)
                               (or (eq k :modified)
                                   (eq k :added)
                                   (eq k :deleted)
                                   (eq k :renamed)
                                   (eq k :copied)))
                           (git-status-list))))
    (if (and (or edit
                 reedit-message
                 (and (not file)
                      (not message)
                      (not reuse-message)))
             (or all
                 amend
                 tracked))
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
          (erase-buffer buffer)
          (insert (git-commit-template argl))
          (dotimes (idx (length argl))
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
                         (string-match "--file=.*" arg)
                         (string-match "--message=.*" arg)
                         (string-match "--reuse-message=.*" arg)
                         (string-match "--reedit-message=.*" arg)
                         (string-match "--template=.*" arg))
                     (setf (nth idx argl) nil)))))
          (make-local-variable '*git-commit-argl*)
          (setf *git-commit-argl* (delete nil argl))
          (goto-char (point-min)))
      (git-command-0 cmd args))))

(defun git-commit-template (argl)
  "commit templateの取得"
  (let ((amend (member "--amend" argl :test #'string=))
        (file (or (second (member "-F" argl :test #'string=))
                  (and (member "--file=\\(.*\\)" argl :test #'string-match)
                       (match-string 1))))
        (message (or (second (member "-m" argl :test #'string=))
                     (and (member "--message=\\(.*\\)" argl :test #'string-match)
                          (match-string 1))))
        (reuse (or (second (member "-c" argl :test #'string-equal))
                   (and (member "--\\(reuse\\|reedit\\)-message=\\(.*\\)" argl :test #'string-match)
                        (match-string 2))))
        (template (or (second (member "-t" argl :test #'string=))
                      (and (member "--template=\\(.*\\)" argl :test #'string-match)
                           (match-string 1))
                      (git-config "commit.template"))))
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
                  (message
                   (format nil "~A~%" (string-trim "'\"" message)))
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
                  (t
                   "\n"))
            "# Please enter the commit message for your changes. Lines starting\n"
            "# with '#' will be ignored, and an empty message aborts the commit.\n"
            (multiple-value-bind (exec-code out)
                (git-call-process (append '("commit" "--dry-run") argl)
                                  :output (get-buffer-create *git-temp-bufname*)
                                  :show :hide :wait t)
              out))))

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
