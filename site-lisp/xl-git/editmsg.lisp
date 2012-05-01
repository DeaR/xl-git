;; -*- mode: lisp; package: xl-git; encoding: shift_jis -*-

;; @name        xl-git/editmsg.lisp
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
  (require "xl-git/diff"))

(in-package :xl-git)

(export '(*git-editmsg-encoding*
          *git-editmsg-eol-code*
          *git-editmsg-mode-hook*
          *git-editmsg-mode-map*
          git-editmsg-end
          git-editmsg-abort))



(defvar *git-editmsg-encoding* *encoding-utf8n*
  "メッセージ編集の文字コード")

(defvar *git-editmsg-eol-code* *eol-lf*
  "メッセージ編集の改行コード")

(defvar *git-editmsg-mode-hook* nil
  "git-editmsg-mode起動時に実行されます")

(defvar *git-editmsg-mode-map* nil
  "メッセージ編集モードのキーマップ")



(defun git-editmsg-regexp-keyword-list ()
  "メッセージ編集モードのregexp-keyword-list"
  (append (compile-regexp-keyword-list
           `(("^#.*$"
              nil :comment)))
          (git-diff-regexp-keyword-list)))

(defun git-editmsg-mode ()
  "メッセージ編集モード"
  (interactive)
  (kill-all-local-variables)
  (setf mode-name "GitEditMsg")
  (setf buffer-mode 'git-editmsg-mode)
  (unless (local-variable-p '#0=regexp-keyword-list)
    (make-local-variable '#0#))
  (setf #0# (append #0# (git-editmsg-regexp-keyword-list)))
  (use-keymap *git-editmsg-mode-map*)
  (run-hooks '*git-editmsg-mode-hook*))

(defun git-editmsg-end ()
  "メッセージ編集を終了する"
  (interactive)
  (save-buffer)
  (delete-buffer (selected-buffer)))

(defun git-editmsg-abort ()
  "メッセージ編集を中断する"
  (interactive)
  (delete-region (point-min) (point-max))
  (insert "#")
  (git-editmsg-end))



(pushnew '("COMMIT_EDITMSG" . git-editmsg-mode) ed::*auto-mode-alist* :test #'equal)
(pushnew '("TAG_EDITMSG" . git-editmsg-mode) ed::*auto-mode-alist* :test #'equal)
(pushnew '("git-rebase-todo" . git-editmsg-mode) ed::*auto-mode-alist* :test #'equal)
(unless *git-editmsg-mode-map*
  (setf *git-editmsg-mode-map* (make-sparse-keymap))
  (define-key *git-editmsg-mode-map* '(#\C-x #\C-s) 'git-editmsg-end)
  (define-key *git-editmsg-mode-map* '(#\C-c #\C-c) 'git-editmsg-end)
  (define-key *git-editmsg-mode-map* '(#\C-c #\C-g) 'git-editmsg-abort))

(provide "xl-git/editmsg")
