<p align="center">
 <img align="center" src="./img/app.ico">
 <h2 align="center"><a href="https://github.com/TomSuzuki/DesktopMemo3">DesktopMemo3</a></h2>
 <p align="center">デスクトップに貼るメモ。</p>
</p>
<p align="center">
  <a href="https://github.com/anuraghazra/github-readme-stats/issues">
    <img alt="Issues" src="https://img.shields.io/github/issues/TomSuzuki/DesktopMemo3?color=0088ff" />
  </a>
  <a href="">
    <img alt="Lang" src="http://img.shields.io/badge/Language-HSP3-green" />
  </a>
</p>

Windows上でのみ動作確認を行っています。

実行ファイルを起動してご使用ください。
スタートアップ等に登録すると便利です。

終了はタスクトレイから行うことができます。

メモは、他のメモの「＋」ボタンか、ファイルのドラッグアンドドロップ、タスクトレイから作成することができます。
ドラッグアンドドロップ時は、元のファイルに上書きされますのでご注意ください。

※まれに文字化けします。ドラッグアンドドロップで使用する際は、必ずバックアップをとってください。

## 色の設定について `color.json`
8色登録することができます。`$`から始まる16進数のカラーコードで書いてください。
- `text` ...文字色です。
- `theme` ...タイトルバーの色です。
- `box` ...文字の背景色です。

## その他の設定について `setting.json`
- `font` ...使用するフォントです。
- `font_size` ...フォントの大きさです。
- `font_style` ...`0`が通常、`1`が太字です。
- `button_color` ...基本のボタン色です。
- `button_color_click` ...クリック時のボタン色です。
- `button_color_mouseover` ...マウスホバー時のボタン色です。
- `delete_dialog` ...削除時にダイアログを表示するかの設定です。 `1`で有効、`2`で無効です。

## フォルダについて
- `backup` ...起動時とメモ読み込み時に、メモの内容をコピーして保存します。
- `img` ...使用する画像データが入っています。
- `memo` ...メモの情報が入ったフォルダです。
- `note` ...メモのテキストが入ったフォルダです。
- `trash` ...削除したメモの情報が入ったフォルダです。
- `theme` ...コピペで使えるカラーテーマです。ファイルの中身を`color.json`にコピーすることで、テーマを変えることができます。

## 動作環境
- 開発バージョン: `HSP3.6`
- OS: `Windows 10 Home`

## ビルド方法
- [VSCode で HSP3 の開発環境を作る [2019年末] - Qiita](https://qiita.com/vain0x/items/1c0be49b3b22142dbfd1)
```shell
ginger build --release main.hsp
```

## 参考にさせていただいたもの
- [HSP用 ドラッグ・アンド・ドロップ モジュール - 略して仮。](http://menyukko.ifdef.jp/cauldron/hmdandd.html)
- [タスクトレイアイコンモジュール - つーさのくーかん](https://tu3.jp/0108)
- [WINAPI ウィンドウメッセージリスト](http://chokuto.ifdef.jp/urawaza/message/index.html)
- [Win32エラーコード一覧](http://ir9.jp/prog/ayu/win32err.htm)
- [HSPEXT ver3.3 REFERENCE MANUAL](http://www.onionsoft.net/hsp/v33/doclib/hspext.txt)
- [HSPINET ver3.3 REFERENCE MANUAL](http://www.onionsoft.net/hsp/v33/doclib/hspinet.txt)

## 使用しているDLL
- `shell32.dll`
- `user32.dll`
- `gdi32.dll`
- `hspext.dll`
- `hspinet.dll`

## ライセンス表記
### hspinet.dll
```
OpenHSP Copyright (c) 1997-2012, Onion Software/onitama.
  NKF Copyright (C) 1987, FUJITSU LTD. (I.Ichikawa).
  NKF Copyright (C) 1996-2009, The nkf Project.
  cJSON Copyright (c) 2009 Dave Gamble

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.
  ```
