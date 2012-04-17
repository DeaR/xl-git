# xl-git

A front end for git in xyzzy.


## Install

1. �𓀂���$XYZZY�ɃR�s�[���ĉ������B

2. .xyzzy �܂��� siteinit.l �Ɉȉ��̃R�[�h��ǉ����܂��B
   
     ```lisp
     (require "xl-git")
     ```

3. (�K�v�Ȃ��) �o�C�g�R���p�C�����܂��B

4. ��L�̐ݒ�𔽉f������ׂɍċN�������܂��B
   siteinit.l �ɐݒ肵���ꍇ�͍ă_���v���s���ĉ������B

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
  $MSYSGIT �� [msysgit] �̃C���X�g�[���f�B���N�g���ɒu�����ĉ������B

- [msysgit] �� [cygwin] ���������Ă��āA [msysgit] ���g�p
  
    ```lisp
    (pushnew '("CYGWIN" . "") *git-environ* :test #'equal)
    ```

- [git-flow] �𗘗p���Ă���
  
    ```lisp
    (require "xl-git-flow")
    ```

- ���̃R�}���h���֐��Ƃ��Ēǉ�������
  * `git::define-git-command` �}�N�����g���Α��̃R�}���h�͎����\�ł��B
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
  [cygwin]: http://msysgit.github.com/
  [git-flow]: https://github.com/nvie/gitflow


## Reference
[REFERENCE.md](./REFERENCE.md)


## Author
DeaR (<nayuri@kuonn.mydns.jp>)

[@nayuri_aohime](http://twitter.com/nayuri_aohime/)


## License
xl-git�̃��C�Z���X��MIT���C�Z���X�ł��B
�ڍׂ�MIT.txt���Q�Ƃ��������B
