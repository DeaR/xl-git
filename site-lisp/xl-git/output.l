;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/output.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-11 17:17:40 DeaR>

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
  (require "xl-git/package"))

(in-package :git)

(export '(git-output-quit))



(defvar *git-output-keymap* nil
  "git出力モードのキーマップ")
(unless *git-output-keymap*
  (setf *git-output-keymap* (make-sparse-keymap))
  (define-key *git-output-keymap* #\q 'git-output-quit))



(defun git-output-mode (&key
                        (directory (default-directory))
                        (encoding *git-process-encoding*)
                        (eol-code *git-process-eol-code*))
  "git出力モード"
  (set-default-directory directory)
  (set-buffer-fileio-encoding encoding)
  (set-buffer-eol-code eol-code)
  (make-local-variable 'need-not-save)
  (setf need-not-save t)
  (use-keymap *git-output-keymap*))

(defun git-output-quit (&optional (buffer (selected-buffer)))
  "git出力バッファを閉じる"
  (interactive)
  (when (and (set-window (get-buffer-window buffer))
             (> (count-windows) 1))
    (delete-window))
  (delete-buffer buffer))

(provide "xl-git/output")
