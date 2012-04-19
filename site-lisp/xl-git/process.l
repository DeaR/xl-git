;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/process.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-19 23:41:47 DeaR>

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
          *git-wrapper-bat*
          *git-process-encoding*
          *git-process-eol-code*))



(defvar *git-binary* "git.exe"
  "git.exe のパス")

(defvar *git-environ* nil
  "必ず設定する環境変数
'((\"VARNAME\" . \"VAR\"))")

(defvar *git-wrapper-bat* (merge-pathnames "site-lisp/xl-git/git-wrapper.bat" (si:system-root))
  "git-wrapper.bat のパス(nil なら無効)
no-std-handles が t の際に git-wrapper.bat を使用する")

(defvar *git-process-encoding* *encoding-utf8n*
  "git.exe の文字コード")

(defvar *git-process-eol-code* *eol-lf*
  "git.exe の改行コード")

(defconstant *escape-code* (compile-regexp "\\[[0-9;]*[a-z]" t)
  "削除するエスケープコード")



(defun git-command-line (binary args dir)
  "gitのコマンドラインの生成"
  (values (if (listp args)
              (format nil "~A~{ ~A~}" binary args)
            (format nil "~A ~A" binary args))
          dir))

(defun git-call-process (args &key environ
                              (binary *git-binary*)
                              (output (selected-buffer))
                              (outfile (make-temp-file-name))
                              (exec-directory (default-directory))
                              (encoding *git-process-encoding*)
                              (eol-code *git-process-eol-code*)
                              no-std-handles show wait)
  "gitのプロセスを実行
値2に出力文字列を返す"
  (multiple-value-bind (cmdline dir)
      (git-command-line binary args exec-directory)
    (values (call-process (if (and *git-wrapper-bat*
                                   no-std-handles)
                              (format nil "\"~A\" ~A" (merge-pathnames *git-wrapper-bat*) cmdline)
                            cmdline)
                          :environ (append environ
                                           *git-environ*)
                          :output outfile
                          :exec-directory dir
                          :show show
                          :wait wait
                          :no-std-handles no-std-handles)
            (unless no-std-handles
              (save-excursion
                (set-buffer output)
                (let ((p (point-max)))
                  (goto-char p)
                  (insert-file outfile encoding)
                  (replace-buffer *escape-code* "" :regexp t)
                  (buffer-substring p (point-max))))))))

(defun git-make-process (args &key environ
                              (binary *git-binary*)
                              (output (selected-buffer))
                              (exec-directory (default-directory))
                              (encoding *git-process-encoding*)
                              (eol-code *git-process-eol-code*)
                              (show :hide))
  "gitのプロセスを開始"
  (multiple-value-bind (cmdline dir)
      (git-command-line binary args exec-directory)
    (prog1
        (make-process cmdline
                      :environ (append environ
                                       *git-environ*)
                      :output output
                      :exec-directory dir
                      :incode encoding
                      :outcode encoding
                      :eol-code eol-code
                      :show show)
      (save-excursion
        (let* ((buffer (switch-to-buffer output))
               (proc (buffer-process buffer)))
          (set-process-filter proc #'git-process-filter)
          (set-process-sentinel proc #'git-process-sentinel)
          (make-local-variable '*before-delete-buffer-hook*)
          (add-hook '*before-delete-buffer-hook* 'git-kill-process))))))

(defun git-kill-process (buffer)
  "gitのプロセスを強制終了"
  (let ((proc (buffer-process buffer)))
    (when (and proc
               (eq (process-status proc) :run))
      (kill-process proc)
      (while (eq (process-status proc) :run)
        (sleep-for 0.1))))
  t)

(defun git-process-filter (proc str)
  "gitのプロセスのフィルター
エスケープコードの置換の為"
  (with-selected-window
    (let ((buffer (switch-to-buffer (process-buffer proc)))
          (p (point-max)))
      (goto-char p)
      (insert (substitute-string str *escape-code* ""))
      (refresh-screen))))

(defun git-process-sentinel (proc)
  "gitのプロセスのセンチネル
出力が一切無い場合、正常終了なのかエラーなのか代わりの出力を行う"
  (with-selected-window
    (let ((buffer (process-buffer proc)))
      (when (and (eq (process-status proc) :exit)
                 (set-buffer buffer)
                 (goto-char (point-min))
                 (= (point-min) (point-max)))
        (let ((exit-code (process-exit-code proc)))
          (if (= exit-code 0)
              (insert "Success no output.")
            (insert (format nil "Error! (~A)" exit-code))))))))

(provide "xl-git/process")
