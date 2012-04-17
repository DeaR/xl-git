# xl-git

A front end for git in xyzzy.


## Install

1. 解凍して$XYZZYにコピーして下さい

2. .xyzzy または siteinit.l に以下のコードを追加します
   
     ```lisp
     (require "xl-git")
     ```

3. (必要ならば) バイトコンパイルします

4. 上記の設定を反映させる為に再起動をします
   siteinit.l に設定した場合は再ダンプを行って下さい

  [マルチフレーム版xyzzy]: https://bitbucket.org/mumurik/xyzzy/wiki/Home
  [NAXEL]: https://bitbucket.org/mumurik/xyzzy/wiki/NAXEL


## Usage

- `M-x git-init`
- `M-x git-add`
- `M-x git-commit`

etc...

- 実行すると `*Git*` バッファが開かれます
  終了(モードラインに:Exit)の場合は `C-c C-g` もしくは `q` で、
  実行中(モードラインに:Run)の場合は `C-c C-g` で、終了します

- `git-commit` では `*Git*` バッファにコミットメッセージを入力し、
  `C-c C-c` もしくは `C-x C-s` でコミットを実行、
  `C-c C-g` でキャンセルします


## Setting
- [msysgit] を使用
  
    ```lisp
    (pushnew `("PATH" . ,(concat "$MSYSGIT/bin;$MSYSGIT/mingw/bin;$MSYSGIT/cmd;" (si:getenv "PATH"))) *git-environ* :test #'equal)
    ```
  $MSYSGIT -- [msysgit] のインストールディレクトリ

- [msysgit] と [cygwin] が同居していて、 [msysgit] を使用
  
    ```lisp
    (pushnew '("CYGWIN" . "") *git-environ* :test #'equal)
    ```

- [git-flow] を利用している
  
    ```lisp
    (require "xl-git-flow")
    ```

- 他のコマンドを関数として追加したい
  * `git::define-git-command command &key :document :symbol :prompt :dir-prompt :minor-mode :no-std-handles`
    + `command` -- gitコマンド
    + `:document` -- 関数のドキュメントコメント
    + `:symbol` -- 別の関数名を指定する
    + `:prompt` -- 強制的に引数入力を行わせる
    + `:dir-prompt` -- ディレクトリ入力を行わせる
    + `:minor-mode` -- 指定のマイナーモードを使用する
    + `:no-std-handles` -- 全て外部コマンドプロンプト上で動作させる
    + 例:
      
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
REFERENCE.md を参照ください


## Issues
下記のどちらかにでもご連絡下さい

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
