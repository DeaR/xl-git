;; -*- mode: lisp; package: xl-git; encoding: shift_jis -*-

;; @name        xl-git/version.lisp
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
  (require "xl-git/process")
  (require "xl-git/utils"))

(in-package :xl-git)

(export '(git-version))



(defconstant +git-version+ "1.0a3")



(defun git-version ()
  "バージョンを多値で返します
値1: xl-gitのバージョン
値2: git や git-flow のバージョン"
  (let ((ext))
    (when (modulep "xl-git/command/flow")
      (multiple-value-bind (exit-code out)
          (git-call-process '("flow" "version")
                            :output (get-buffer-create *git-temp-bufname*)
                            :show :hide :wait t)
        (when (= exit-code 0)
          (push `(:git-flow ,(string-right-trim "\n" out)) ext))))
    (multiple-value-bind (exit-code out)
        (git-call-process '("version")
                          :output (get-buffer-create *git-temp-bufname*)
                          :show :hide :wait t)
      (when (= exit-code 0)
        (push `(:git ,(string-right-trim "\n" out)) ext)))
    (values +git-version+ ext)))

(provide "xl-git/version")
