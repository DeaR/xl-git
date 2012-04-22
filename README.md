# xl-git

A front end for git in [xyzzy].

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/


## Install
1.	解凍して [xyzzy] のインストールディレクトリにコピーして下さい

2.	.xyzzy または siteinit.l に以下のコードを追加します
	
	```lisp
	(require "xl-git")
	(git-install)
	```

3.	更に環境固有の設定も追加します
	*	[msysgit] を使用する場合
		
		```lisp
		; $MSYSGIT_DIR を msysgit のインストールディレクトリに置換して下さい
		(push (cons "PATH"
		             (format nil 
		                     "$MSYSGIT_DIR\\bin;$MSYSGIT_DIR\\mingw\\bin;$MSYSGIT_DIR\\cmd;~A;~A"
		                     (map-slash-to-backslash (si:system-root)) (si:getenv "PATH")))
		      *git-environ*)
		(push '("GIT_EDITOR" . "xyzzycli.exe -wait") *git-environ*)
		
		; cygwin をインストールしている場合、下記を設定して下さい
		(push '("CYGWIN" . "") *git-environ*)
		```
	*	[cygwin] を使用する場合
		
		```lisp
		; $CYGWIN_DIR を cygwin のインストールディレクトリに置換して下さい
		(push (cons "PATH"
		            (format nil 
		                    "$CYGWIN_DIR\\usr\\local\\bin;$CYGWIN_DIR\\usr\\bin;$CYGWIN_DIR\\bin;~A;~A"
		                    (map-slash-to-backslash (si:system-root)) (si:getenv "PATH")))
		      *git-environ*)
		(push '("GIT_EDITOR" . "xyzzycli.exe -wait") *git-environ*)
		
		; Windowsが95,98,Me以外の場合、下記を設定して下さい
		(push '("CYGWIN" . "ntsec") *git-environ*)
		```

4.	(必要ならば) バイトコンパイルします

5.	上記の設定を反映させる為に再起動をします
	siteinit.l に設定した場合は再ダンプを行って下さい

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/
  [msysgit]: http://msysgit.github.com/
  [cygwin]: http://www.cygwin.com/


## Usage
-	`M-x git-init`
-	`M-x git-add`
-	`M-x git-commit`

etc...

-	実行すると `*Git*` バッファが開かれます
	終了(モードラインに:Exit)の場合は `C-c C-g` もしくは `q` で、
	実行中(モードラインに:Run)の場合は `C-c C-g` で、終了します

-	`git-commit` では `*Git*` バッファにコミットメッセージを入力し、
	`C-c C-c` もしくは `C-x C-s` でコミットを実行、
	`C-c C-g` でキャンセルします


## Setting
-	`git-install` の任意引数
	
	```lisp
	git-install &rest options
	```
	*	`:flow` -- [git-flow] のコマンドを利用する
	*	例:
		
		```lisp
		(git-install :flow)
		```

-	他のコマンドを関数として追加したい
	
	```lisp
	git::define-git-command command &rest options
	```
	*	`command` -- gitコマンド
	*	`:name` -- 別の関数名を指定する
	*	`:package` -- 別のパッケージを指定する(未実装)
	*	`:documentation` -- 関数のドキュメントコメント
	*	`:completion` -- 補完候補
	*	`:dir-prompt` -- ディレクトリ入力を行わせる
	*	`:no-prompt` -- 引数入力を行わない
	*	`:mode` -- 指定のメジャーモードを使用する
	*	`:no-std-handles` -- 全て外部コマンドプロンプト上で動作させる
	*	例:
		
		```lisp
		; 自分仕様 git-log 改め git-glog
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
下記のどちらかにでもご連絡下さい

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
