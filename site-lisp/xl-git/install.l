;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/install.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-22 21:51:19 DeaR>

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
  (require "xl-git/utils"))

(in-package :git)

(export '(git-install
          git-uninstall))



(defun git-install (&rest options)
  "インストールする
:flow	: git-flow のコマンドを利用する"
  (let* ((msysgit (member :msysgit options))
         (msysgit-dir (second msysgit))
         (cygwin (member :cygwin options))
         (cygwin-dir (second cygwin))
         (cygwin-env (third cygwin))
         (flow (find :flow options)))
    (cond (msysgit
           (when (stringp (second msysgit))
             (push (cons "PATH"
                         (format nil "~A/bin;~A/mingw/bin;~A/cmd;~A;~A"
                                 msysgit-dir msysgit-dir msysgit-dir
                                 (si:system-root)
                                 (si:getenv "PATH")))
                   *git-environ*)
             (push '("GIT_EDITOR" . "xyzzycli.exe -wait") *git-environ*))
           (push '("CYGWIN" . "") *git-environ*))
          (cygwin
           (when (stringp (second cygwin))
             (push (cons "PATH"
                         (format nil "~A/usr/local/bin;~A/usr/bin;~A/bin;~A;~A"
                                 cygwin-dir cygwin-dir cygwin-dir
                                 (si:system-root)
                                 (si:getenv "PATH")))
                   *git-environ*)
             (push '("GIT_EDITOR" . "xyzzycli.exe -wait") *git-environ*))
           (if (stringp cygwin-env)
               (push '("CYGWIN" . cygwin-env) *git-environ*)
             (push '("CYGWIN" . "ntsec") *git-environ*))))
    (when flow
      (require "xl-git/command/flow"))))

(defun git-uninstall ()
  "アンインストールする"
  (unregister-history-variable '*git-prompt-history*)

  (setf #0=lisp::*modules*
        (delete "xl-git" #0# :test #'string-equal))
  (setf #0#
        (delete "xl-git-flow" #0# :test #'string-equal))
  (setf #0#
        (delete "xl-git/.+" #0# :test #'string-match)))

(provide "xl-git/install")
