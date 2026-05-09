// ------------------------------------------------------------
// Clipboard - クリップボード操作
// ------------------------------------------------------------

#module

#const CF_UNICODETEXT 13

#uselib "user32.dll"
#func OpenClipboard    "OpenClipboard"    sptr
#func EmptyClipboard   "EmptyClipboard"
#func SetClipboardData "SetClipboardData" sptr, sptr
#func CloseClipboard   "CloseClipboard"
#func GetClipboardData "GetClipboardData" sptr

#const GHND 0x0042

#uselib "kernel32.dll"
#func GlobalAlloc   "GlobalAlloc"   sptr, sptr
#func GlobalLock    "GlobalLock"    sptr
#func RtlMoveMemory "RtlMoveMemory" sptr, sptr, sptr
#func GlobalUnlock  "GlobalUnlock"  sptr
#func GlobalSize    "GlobalSize"    sptr

// クリップボードに文字列をコピーします。
#deffunc ClipboardCopy str _p1

  // コピー用データを用意
  tmp = _p1
  sdim copyData, strlen(tmp) * 8
  cnvstow copyData, tmp
  hMem = GlobalAlloc(GHND, varsize(copyData))
  if (hMem == 0) : return -1
  hPtr = GlobalLock(hMem)
  RtlMoveMemory hPtr, varptr(copyData), varsize(copyData)
  GlobalUnlock(hMem)

  // クリップボードを確保
  if (OpenClipboard(0) == 0) : return -1

  // クリップボードを開放
  EmptyClipboard

  // クリップボードへ貼り付け
  SetClipboardData CF_UNICODETEXT, hMem

  // クリップボードを開放
  CloseClipboard

  return

// クリップボードから文字列を取得します。
#defcfunc ClipboardGet

  // クリップボードを確保
  if (OpenClipboard(0) == 0) : return -1

  // クリップボードから取得
  hMem = GetClipboardData(CF_UNICODETEXT)
  if (hMem == 0) : return ""

  // 文字列を取得
  hPtr = GlobalLock(hMem)
  sdim tmp, GlobalSize(hPtr) + 1
  dupptr tmp, hPtr, GlobalSize(hPtr) + 1,2
  GlobalUnlock(hMem)
  response = cnvwtos(tmp)

  // クリップボードを開放
  CloseClipboard

  return response

#global
