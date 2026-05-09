<p align="center">
 <img align="center" src="./img/app.ico">
 <h2 align="center"><a href="https://github.com/TomSuzuki/DesktopMemo3">DesktopMemo3</a></h2>
 <p align="center">デスクトップに貼るメモ。</p>
</p>
<p align="center">
  <a href="">
    <img alt="Lang" src="http://img.shields.io/badge/Language-HSP3-green" />
  </a>
</p>

Windows上でのみ動作確認を行っています。

実行ファイルを起動してご使用ください。
スタートアップ等に登録すると便利です。

終了はタスクトレイから行うことができます。

メモは、他のメモの「＋」ボタンか、タスクトレイメニューから作成することができます。

## 色の設定について `theme/***.json`
各ファイルに8色登録することができます。`$`から始まる16進数のカラーコードで書いてください。
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
- `menu_text_length` ...メモメニューに表示する文字数の設定です。
- `translucent_rate` ...メモの半透明化率の設定です（0～100）。
- `color_name` ...使用する色セットファイルの名称です。

## フォルダについて
- `backup` ...起動時とメモ読み込み時に、メモの内容をコピーして保存します。
- `img` ...使用する画像データが入っています。
- `memo` ...メモの情報が入ったフォルダです。
- `note` ...メモのテキストが入ったフォルダです。
- `trash` ...削除したメモの情報が入ったフォルダです。
- `theme` ...テーマカラーの設定が入ったフォルダです。

## 動作環境
- 開発バージョン: `HSP3.7`
- OS: `Windows 11 Pro`

## ビルド方法

`Build` フォルダ内の `build.hsp` を実行してください。

## 参考にさせていただいたもの
- [タスクトレイアイコンモジュール - つーさのくーかん](https://tu3.jp/0108)
- [WINAPI ウィンドウメッセージリスト](http://chokuto.ifdef.jp/urawaza/message/index.html)
- [Win32エラーコード一覧](http://ir9.jp/prog/ayu/win32err.htm)
- [HSPEXT ver3.3 REFERENCE MANUAL](http://www.onionsoft.net/hsp/v33/doclib/hspext.txt)
