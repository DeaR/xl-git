;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/flow.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-17 13:06:03 DeaR>

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



(define-git-command ("flow" "init")
  :document "Initialize a new git repo with support for the branching model."
  :dir-prompt t)



(define-git-command ("flow" "feature" "list")
  :document "Manage your feature branches.")

(define-git-command ("flow" "feature" "start")
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "finish")
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "publish")
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "track")
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "diff")
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "rebase")
  :document "Manage your feature branches."
  :prompt t
  :no-std-handles t)

(define-git-command ("flow" "feature" "checkout")
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "pull")
  :document "Manage your feature branches."
  :prompt t
  :no-std-handles t)



(define-git-command ("flow" "release" "list")
  :document "Manage your release branches.")

(define-git-command ("flow" "release" "start")
  :document "Manage your release branches."
  :prompt t)

(define-git-command ("flow" "release" "finish")
  :document "Manage your release branches."
  :prompt t)

(define-git-command ("flow" "release" "publish")
  :document "Manage your release branches."
  :prompt t)

(define-git-command ("flow" "release" "track")
  :document "Manage your release branches."
  :prompt t)



(define-git-command ("flow" "hotfix" "list")
  :document "Manage your hotfix branches.")

(define-git-command ("flow" "hotfix" "start")
  :document "Manage your hotfix branches."
  :prompt t)

(define-git-command ("flow" "hotfix" "finish")
  :document "Manage your hotfix branches."
  :prompt t)

(define-git-command ("flow" "hotfix" "publish")
  :document "Manage your hotfix branches."
  :prompt t)



(define-git-command ("flow" "support" "list")
  :document "Manage your support branches.")

(define-git-command ("flow" "support" "start")
  :document "Manage your support branches."
  :prompt t)



(define-git-command ("flow" "version")
  :document "Shows version information.")



(provide "xl-git/flow")
