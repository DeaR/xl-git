;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/output.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-17 01:28:00 DeaR>

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
  (require "xl-git/process"))

(in-package :git)

(export '(*git-output-mode-hook*
          *git-output-mode-map*))



(defvar *git-output-mode-hook* nil
  "git-output-mode起動時に実行されます")

(defvar *git-output-mode-map* nil
  "出力モードのキーマップ")
(unless *git-output-mode-map*
  (setf *git-output-mode-map* (make-sparse-keymap))
  (dotimes (n #x80)
    (define-key *git-output-mode-map* (code-char n) 'git-output-send-and-funcall))
  (undefine-key *git-output-mode-map* #\ESC)
  (undefine-key *git-output-mode-map* #\C-c)
  (undefine-key *git-output-mode-map* #\C-x)
  (define-key *git-output-mode-map* '(#\C-c #\C-g) 'git-output-quit)
  (define-key *git-output-mode-map* '#\RET 'git-output-send-LFD-or-newline)
  (define-key *git-output-mode-map* '#\q 'git-output-send-or-quit))



(defun git-output-mode (&optional minor-mode)
  "出力モード"
  (interactive)
  (kill-all-local-variables)
  (setf mode-name "GitOutput")
  (setf buffer-mode 'git-output-mode)
  (use-keymap *git-output-mode-map*)
  (when minor-mode
    (funcall minor-mode))
  (run-hooks '*git-output-mode-hook*))

(defun git-output-quit ()
  "出力バッファを閉じる"
  (interactive)
  (let ((buffer (selected-buffer)))
    (when (and (set-window (get-buffer-window buffer))
               (> (count-windows) 1))
      (delete-window))
    (delete-buffer buffer)))

(defun git-output-send-and-funcall (&optional (send *last-command-char*) func)
  "出力バッファのプロセスが動作中なら送り、終了していたら関数を実行"
  (interactive)
  (let ((proc (buffer-process (selected-buffer))))
    (when (and proc
               (eq (process-status proc) :run))
      (process-send-string proc (string send))))
  (unless func
    (find-if #'(lambda (keymap)
                 (setf func (lookup-keymap keymap send)))
               (append (minor-mode-map)
                       (list *global-keymap*))))
  (when func
    (funcall func)))

(defun git-output-send-LFD-or-newline ()
  "出力バッファのプロセスが動作中ならLFDを送り、終了していたらRETの関数を実行"
  (interactive)
  (git-output-send-and-funcall #\LFD))

(defun git-output-send-or-quit ()
  "出力バッファのプロセスが動作中なら送り、終了していたら閉じる"
  (interactive)
  (let ((proc (buffer-process (selected-buffer))))
    (if (and proc
             (eq (process-status proc) :run))
        (git-output-send-and-funcall)
      (git-output-quit))))

(provide "xl-git/output")
