# xl-git

A front end for [git] in [xyzzy].

  [git]: http://git-scm.com/
  [xyzzy]: http://www.jsdlab.co.jp/~kamei/


## Install
1. �𓀂��� [xyzzy] �̃C���X�g�[���f�B���N�g���ɃR�s�[���܂�

2. `.xyzzy` �܂��� `siteinit.l` �Ɉȉ��̃R�[�h��ǉ����܂�
   
   ```lisp
   (require "xl-git")
   ```

3. �X�Ɋ��ŗL�̐ݒ���ǉ����܂�
   
   ```lisp
   ; �����̊��ł� msysgit �̃C���X�g�[���f�B���N�g���ɕύX���ĉ�����
   (setf *msysgit-directory* "C:/msysgit")
   ```

4. (�K�v�Ȃ��) �o�C�g�R���p�C�����܂�

5. ��L�̐ݒ�𔽉f������ׂɍċN�������܂�
   `siteinit.l` �ɐݒ肵���ꍇ�͍ă_���v���s���܂�

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/


## Usage
- `M-x git-init`
- `M-x git-add`
- `M-x git-commit`
- `M-x git-push`
- etc...

### `*Git*` �o�b�t�@
- ���[�h���C���� `:Run` (�v���Z�X���s��)�̏ꍇ�� `C-c C-g` �ŏI��
- ���[�h���C���� `:Exit` (�v���Z�X�I��)�̏ꍇ�� `C-c C-g` �������� `q` �ŏI��

### `COMMIT_EDITMSG` �� `TAG_EDITMSG` �o�b�t�@��
- `C-c C-c` �������� `C-x C-s` �Ŏ��s
- `C-c C-g` �ŃL�����Z��


## Setting
### [git-flow] �̃R�}���h��ǉ�������
```lisp
(require "xl-git-flow")
```

### [msysgit] �ł͂Ȃ� [cygwin] ���g�p������
```lisp
(setf *msysgit-directory* nil)
```
���ϐ���PATH����ݒ肵�Ă��Ȃ��ꍇ�͈ȉ����Q�l�ɐݒ肵�ĉ�����
```lisp
; �����̊��ł� cygwin �̃C���X�g�[���f�B���N�g���ɕύX���ĉ�����
(push `(("PATH" . ,(concat "C:/cygwin/usr/local/bin;C:/cygwin/bin;" (si:getenv "PATH")))
        ("CYGWIN" . "ntsec"))
      *git-environ*)
```

### [cygwin] �𓱓��ς݂��� [msysgit] ���g�p������
```lisp
; �����̊��ł� msysgit �̃C���X�g�[���f�B���N�g���ɕύX���ĉ�����
(setf *msysgit-directory* "C:/msysgit")
(push '("CYGWIN" . "") *git-environ*)
```

### �����̓��͎��ɕ⊮���͂��g�p���� (�����@�\)
```lisp
(setf *git-completing-prompt* t)
```

  [git-flow]: https://github.com/nvie/gitflow
  [msysgit]: http://msysgit.github.com/
  [cygwin]: http://www.cygwin.com/


## Issue
���L�̂ǂ��炩�ɂ��A��������

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
