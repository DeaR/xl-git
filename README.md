# xl-git

A front end for git in [xyzzy].

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/


## Install
1.	�𓀂��� [xyzzy] �̃C���X�g�[���f�B���N�g���ɃR�s�[���ĉ�����

2.	.xyzzy �܂��� siteinit.l �Ɉȉ��̃R�[�h��ǉ����܂�
	
	```lisp
	(require "xl-git")
	(git-install)
	```

3.	�X�Ɋ��ŗL�̐ݒ���ǉ����܂�
	*	[msysgit] ���g�p����ꍇ
		
		```lisp
		; $MSYSGIT_DIR �� msysgit �̃C���X�g�[���f�B���N�g���ɒu�����ĉ�����
		(push (cons "PATH"
		             (format nil 
		                     "$MSYSGIT_DIR\\bin;$MSYSGIT_DIR\\mingw\\bin;$MSYSGIT_DIR\\cmd;~A;~A"
		                     (map-slash-to-backslash (si:system-root)) (si:getenv "PATH")))
		      *git-environ*)
		(push '("GIT_EDITOR" . "xyzzycli.exe -wait") *git-environ*)
		
		; cygwin ���C���X�g�[�����Ă���ꍇ�A���L��ݒ肵�ĉ�����
		(push '("CYGWIN" . "") *git-environ*)
		```
	*	[cygwin] ���g�p����ꍇ
		
		```lisp
		; $CYGWIN_DIR �� cygwin �̃C���X�g�[���f�B���N�g���ɒu�����ĉ�����
		(push (cons "PATH"
		            (format nil 
		                    "$CYGWIN_DIR\\usr\\local\\bin;$CYGWIN_DIR\\usr\\bin;$CYGWIN_DIR\\bin;~A;~A"
		                    (map-slash-to-backslash (si:system-root)) (si:getenv "PATH")))
		      *git-environ*)
		(push '("GIT_EDITOR" . "xyzzycli.exe -wait") *git-environ*)
		
		; Windows��95,98,Me�ȊO�̏ꍇ�A���L��ݒ肵�ĉ�����
		(push '("CYGWIN" . "ntsec") *git-environ*)
		```

4.	(�K�v�Ȃ��) �o�C�g�R���p�C�����܂�

5.	��L�̐ݒ�𔽉f������ׂɍċN�������܂�
	siteinit.l �ɐݒ肵���ꍇ�͍ă_���v���s���ĉ�����

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/
  [msysgit]: http://msysgit.github.com/
  [cygwin]: http://www.cygwin.com/


## Usage
-	`M-x git-init`
-	`M-x git-add`
-	`M-x git-commit`

etc...

-	���s����� `*Git*` �o�b�t�@���J����܂�
	�I��(���[�h���C����:Exit)�̏ꍇ�� `C-c C-g` �������� `q` �ŁA
	���s��(���[�h���C����:Run)�̏ꍇ�� `C-c C-g` �ŁA�I�����܂�

-	`git-commit` �ł� `*Git*` �o�b�t�@�ɃR�~�b�g���b�Z�[�W����͂��A
	`C-c C-c` �������� `C-x C-s` �ŃR�~�b�g�����s�A
	`C-c C-g` �ŃL�����Z�����܂�


## Setting
-	`git-install` �̔C�ӈ���
	
	```lisp
	git-install &rest options
	```
	*	`:flow` -- [git-flow] �̃R�}���h�𗘗p����
	*	��:
		
		```lisp
		(git-install :flow)
		```

-	���̃R�}���h���֐��Ƃ��Ēǉ�������
	
	```lisp
	git::define-git-command command &rest options
	```
	*	`command` -- git�R�}���h
	*	`:name` -- �ʂ̊֐������w�肷��
	*	`:package` -- �ʂ̃p�b�P�[�W���w�肷��(������)
	*	`:documentation` -- �֐��̃h�L�������g�R�����g
	*	`:completion` -- �⊮���
	*	`:dir-prompt` -- �f�B���N�g�����͂��s�킹��
	*	`:no-prompt` -- �������͂��s��Ȃ�
	*	`:mode` -- �w��̃��W���[���[�h���g�p����
	*	`:no-std-handles` -- �S�ĊO���R�}���h�v�����v�g��œ��삳����
	*	��:
		
		```lisp
		; �����d�l git-log ���� git-glog
		(git::define-git-command ("log" (format nil "-~D" *git-log-default-limit*)
		                          "--graph" "--oneline" "--decorate" "--branches")
		  (:name :git-glog)
		  (:documentation "Show commit logs.")
		  (:completion "--follow" "--no-decorate" "--decorate=" "--source" "--full-diff" "--log-size"
		   "-n" "--max-count=" "--skip=" "--since=" "--after=" "--until=" "--before" "--author" "--committer="
		   "--grep=" "--all-match" "-i" "--regexp-ignore-case" "-E" "--extended-regexp" "-F" "--fixed-strings"
		   "--remove-empty" "--merges" "--no-merges" "--min-parents=" "--max-parents=" "--no-min-parents"
		   "--no-max-parents" "--first-parent" "--not" "--all" "--branches" "--tags" "--remotes" "--glob="
		   "--ignore-missing" "--bisect" "--stdin" "--cherry-mark" "--cherry-pick" "--left-only" "--right-only"
		   "--cherry" "-g" "--walk-reflogs" "--merge" "--boundary" "--simplify-by-decoration" "--full-history"
		   "--dense" "--sparse" "--simplify-merges" "--ancestry-path" "--topo-order" "--date-order" "--reverse"
		   "--objects" "--objects-edge" "--unpacked" "--no-walk" "--do-walk" "--pretty" "--format=" "--abbrev-commit"
		   "--no-abbrev-commit" "--oneline" "--encoding" "--notes" "--no-notes" "--show-notes" "--standard-notes"
		   "--no-standard-notes" "--relative-date" "--date=" "--parents" "--children" "--left-right" "--graph"
		   "-c" "--cc" "-m" "-r" "-t" "-s" "-p" "-u" "--patch" "-U" "--unified=" "--raw" "--patch-with-raw"
		   "--patience" "--stat" "--numstat" "--shortstat" "--dirstat" "--summary" "--patch-with-stat" "-z"
		   "--name-only" "--name-status" "--submodule" "--color" "--no-color" "--word-diff" "--word-diff-regex="
		   "--color-words" "--no-renames" "--check" "--full-index" "--binary" "--abbrev" "-B" "-M" "--find-renames"
		   "-C" "--find-copies" "--find-copies-harder" "-D" "--irreversible-delete" "-l" "--diff-dilter=" "-S" "-G"
		   "--pickaxe-all" "--pickaxe-regex" "-O" "-R" "--relative" "-a" "--text" "--ignore-space-at-eol" "-b"
		   "--ignore-space-change" "-w" "--ignore-all-space" "--inter-hunk-context=" "--exit-code" "--quiet"
		   "--ext-diff" "--no-ext-diff" "--textconv" "--no-textconv" "--ignore-submodules" "--src-prefix="
		   "--dst-prefix=" "--no-prefix")
		  (:mode git::git-log-mode))
		```

  [git-flow]: https://github.com/nvie/gitflow


## Issue
���L�̂ǂ��炩�ɂł����A��������

-	[Issues - DeaR/xl-git](https://github.com/DeaR/xl-git/issues)
-	[@nayuri_aohime](http://twitter.com/nayuri_aohime/)


## Author
DeaR (<nayuri@kuonn.mydns.jp>)

[@nayuri_aohime](http://twitter.com/nayuri_aohime/)


## License
	Copyright (c) 2012 DeaR <nayuri@kuonn.mydns.jp>
	
	Permission is hereby granted, free of charge, to any person obtaining a copy of
	this software and associated documentation files (the "Software"), to deal in
	the Software without restriction, including without limitation the rights to
	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
	the Software, and to permit persons to whom the Software is furnished to do so,
	subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all copies
	or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
	PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
	DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
