# xl-git

A front end for git in [xyzzy].

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/


## Install
1.	解凍して [xyzzy] のインストールディレクトリにコピーして下さい

2.	.xyzzy または siteinit.l に以下のコードを追加します
	
	```lisp
	(require "xl-git")
	```

3.	更に環境固有の設定も追加します
	*	[msysgit] を使用する場合
		
		```lisp
		; 自分の環境での msysgit のインストールディレクトリに変更して下さい
		(git-install :msysgit "C:/Program Files/Git")
		```
	*	[cygwin] を使用する場合
		
		```lisp
		; 自分の環境での cygwin のインストールディレクトリに変更して下さい
		(git-install :cygwin "C:/cygwin")
		```
	*	[git-flow] のコマンドも追加する場合
		
		```lisp
		; :flow を追加してください
		(git-install :msysgit "C:/Program Files/Git" :flow)
		```

4.	(必要ならば) バイトコンパイルします

5.	上記の設定を反映させる為に再起動をします
	siteinit.l に設定した場合は再ダンプを行って下さい

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/
  [msysgit]: http://msysgit.github.com/
  [cygwin]: http://www.cygwin.com/
  [git-flow]: https://github.com/nvie/gitflow


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
