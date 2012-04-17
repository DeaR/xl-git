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

$FILE -- カレントバッファが参照しているファイル
$PROMPT -- ミニバッファで入力を行います


## Variable

- `*git-binary*`
  * git.exe のパス
  * 初期値: `"git.exe"`

- `*git-environ*`
  * 必ず設定する環境変数
    '(("VARNAME" . "VAR"))
  * 初期値: `'(("GIT_EDITOR" . "$XYZZY/xyzzycli.exe -wait"))`

- `*git-process-encoding*`
  * git.exe の文字コード
  * 初期値: `*encoding-utf8n*`

- `*git-process-eol-code*`
  * git.exe の改行コード
  * 初期値: `*eol-lf*`

- `*git-wrapper-bat*`
  * git-wrapper.bat のパス(nil なら無効)
    no-std-handles が t の際に git-wrapper.bat を使用する
  * 初期値: `$XYZZY/site-lisp/xl-git/git-wrapper.bat`

- `*git-commit-message-file*`
  * コミットメッセージファイル名
    リポジトリのトップディレクトリからの相対パス
  * 初期値: `".git/COMMIT_EDITMSG"`

- `*git-commit-message-encoding*`
  * コミットメッセージの文字コード
  * 初期値: `*encoding-utf8n*`

- `*git-commit-message-eol-code*`
  * コミットメッセージの改行コード
  * 初期値: `*eol-lf*`

- `*git-output-bufname*`
  * 出力バッファ名
  * 初期値: `"*Git*"`

- `*git-temp-bufname*`
  * 作業バッファ名
  * 初期値: `" *Git Temp*"`

- `*git-output-split-vertical-p*`
  * 出力バッファは縦に分割する
  * 初期値: `t`

- `*git-log-default-limit*`
  * logのデフォルト件数
  * 初期値: `100`

- `*git-branch-color-current*`
  * branchの現在ブランチの色
  * 初期値: `'(:color 2)`

- `*git-branch-color-remote*`
  * branchのリモートブランチの色
  * 初期値: `'(:color 1)`

- `*git-diff-color-header*`
  * diffのヘッダの色
  * 初期値: `'(:color 0 0 :bold)`

- `*git-diff-color-add*`
  * diffの追加行の色
  * 初期値: `'(:color 2)`

- `*git-diff-color-remove*`
  * diffの削除行の色
  * 初期値: `'(:color 1)`

- `*git-diff-color-area*`
  * diffの範囲情報の色
    @@ -R +R @@
  * 初期値: `'(:color 6)`

- `*git-log-color-line*`
  * graph logの線の色
  * 初期値: `'(:color 1)`

- `*git-log-color-sha*`
  * logのSHAの色
  * 初期値: `'(:color 3)`

- `*git-log-color-brace*`
  * logの括弧の色
  * 初期値: `'(:color 3)`

- `*git-log-color-head*`
  * logのHEADの色
  * 初期値: `'(:color 6 0 :bold)`

- `*git-log-color-branch*`
  * logのブランチ名の色
  * 初期値: `'(:color 2 0 :bold)`

- `*git-log-color-remote-branch*`
  * logのリモートブランチ名の色
  * 初期値: `'(:color 1 0 :bold)`

- `*git-log-color-tag*`
  * logのタグ名の色
  * 初期値: `'(:color 3 0 :bold)`

- `*git-commit-message-mode-hook*`
  * git-commit-message-mode起動時に実行されます
  * 初期値: `nil`

- `*git-output-mode-hook*`
  * git-output-mode起動時に実行されます
  * 初期値: `nil`

- `*git-commit-message-mode-map*`
  * コミットメッセージモードのキーマップ
  * 初期値:
    
    ```lisp
    (define-key *git-commit-message-mode-map* '(#\C-x #\C-s) 'git-commit-start)
    (define-key *git-commit-message-mode-map* '(#\C-c #\C-c) 'git-commit-start)
    (define-key *git-commit-message-mode-map* '(#\C-c #\C-g) 'git-output-quit))
    ```

- `*git-output-mode-map*`
  * 出力モードのキーマップ
  * 初期値:
    
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
