;; -*- mode: lisp; package: user; encoding: shift_jis -*-

;; @name        xl-git.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-20 19:14:13 DeaR>

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

(in-package :user)

(require "xl-git/package")
(require "xl-git/process")
(require "xl-git/output")
(require "xl-git/utils")
(require "xl-git/install")

(require "xl-git/branch")
(require "xl-git/diff")
(require "xl-git/log")
(require "xl-git/status")
(require "xl-git/editmsg")

(require "xl-git/command/high-main")
(require "xl-git/command/high-anc")
(require "xl-git/command/high-others")
(require "xl-git/command/low-mnp")
(require "xl-git/command/low-inter")
(require "xl-git/command/low-sync")
(require "xl-git/command/low-helper")

(require "xl-git/version")

(provide "xl-git")
