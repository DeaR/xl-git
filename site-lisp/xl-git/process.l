;; -*- mode: lisp; package: xl-git; encoding: shift_jis -*-

;; @name        xl-git/process.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-25 19:16:00 DeaR>

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

(in-package :xl-git)

(export '(*msysgit-directory*
          *git-binary*
          *git-environ*
          *git-wrapper-bat*
          *git-process-encoding*
          *git-process-eol-code*))



(defvar *msysgit-directory* nil
  "msysgit �̃C���X�g�[���f�B���N�g��")

(defvar *git-binary* "git.exe"
  "git.exe �̃p�X")

(defvar *git-environ* nil
  "�K���ݒ肷����ϐ�
'((\"VARNAME\" . \"VAR\"))")

(defvar *git-wrapper-bat* (merge-pathnames "site-lisp/xl-git/git-wrapper.bat" (si:system-root))
  "git-wrapper.bat �̃p�X(nil �Ȃ疳��)
no-std-handles �� t �̍ۂ� git-wrapper.bat ���g�p����")

(defvar *git-process-encoding* *encoding-utf8n*
  "git.exe �̕����R�[�h")

(defvar *git-process-eol-code* *eol-lf*
  "git.exe �̉��s�R�[�h")

(defconstant +escape-code+ (compile-regexp "\\[[0-9;]*[a-z]" t)
  "�폜����G�X�P�[�v�R�[�h")



(defun git-command-line (binary args dir &optional port-shell-command-line)
  "git�̃R�}���h���C���̐���"
  (let ((cmdline (if (listp args)
                     (format nil "~A~{ ~A~}" binary args)
                   (format nil "~A ~A" binary args))))
    (if port-shell-command-line
        (ed::shell-command-line cmdline dir)
      (values cmdline dir))))

(defun git-get-environ (&optional environ)
  "���ϐ����擾"
  (append '(("GIT_EDITOR" . "xyzzycli.exe -wait"))
          *git-environ*
          `(("PATH" .
             ,(concat (when *msysgit-directory*
                        (let ((dir (map-slash-to-backslash (remove-trail-slash *msysgit-directory*))))
                          (format nil "~A\\bin;~A\\mingw\\bin;~A\\cmd;" dir dir dir)))
                      (map-slash-to-backslash (si:system-root)) ";"
                      (or (rest (assoc "PATH" *git-environ* :test #'string-equal))
                          (si:getenv "PATH")))))
          environ))

(defun git-call-process (args &key environ
                              (binary *git-binary*)
                              (output (selected-buffer))
                              (outfile (make-temp-file-name))
                              (exec-directory (default-directory))
                              (encoding *git-process-encoding*)
                              (eol-code *git-process-eol-code*)
                              no-std-handles show wait)
  "git�̃v���Z�X�����s
�l2�ɏo�͕������Ԃ�"
  (multiple-value-bind (cmdline dir)
      (git-command-line binary args exec-directory (not #0=(and *git-wrapper-bat* no-std-handles (not (eq show :hide)))))
    (values (call-process (if #0#
                              (format nil "\"~A\" ~A" *git-wrapper-bat* cmdline)
                            cmdline)
                          :environ (git-get-environ)
                          :output outfile
                          :exec-directory dir
                          :show show
                          :wait wait
                          :no-std-handles no-std-handles)
            (when (and wait (not no-std-handles))
              (save-excursion
                (set-buffer output)
                (let ((point (point-max)))
                  (goto-char point)
                  (insert-file outfile encoding)
                  (replace-buffer +escape-code+ "" :regexp t)
                  (buffer-substring point (point-max))))))))

(defun git-make-process (args &key environ
                              (binary *git-binary*)
                              (output (selected-buffer))
                              (exec-directory (default-directory))
                              (encoding *git-process-encoding*)
                              (eol-code *git-process-eol-code*)
                              show wait)
  "git�̃v���Z�X���J�n"
  (multiple-value-bind (cmdline dir)
      (git-command-line binary args exec-directory)
    (prog1
        (make-process cmdline
                      :environ (git-get-environ)
                      :output output
                      :exec-directory dir
                      :incode encoding
                      :outcode encoding
                      :eol-code eol-code
                      :show show)
      (let ((proc (buffer-process output)))
        (set-process-filter proc #'git-process-filter)
        (set-process-sentinel proc #'git-process-sentinel)
        (save-excursion
          (set-buffer output)
          (make-local-variable '*before-delete-buffer-hook*)
          (add-hook '*before-delete-buffer-hook* 'git-kill-process))))))

(defun git-kill-process (buffer)
  "git�̃v���Z�X�������I��"
  (let ((proc (buffer-process buffer)))
    (when (and proc (eq (process-status proc) :run))
      (kill-process proc)
      (while (eq (process-status proc) :run)
        (sleep-for 0.1))))
  t)

(defun git-process-filter (proc str)
  "git�̃v���Z�X�̃t�B���^�[
�G�X�P�[�v�R�[�h�̒u���̈�"
  (with-selected-buffer
    (set-buffer (process-buffer proc))
    (goto-char (point-max))
    (insert str)
    (save-excursion
      (goto-char (point-min))
      (replace-buffer +escape-code+ "" :regexp t))
    (refresh-screen)))

(defun git-process-sentinel (proc)
  "git�̃v���Z�X�̃Z���`�l��
�o�͂���ؖ����ꍇ�A����I���Ȃ̂��G���[�Ȃ̂��̏o�͂��s��"
  (with-selected-buffer
    (and (eq (process-status proc) :exit)
         (set-buffer (process-buffer proc))
         (goto-char (point-min))
         (= (point-min) (point-max))
         (if (/= (process-exit-code proc) 0)
             (insert (format nil "Error! (~D)" (process-exit-code proc)))
           (insert "Success no output.")))))

(provide "xl-git/process")
