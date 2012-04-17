# xl-git

A front end for git in xyzzy.


## Install

1. �𓀂���$XYZZY�ɃR�s�[���ĉ�����

2. .xyzzy �܂��� siteinit.l �Ɉȉ��̃R�[�h��ǉ����܂�
   
     ```lisp
     (require "xl-git")
     ```

3. (�K�v�Ȃ��) �o�C�g�R���p�C�����܂�

4. ��L�̐ݒ�𔽉f������ׂɍċN�������܂�
   siteinit.l �ɐݒ肵���ꍇ�͍ă_���v���s���ĉ�����

  [�}���`�t���[����xyzzy]: https://bitbucket.org/mumurik/xyzzy/wiki/Home
  [NAXEL]: https://bitbucket.org/mumurik/xyzzy/wiki/NAXEL


## Usage

- `M-x git-init`
- `M-x git-add`
- `M-x git-commit`

etc...

- ���s����� `*Git*` �o�b�t�@���J����܂�
  �I��(���[�h���C����:Exit)�̏ꍇ�� `C-c C-g` �������� `q` �ŁA
  ���s��(���[�h���C����:Run)�̏ꍇ�� `C-c C-g` �ŁA�I�����܂�

- `git-commit` �ł� `*Git*` �o�b�t�@�ɃR�~�b�g���b�Z�[�W����͂��A
  `C-c C-c` �������� `C-x C-s` �ŃR�~�b�g�����s�A
  `C-c C-g` �ŃL�����Z�����܂�


## Setting
- [msysgit] ���g�p
  
    ```lisp
    (pushnew `("PATH" . ,(concat "$MSYSGIT/bin;$MSYSGIT/mingw/bin;$MSYSGIT/cmd;" (si:getenv "PATH"))) *git-environ* :test #'equal)
    ```
  $MSYSGIT -- [msysgit] �̃C���X�g�[���f�B���N�g��

- [msysgit] �� [cygwin] ���������Ă��āA [msysgit] ���g�p
  
    ```lisp
    (pushnew '("CYGWIN" . "") *git-environ* :test #'equal)
    ```

- [git-flow] �𗘗p���Ă���
  
    ```lisp
    (require "xl-git-flow")
    ```

- ���̃R�}���h���֐��Ƃ��Ēǉ�������
  * `git::define-git-command command &key :document :symbol :prompt :dir-prompt :minor-mode :no-std-handles`
    + `command` -- git�R�}���h
    + `:document` -- �֐��̃h�L�������g�R�����g
    + `:symbol` -- �ʂ̊֐������w�肷��
    + `:prompt` -- �����I�Ɉ������͂��s�킹��
    + `:dir-prompt` -- �f�B���N�g�����͂��s�킹��
    + `:minor-mode` -- �w��̃}�C�i�[���[�h���g�p����
    + `:no-std-handles` -- �S�ĊO���R�}���h�v�����v�g��œ��삳����
    + ��:
      
        ```lisp
        ; (git-add)
        (define-git-command ("add")
          :document "Add file contents to the index."
          :file-arg t)
        
        ; (git-clone)
        (define-git-command ("clone")
          :document "Clone a repository into a new directory."
          :prompt t
          :dir-prompt t
          :no-std-handles t)
        
        ; (git-reset-head-file)
        (define-git-command ("reset" "HEAD")
          :symbol #:git-reset-head-file
          :document "Reset current HEAD to the specified state.
        This form resets the index entries for all <paths> to their state at <commit>. (It does not affect the working tree, nor the current branch.)"
          :file-arg t)
        ```

  [msysgit]: http://msysgit.github.com/
  [cygwin]: http://www.cygwin.com/
  [git-flow]: https://github.com/nvie/gitflow


## Reference
REFERENCE.md ���Q�Ƃ�������


## Issues
���L�̂ǂ��炩�ɂł����A��������

- [Issues - DeaR/xl-git](https://github.com/DeaR/xl-git/issues)
- [@nayuri_aohime](http://twitter.com/nayuri_aohime/)


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
