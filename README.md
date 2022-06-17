# DesktopMemo3 - version 1.0.0
デスクトップに貼るメモ。
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

## フォルダについて
- `backup` ...起動時とメモ読み込み時に、メモの内容をコピーして保存します。
- `img` ...使用する画像データが入っています。
- `memo` ...メモの情報が入ったフォルダです。
- `note` ...メモのテキストが入ったフォルダです。
- `trash` ...削除したメモの情報が入ったフォルダです。

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
