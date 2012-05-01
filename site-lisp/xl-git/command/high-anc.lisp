;; -*- mode: lisp; package: xl-git; encoding: shift_jis -*-

;; @name        xl-git/command/high-anc.lisp
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
  (require "xl-git/utils"))

(in-package :xl-git)

(export '(git-config
          git-help))



(define-git-command ("config")
  (:documentation "Get and set repository or global options.")
  (:completion "--replace-all" "--add" "--get" "--get-all" "--get-regexp" "--global" "--system"
   "-f" "--file" "--remove-section" "--rename-section" "--unset" "--unset-all" "-l" "--list"
   "--bool" "--int" "--bool-or-int" "--path" "-z" "--null" "--get-colorbool" "--get-color" "-e" "--edit"))

(define-git-command ("help")
  (:documentation "display help information about git.")
  (:completion "-a" "--all" "-i" "--info" "-m" "--man" "-w" "--web"))

(provide "xl-git/command/high-anc")
