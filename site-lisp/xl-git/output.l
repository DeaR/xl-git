;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/output.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-12 20:39:34 DeaR>

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

(require "process")

(in-package :git)

(export '(git-output-quit))



(defvar *git-output-mode-map* nil
  "git出力モードのキーマップ")
(unless *git-output-mode-map*
  (setf *git-output-mode-map* (make-sparse-keymap))
  (define-key *git-output-mode-map* #\q   'git-output-quit)
  (define-key *git-output-mode-map* #\RET 'command-output-send-input)
  (define-key *git-output-mode-map* #\C-j 'command-output-alternate-send-input))



(defun git-output-mode ()
  "git出力モード"
  (setup-temp-buffer (selected-buffer))
  (setf mode-name "GitOutput")
  (setf buffer-mode 'git-output-mode)
  (use-keymap *git-output-mode-map*)
  (and #1=(buffer-process (selected-buffer))
       (set-process-sentinel #1# #'git-process-sentinel)))

(defun git-output-quit (&optional (buffer (selected-buffer)))
  "git出力バッファを閉じる"
  (interactive)
  (when (and (set-window (get-buffer-window buffer))
             (> (count-windows) 1))
    (delete-window))
  (delete-buffer buffer))

(defun git-process-sentinel (proc)
  "gitのプロセスのセンチネル"
  (let ((buffer (process-buffer proc)))
    (when (and buffer
               (eq (process-status proc) :exit)
               (= (process-exit-code proc) 0)
               (save-excursion
                 (set-buffer buffer)
                 (= (point-min) (point-max))))
      (git-output-quit buffer)
      (message "success no output.")
      (refresh-screen))))

(provide "xl-git/output")
