# xl-git

A front end for [git] in [xyzzy].

  [git]: http://git-scm.com/
  [xyzzy]: http://www.jsdlab.co.jp/~kamei/


## Install
1. 解凍して [xyzzy] のインストールディレクトリにコピーします

2. `.xyzzy` または `siteinit.l` に以下のコードを追加します
   
   ```lisp
   (require "xl-git")
   ```

3. 環境変数 `GITDIR` を設定していない場合は以下も追加します
   
   ```lisp
   ; 自分の環境での msysgit のインストールディレクトリに変更して下さい
   (setf *msysgit-directory* "C:/msysgit")
   ```

4. (必要ならば) バイトコンパイルします

5. 上記の設定を反映させる為に再起動をします
   `siteinit.l` に設定した場合は再ダンプも行います

  [xyzzy]: http://www.jsdlab.co.jp/~kamei/


## Usage
- `M-x git-init`
- `M-x git-add`
- `M-x git-commit`
- `M-x git-push`
- etc...

### `*Git*` バッファ
- モードラインに `:Run` (プロセス実行中)の場合は `C-c C-g` で終了
- モードラインに `:Exit` (プロセス終了)の場合は `C-c C-g` もしくは `q` で終了

### `COMMIT_EDITMSG` や `TAG_EDITMSG` バッファ等
- `C-c C-c` もしくは `C-x C-s` で実行
- `C-c C-g` でキャンセル


## Setting
### [git-flow] のコマンドを追加したい
```lisp
(require "xl-git-flow")
```

### [msysgit] ではなく [cygwin] を使用したい
```lisp
(setf *msysgit-directory* nil)
```
環境変数にPATH等を設定していない場合は以下を参考に設定して下さい
```lisp
; 自分の環境での cygwin のインストールディレクトリに変更して下さい
(push `(("PATH" . ,(concat "C:/cygwin/usr/local/bin;C:/cygwin/bin;" (si:getenv "PATH")))
        ("CYGWIN" . "ntsec"))
      *git-environ*)
```

### [cygwin] を導入済みだが [msysgit] を使用したい
```lisp
(push '("CYGWIN" . "") *git-environ*)
```

### 引数の入力時に補完入力を使用する (実験機能)
```lisp
(setf *git-completing-prompt* t)
```

  [git-flow]: https://github.com/nvie/gitflow
  [msysgit]: http://msysgit.github.com/
  [cygwin]: http://www.cygwin.com/


## Issue
下記のどちらかにご連絡下さい

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
