;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/command/bisect.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-20 18:57:41 DeaR>

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

(export '(git-bisect-bad
          git-bisect-good
          git-bisect-help
          git-bisect-log
          git-bisect-replay
          git-bisect-reset
          git-bisect-run
          git-bisect-skip
          git-bisect-start
          git-bisect-view
          git-bisect-visualize))



(define-git-command ("bisect" "bad")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion nil))

(define-git-command ("bisect" "good")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion nil))

(define-git-command ("bisect" "help")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:no-prompt t))

(define-git-command ("bisect" "log")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:no-prompt t))

(define-git-command ("bisect" "replay")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion nil))

(define-git-command ("bisect" "reset")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion nil))

(define-git-command ("bisect" "run")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion nil))

(define-git-command ("bisect" "skip")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion nil))

(define-git-command ("bisect" "start")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion "--no-checkout"))

(define-git-command ("bisect" "view")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion "-p" "--stat"))

(define-git-command ("bisect" "visualize")
  (:documentation "Find by binary search the change that introduced a bug.")
  (:completion "-p" "--stat"))

(provide "xl-git/command/bisect")
