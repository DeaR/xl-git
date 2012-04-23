;; -*- mode: lisp; package: git; encoding: shift_jis -*-

;; @name        xl-git/command/flow.l
;; @description A front-end for git in xyzzy.
;; @namespace   http://kuonn.mydns.jp/
;; @author      DeaR
;; @timestamp   <2012-04-23 19:45:13 DeaR>

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
  (require "xl-git/utils")
  (require "xl-git/diff"))

(in-package :git)

(export '(git-flow-init
          git-flow-feature-list
          git-flow-feature-start
          git-flow-feature-finish
          git-flow-feature-publish
          git-flow-feature-track
          git-flow-feature-diff
          git-flow-feature-rebase
          git-flow-feature-checkout
          git-flow-feature-pull
          git-flow-release-list
          git-flow-release-start
          git-flow-release-finish
          git-flow-release-publish
          git-flow-release-track
          git-flow-hotfix-list
          git-flow-hotfix-start
          git-flow-hotfix-finish
          git-flow-hotfix-publish))



(define-git-command ("flow" "init")
  (:documentation "Initialize a new git repo with support for the branching model.")
  (:completion "-f" "-d")
  (:dir-prompt t))



(define-git-command ("flow" "feature" "list")
  (:documentation "Manage your feature branches.")
  (:completion "-v"))

(define-git-command ("flow" "feature" "start")
  (:documentation "Manage your feature branches.")
  (:completion "-F"))

(define-git-command ("flow" "feature" "finish")
  (:documentation "Manage your feature branches.")
  (:completion "-r" "-F" "-k" "-D"))

(define-git-command ("flow" "feature" "publish")
  (:documentation "Manage your feature branches."))

(define-git-command ("flow" "feature" "track")
  (:documentation "Manage your feature branches."))

(define-git-command ("flow" "feature" "diff")
  (:documentation "Manage your feature branches.")
  (:mode git-diff-mode))

(define-git-command ("flow" "feature" "rebase")
  (:documentation "Manage your feature branches.")
  (:completion "-i"))

(define-git-command ("flow" "feature" "checkout")
  (:documentation "Manage your feature branches."))

(define-git-command ("flow" "feature" "pull")
  (:documentation "Manage your feature branches.")
  (:completion "-r")
  (:no-std-handles t))



(define-git-command ("flow" "release" "list")
  (:documentation "Manage your release branches.")
  (:completion "-v"))

(define-git-command ("flow" "release" "start")
  (:documentation "Manage your release branches.")
  (:completion "-F"))

(define-git-command ("flow" "release" "finish")
  (:documentation "Manage your release branches.")
  (:completion "-F" "-s" "-u" "-m" "-p" "-k"))

(define-git-command ("flow" "release" "publish")
  (:documentation "Manage your release branches."))

(define-git-command ("flow" "release" "track")
  (:documentation "Manage your release branches."))



(define-git-command ("flow" "hotfix" "list")
  (:documentation "Manage your hotfix branches.")
  (:completion "-v"))

(define-git-command ("flow" "hotfix" "start")
  (:documentation "Manage your hotfix branches.")
  (:completion "-F"))

(define-git-command ("flow" "hotfix" "finish")
  (:documentation "Manage your hotfix branches.")
  (:completion "-F" "-s" "-u" "-m" "-p" "-k"))

(define-git-command ("flow" "hotfix" "publish")
  (:documentation "Manage your hotfix branches."))



(provide "xl-git/command/flow")
