;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/process.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-12 19:05:06 DeaR>

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

(export '(*git-binary*
          *git-environ*
          *git-process-encoding*
          *git-process-eol-code*))



(defvar *git-binary* "git.exe"
  "git.exe のパス")

(defvar *git-environ* nil
  "必ず設定する環境変数
'((\"VARNAME\" . \"VAR\"))")

(defvar *git-process-encoding* *encoding-utf8n*
  "git.exe の入出力文字コード")

(defvar *git-process-eol-code* *eol-lf*
  "git.exe の改行コード")



(defun git-command-line (args dir)
  "gitのコマンドラインの生成"
  (values (if (listp args)
              (format nil "~A~{ ~A~}" *git-binary* args)
            (format nil "~A ~A" *git-binary* args))
          dir))

(defun git-call-process (args &key environ
                              (output (selected-buffer))
                              (outfile (make-temp-file-name))
                              (exec-directory (default-directory))
                              (encoding *git-process-encoding*)
                              (eol-code *git-process-eol-code*)
                              show wait no-std-handles)
  "gitのプロセスを実行"
  (multiple-value-bind (cmdline dir)
      (git-command-line args exec-directory)
    (values (call-process cmdline
                          :environ (append *git-environ*
                                           environ)
                          :output outfile
                          :exec-directory dir
                          :show show
                          :wait wait
                          :no-std-handles no-std-handles)
            (save-excursion
              (let ((buffer (switch-to-buffer output))
                    (p (point-max)))
                (goto-char p)
                (insert-file outfile encoding)
                (buffer-substring p (point-max)))))))

(defun git-make-process (args &key environ
                              (output (selected-buffer))
                              (exec-directory (default-directory))
                              (encoding *git-process-encoding*)
                              (eol-code *git-process-eol-code*)
                              (show :hide))
  "gitのプロセスを開始"
  (multiple-value-bind (cmdline dir)
      (git-command-line args exec-directory)
    (prog1
        (make-process cmdline
                      :environ (append *git-environ*
                                       environ)
                      :output output
                      :exec-directory dir
                      :incode encoding
                      :outcode encoding
                      :eol-code eol-code
                      :show show)
      (save-excursion
        (let ((buffer (switch-to-buffer output)))
          (make-local-variable '*delete-buffer-hook*)
          (add-hook '*delete-buffer-hook* 'git-kill-process))))))

(defun git-kill-process (&optional (buffer (selected-buffer)))
  "gitのプロセスを強制終了"
  (let ((proc (buffer-process buffer)))
    (when (and proc
               (eq (process-status proc) :run))
      (kill-process proc)))
  t)

(provide "xl-git/process")
