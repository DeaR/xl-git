;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/flow.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-14 01:18:23 DeaR>

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
  :symbol #:git-flow-init
  :document "Initialize a new git repo with support for the branching model.")



(define-git-command ("flow" "feature" "list")
  :symbol #:git-flow-feature-list
  :document "Manage your feature branches.")

(define-git-command ("flow" "feature" "start")
  :symbol #:git-flow-feature-start
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "finish")
  :symbol #:git-flow-feature-finish
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "publish")
  :symbol #:git-flow-feature-publish
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "track")
  :symbol #:git-flow-feature-track
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "diff")
  :symbol #:git-flow-feature-diff
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "rebase")
  :symbol #:git-flow-feature-rebase
  :document "Manage your feature branches."
  :prompt t
  :no-std-handles t)

(define-git-command ("flow" "feature" "checkout")
  :symbol #:git-flow-feature-checkout
  :document "Manage your feature branches."
  :prompt t)

(define-git-command ("flow" "feature" "pull")
  :symbol #:git-flow-feature-pull
  :document "Manage your feature branches."
  :prompt t
  :no-std-handles t)



(define-git-command ("flow" "release" "list")
  :symbol #:git-flow-release-list
  :document "Manage your release branches.")

(define-git-command ("flow" "release" "start")
  :symbol #:git-flow-release-start
  :document "Manage your release branches."
  :prompt t)

(define-git-command ("flow" "release" "finish")
  :symbol #:git-flow-release-finish
  :document "Manage your release branches."
  :prompt t)

(define-git-command ("flow" "release" "publish")
  :symbol #:git-flow-release-publish
  :document "Manage your release branches."
  :prompt t)

(define-git-command ("flow" "release" "track")
  :symbol #:git-flow-release-track
  :document "Manage your release branches."
  :prompt t)



(define-git-command ("flow" "hotfix" "list")
  :symbol #:git-flow-hotfix-list
  :document "Manage your hotfix branches.")

(define-git-command ("flow" "hotfix" "start")
  :symbol #:git-flow-hotfix-start
  :document "Manage your hotfix branches."
  :prompt t)

(define-git-command ("flow" "hotfix" "finish")
  :symbol #:git-flow-hotfix-finish
  :document "Manage your hotfix branches."
  :prompt t)

(define-git-command ("flow" "hotfix" "publish")
  :symbol #:git-flow-hotfix-publish
  :document "Manage your hotfix branches."
  :prompt t)



(define-git-command ("flow" "support" "list")
  :symbol #:git-flow-support-list
  :document "Manage your support branches.")

(define-git-command ("flow" "support" "start")
  :symbol #:git-flow-support-start
  :document "Manage your support branches."
  :prompt t)



(define-git-command ("flow" "version")
  :symbol #:git-flow-version
  :document "Shows version information.")



(provide "xl-git/flow")
