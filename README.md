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
		             (format nil "$MSYSGIT_DIR\\bin;$MSYSGIT_DIR\\mingw\\bin;$MSYSGIT_DIR\\cmd;~A;~A"
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
		            (format nil "$CYGWIN_DIR\\usr\\local\\bin;$CYGWIN_DIR\\usr\\bin;$CYGWIN_DIR\\bin;~A;~A"
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
	*	`:bisect` -- 詳細な `git-bisect` のコマンドを利用する
	*	`:stash` -- 詳細な `git-stash` のコマンドを利用する
	*	`:flow` -- [git-flow] のコマンドを利用する
	*	例:
		
		```lisp
		(git-install :bisect :stash)
		```

-	他のコマンドを関数として追加したい
	
	```lisp
	git::define-git-command command &key :document :symbol :prompt :dir-prompt
	                                     :minor-mode :no-std-handles
	```
	*	`command` -- gitコマンド
	*	`:document` -- 関数のドキュメントコメント
	*	`:symbol` -- 別の関数名を指定する
	*	`:prompt` -- 強制的に引数入力を行わせる
	*	`:dir-prompt` -- ディレクトリ入力を行わせる
	*	`:minor-mode` -- 指定のマイナーモードを使用する
	*	`:no-std-handles` -- 全て外部コマンドプロンプト上で動作させる
	*	例:
		
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
		This form resets the index entries for all <paths> to their state at <commit>.
		(It does not affect the working tree, nor the current branch.)"
		  :file-arg t)
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
