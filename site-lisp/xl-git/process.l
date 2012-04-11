;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/process.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-11 17:23:50 DeaR>

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
          *git-process-encoding*
          *git-process-eol-code*))



(defvar *git-binary* "git.exe"
  "git.exe �̃p�X")

(defvar *git-process-encoding* *encoding-utf8n*
  "git.exe �̓��o�͕����R�[�h")

(defvar *git-process-eol-code* *eol-lf*
  "git.exe �̉��s�R�[�h")



(defun git-command-line (args dir)
  "git�̃R�}���h���C���̐���"
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
                              (show :hide)
                              (wait t))
  "git�̃v���Z�X�����s"
  (multiple-value-bind (cmdline dir)
      (git-command-line args exec-directory)
    (values (call-process cmdline
                          :environ environ
                          :output outfile
                          :exec-directory dir
                          :show show
                          :wait wait)
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
  "git�̃v���Z�X���J�n"
  (multiple-value-bind (cmdline dir)
      (git-command-line args exec-directory)
    (prog1
        (make-process cmdline
                      :environ environ
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
  "git�̃v���Z�X�������I��"
  (let ((proc (buffer-process buffer)))
    (when (and proc
               (eq (process-status proc) :run))
      (kill-process proc)))
  t)

(provide "xl-git/process")