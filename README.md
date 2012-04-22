# xl-git

A front end for git in [xyzzy].

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/


## Install
1.	�𓀂��� [xyzzy] �̃C���X�g�[���f�B���N�g���ɃR�s�[���ĉ�����

2.	.xyzzy �܂��� siteinit.l �Ɉȉ��̃R�[�h��ǉ����܂�
	
	```lisp
	(require "xl-git")
	```

3.	�X�Ɋ��ŗL�̐ݒ���ǉ����܂�
	*	[msysgit] ���g�p����ꍇ
		
		```lisp
		; �����̊��ł� msysgit �̃C���X�g�[���f�B���N�g���ɕύX���ĉ�����
		(git-install :msysgit "C:/Program Files/Git")
		```
	*	[cygwin] ���g�p����ꍇ
		
		```lisp
		; �����̊��ł� cygwin �̃C���X�g�[���f�B���N�g���ɕύX���ĉ�����
		(git-install :cygwin "C:/cygwin")
		```
	*	[git-flow] �̃R�}���h���ǉ�����ꍇ
		
		```lisp
		; :flow ��ǉ����Ă�������
		(git-install :msysgit "C:/Program Files/Git" :flow)
		```

4.	(�K�v�Ȃ��) �o�C�g�R���p�C�����܂�

5.	��L�̐ݒ�𔽉f������ׂɍċN�������܂�
	siteinit.l �ɐݒ肵���ꍇ�͍ă_���v���s���ĉ�����

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/
  [msysgit]: http://msysgit.github.com/
  [cygwin]: http://www.cygwin.com/
  [git-flow]: https://github.com/nvie/gitflow


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
