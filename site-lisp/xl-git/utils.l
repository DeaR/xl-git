;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/utils.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-18 16:13:36 DeaR>

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
  (require "xl-git/output"))

(in-package :git)

(export '(*git-output-bufname*
          *git-output-split-vertical-p*
          *git-temp-bufname*))



(defvar *git-output-bufname* "*Git*"
  "出力バッファ名")

(defvar *git-output-split-vertical-p* t
  "出力バッファは縦に分割する")

(defvar *git-temp-bufname* " *Git Temp*"
  "作業バッファ名")



(defun git-config (key &optional (dir (default-directory)))
  "設定を取得"
  (multiple-value-bind (exec-code out)
      (git-call-process `("config" ,key)
                        :output (get-buffer-create *git-temp-bufname*)
                        :exec-directory dir
                        :show :hide :wait t)
    (and (= exec-code 0)
         (first (split-string out #\LFD)))))

(defun git-top-dir-relative (&optional (dir (default-directory)))
  "リポジトリのトップディレクトリを取得"
  (multiple-value-bind (exec-code out)
      (git-call-process '("rev-parse" "--show-cdup")
                        :output (get-buffer-create *git-temp-bufname*)
                        :exec-directory dir
                        :show :hide :wait t)
    (unless (= exec-code 0)
      (error out))
    (or (first (split-string out #\LFD))
        "")))

(defun git-top-dir (&optional (dir (default-directory)))
  "リポジトリのトップディレクトリを取得"
  (merge-pathnames (git-top-dir-relative)
                   dir))

(defun git-status-to-symbol (str)
  "Short Formatの状態文字をシンボルに変換"
  (case (character str)
    (#\SPC :unmodified)
    (#\M :modified)
    (#\A :added)
    (#\D :deleted)
    (#\R :renamed)
    (#\C :copied)
    (#\U :unmerged)
    (#\? :untracked)
    (#\! :ignored)))

(defun git-status-list (&optional (dir (default-directory)))
  "リポジトリの状態をリストで取得"
  (multiple-value-bind (exec-code out)
      (git-call-process '("status" "--porcelain")
                        :output (get-buffer-create *git-temp-bufname*)
                        :exec-directory dir
                        :show :hide :wait t)
    (unless (= exec-code 0)
      (error out))
    (mapcar #'(lambda (l)
                (when (string-match "\\(.\\)\\(.\\) \\(.*\\)$" l)
                  (list (git-status-to-symbol (match-string 1))
                        (git-status-to-symbol (match-string 2))
                        (match-string 3))))
            (split-string out #\LFD))))

(defmacro define-git-command (command &key symbol document prompt dir-prompt file-arg minor-mode no-std-handles)
  "シンプルなgitコマンド生成"
  (let ((name (if symbol
                  (string symbol)
                (substitute-string (if (listp command)
                                       (format nil "git~{-~A~}" command)
                                     (format nil "git-~A" command))
                                   "[ -]+" "-"))))
    `(progn
       (export (intern ,name :git) :git)
       (defun ,(intern name :git) (&optional args)
         ,document
         (interactive)
         (git::git-command-wrapper ',command args
                                   :prompt ,prompt
                                   :dir-prompt ,dir-prompt
                                   :file-arg ,file-arg
                                   :minor-mode ,minor-mode
                                   :no-std-handles ,no-std-handles)))))
(setf (get 'define-git-command 'lisp-indent-hook) 'defun)

(defun git-command-wrapper (command args &key prompt file-arg dir-prompt minor-mode no-std-handles)
  "シンプルなgitコマンド実体"
  (let* ((dir (if dir-prompt
                  (read-directory-name "directory :")
                (default-directory)))
         (command (if (listp command)
                      (string-trim " " (format nil "~{ ~A~}" command))
                    command))
         (args (cond (args
                      args)
                     ((or prompt
                          *prefix-args*)
                      (read-string (format nil "git ~A: " command)))
                     (file-arg
                      (if (file-visited-p)
                          (format nil "\"~A\"" (file-namestring (get-buffer-file-name)))
                        (read-file-name (format nil "git ~A: " command))))
                     (t
                      "")))
         (cmdline (format nil "~A ~A" command args)))
    (if no-std-handles
        (git-call-process cmdline :exec-directory dir :no-std-handles t :wait t)
      (let ((buffer (get-buffer-create *git-output-bufname*)))
        (when (= (count-windows) 1)
          (split-window nil *git-output-split-vertical-p*))
        (pop-to-buffer buffer)
        (erase-buffer buffer)
        (git-output-mode minor-mode)
        (setup-temp-buffer buffer)
        (set-default-directory dir buffer)
        (set-buffer-fileio-encoding *git-process-encoding* buffer)
        (set-buffer-eol-code *git-process-eol-code* buffer)
        (git-make-process cmdline :exec-directory dir :output buffer)))))

(defun equal-regexp (x y)
  "正規表現が同じならばtを、そうでなければnilを返します"
  (and (string= (if (regexpp x)
                    (compiled-regexp-source x)
                  x)
                (if (regexpp y)
                    (compiled-regexp-source y)
                  y))
       (eq (and (regexpp x)
                (compiled-regexp-case-fold-p x))
           (and (regexpp y)
                (compiled-regexp-case-fold-p y)))))

(defun set-regexp-keyword-list (kwd-list &optional (enable t))
  "regexp-keyword-listを登録したり削除したりする"
  (if enable
      (progn
        (unless (local-variable-p '#0=regexp-keyword-list)
          (make-local-variable '#0#))
        (setf #0# (append #0# kwd-list)))
    (progn
      (when #0#
        (mapc #'(lambda (kwd)
                  (setf #0# (delete (first kwd) #0#
                                    :from-end t
                                    :test #'equal-regexp
                                    :key #'first)))
              kwd-list)
        (if #0#
            #0#
          (kill-local-variable '#0#))))))

(provide "xl-git/utils")
