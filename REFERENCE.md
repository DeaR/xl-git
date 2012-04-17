# Reference


## Function

- `git`
  * `git $PROMPT`

- `git-add`
  * `git add $FILE`

- `git-add-update`
  * `git add --update`

- `git-add-all`
  * `git add --all`

- `git-add-patch`
  * `git add --patch`

- `git-bisect`
  * `git bisect`

- `git-branch`
  * `git branch`

- `git-branch-all`
  * `git branch --all`

- `git-checkout`
  * `git checkout`

- `git-checkout-file`
  * `git checkout $FILE`

- `git-clone`
  * `git clone $PROMPT`

- `git-commit`
  * `git commit`

- `git-commit-all`
  * `git commit --all`

- `git-commit-amend`
  * `git commit --amend`

- `git-commit-all-amend`
  * `git commit --all --amend`

- `git-commit-verbose`
  * `git commit --verbose`

- `git-diff`
  * `git diff`

- `git-diff-file`
  * `git diff $FILE`

- `git-fetch`
  * `git fetch`

- `git-grep`
  * `git grep`

- `git-help`
  * `git help`

- `git-init`
  * `git init`

- `git-log`
  * `git log -100`

- `git-glog`
  * `git log -100 --graph --oneline --decorate --branches`

- `git-merge`
  * `git merge`

- `git-mv`
  * `git mv`

- `git-pull`
  * `git pull`

- `git-push`
  * `git push`

- `git-push-matching`
  * `git push matching`

- `git-push-tracking`
  * `git push tracking`

- `git-push-current`
  * `git push current`

- `git-rebase`
  * `git rebase`

- `git-reset`
  * `git reset`

- `git-reset-head-file`
  * `git reset HEAD $FILE`

- `git-rm`
  * `git rm`

- `git-show`
  * `git show`

- `git-stash`
  * `git stash $PROMPT`

- `git-stash-save`
  * `git stash save`

- `git-stash-list`
  * `git stash list`

- `git-stash-show`
  * `git stash show`

- `git-stash-pop`
  * `git stash pop`

- `git-stash-apply`
  * `git stash apply`

- `git-stash-branch`
  * `git stash branch`

- `git-stash-clear`
  * `git stash clear`

- `git-stash-drop`
  * `git stash drop`

- `git-stash-create`
  * `git stash create`

- `git-status`
  * `git status`

- `git-tag`
  * `git tag`

$FILE -- �J�����g�o�b�t�@���Q�Ƃ��Ă���t�@�C��
$PROMPT -- �~�j�o�b�t�@�œ��͂��s���܂�


## Variable

- `*git-binary*`
  * git.exe �̃p�X
  * �����l: `"git.exe"`

- `*git-environ*`
  * �K���ݒ肷����ϐ�
    '(("VARNAME" . "VAR"))
  * �����l: `'(("GIT_EDITOR" . "$XYZZY/xyzzycli.exe -wait"))`

- `*git-process-encoding*`
  * git.exe �̕����R�[�h
  * �����l: `*encoding-utf8n*`

- `*git-process-eol-code*`
  * git.exe �̉��s�R�[�h
  * �����l: `*eol-lf*`

- `*git-wrapper-bat*`
  * git-wrapper.bat �̃p�X(nil �Ȃ疳��)
    no-std-handles �� t �̍ۂ� git-wrapper.bat ���g�p����
  * �����l: `$XYZZY/site-lisp/xl-git/git-wrapper.bat`

- `*git-commit-message-file*`
  * �R�~�b�g���b�Z�[�W�t�@�C����
    ���|�W�g���̃g�b�v�f�B���N�g������̑��΃p�X
  * �����l: `".git/COMMIT_EDITMSG"`

- `*git-commit-message-encoding*`
  * �R�~�b�g���b�Z�[�W�̕����R�[�h
  * �����l: `*encoding-utf8n*`

- `*git-commit-message-eol-code*`
  * �R�~�b�g���b�Z�[�W�̉��s�R�[�h
  * �����l: `*eol-lf*`

- `*git-output-bufname*`
  * �o�̓o�b�t�@��
  * �����l: `"*Git*"`

- `*git-temp-bufname*`
  * ��ƃo�b�t�@��
  * �����l: `" *Git Temp*"`

- `*git-output-split-vertical-p*`
  * �o�̓o�b�t�@�͏c�ɕ�������
  * �����l: `t`

- `*git-log-default-limit*`
  * log�̃f�t�H���g����
  * �����l: `100`

- `*git-branch-color-current*`
  * branch�̌��݃u�����`�̐F
  * �����l: `'(:color 2)`

- `*git-branch-color-remote*`
  * branch�̃����[�g�u�����`�̐F
  * �����l: `'(:color 1)`

- `*git-diff-color-header*`
  * diff�̃w�b�_�̐F
  * �����l: `'(:color 0 0 :bold)`

- `*git-diff-color-add*`
  * diff�̒ǉ��s�̐F
  * �����l: `'(:color 2)`

- `*git-diff-color-remove*`
  * diff�̍폜�s�̐F
  * �����l: `'(:color 1)`

- `*git-diff-color-area*`
  * diff�͈̔͏��̐F
    @@ -R +R @@
  * �����l: `'(:color 6)`

- `*git-log-color-line*`
  * graph log�̐��̐F
  * �����l: `'(:color 1)`

- `*git-log-color-sha*`
  * log��SHA�̐F
  * �����l: `'(:color 3)`

- `*git-log-color-brace*`
  * log�̊��ʂ̐F
  * �����l: `'(:color 3)`

- `*git-log-color-head*`
  * log��HEAD�̐F
  * �����l: `'(:color 6 0 :bold)`

- `*git-log-color-branch*`
  * log�̃u�����`���̐F
  * �����l: `'(:color 2 0 :bold)`

- `*git-log-color-remote-branch*`
  * log�̃����[�g�u�����`���̐F
  * �����l: `'(:color 1 0 :bold)`

- `*git-log-color-tag*`
  * log�̃^�O���̐F
  * �����l: `'(:color 3 0 :bold)`

- `*git-commit-message-mode-hook*`
  * git-commit-message-mode�N�����Ɏ��s����܂�
  * �����l: `nil`

- `*git-output-mode-hook*`
  * git-output-mode�N�����Ɏ��s����܂�
  * �����l: `nil`

- `*git-commit-message-mode-map*`
  * �R�~�b�g���b�Z�[�W���[�h�̃L�[�}�b�v
  * �����l:
    
    ```lisp
    (define-key *git-commit-message-mode-map* '(#\C-x #\C-s) 'git-commit-start)
    (define-key *git-commit-message-mode-map* '(#\C-c #\C-c) 'git-commit-start)
    (define-key *git-commit-message-mode-map* '(#\C-c #\C-g) 'git-output-quit))
    ```

- `*git-output-mode-map*`
  * �o�̓��[�h�̃L�[�}�b�v
  * �����l:
    
    ```lisp
    (dotimes (n #x80)
      (define-key *git-output-mode-map* (code-char n) 'git-output-send-and-funcall))
    (undefine-key *git-output-mode-map* #\ESC)
    (undefine-key *git-output-mode-map* #\C-c)
    (undefine-key *git-output-mode-map* #\C-x)
    (define-key *git-output-mode-map* '(#\C-c #\C-g) 'git-output-quit)
    (define-key *git-output-mode-map* '#\RET 'git-output-send-LFD-or-newline)
    (define-key *git-output-mode-map* '#\q 'git-output-send-or-quit))
    ```
