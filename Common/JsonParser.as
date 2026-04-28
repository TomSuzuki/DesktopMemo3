// ------------------------------------------------------------
// JsonParser - 簡易JSONパーサー
// ------------------------------------------------------------
// 単純な Key:Value の解析・生成を行います（配列には非対応）。
// 区切り文字はキーやデータで使用されていない想定。

#module

// jsonsel ...JSON文字列を設定します。
#deffunc jsonsel str _p1
  jsondata = _p1
  sdim jsondatauni, strlen(jsondata) * 8
  cnvstow jsondatauni, jsondata
  return

// jsonget ...JSON値を取得します。
//  p1 ...キーセット（Key1,Key2...）。
#defcfunc jsonget str _p1
  keyset = _p1

  // キーセットを分割
  sdim keysets
  split keyset, ",", keysets

  // キーごとに処理
  nmoji = 0
  foreach keysets
    // 現在のキー
    key = "\"" + keysets.cnt + "\""
    sdim keyuni, strlen(key) * 8
    cnvstow keyuni, key
    ch = 0
    sh = -1
    kakko = -1

    // 次の開き括弧まで進める
    repeat
      v = wpeek(jsondatauni, nmoji * 2)
      if (v == 0) : break
      if (cnvwtos(v) == "{") : break
      nmoji++
    loop

    // 順番に探していく
    repeat
      v = wpeek(jsondatauni, nmoji * 2)
      if (v == 0) : break

      // 開始括弧より多い閉じ括弧の場合は終了（キーや値に括弧が含まれない想定）
      if cnvwtos(v) == "{" : kakko++
      if cnvwtos(v) == "}" : kakko--
      if kakko < 0 : break

      // 一致チェック
      w = wpeek(keyuni, ch * 2)
      if (w == 0) {
        // 空白、タブを除いて「:」が次に来るかチェック
        isComplete = 0
        repeat
          vp = wpeek(jsondatauni, nmoji * 2)
          nmoji++
          if cnvwtos(vp) = ":" : isComplete = 1 : break
          if cnvwtos(vp) != " " && cnvwtos(vp) != "\t" : break
        loop

        // 探索完了
        if (isComplete) {
          sh = ch
          break
        }
      }
      
      // 文字を進める
      nmoji++
      ch++
      if w != v {
        nmoji = nmoji - ch + 1
        ch = 0
      }
    loop

    // 見つからなかった
    if sh == -1 : break

  loop

  // 見つからなかった
  if (sh == -1) {
    return ""
  }

  // 見つかった
  response = ""
  repeat -1, nmoji
    v = wpeek(jsondatauni, cnt * 2)
    if (v == 0) : break
    if (cnvwtos(v) == ",") : break
    if (cnvwtos(v) == "}") : break
    trimres = strtrim(response, 0, ' ')
    trimres = strtrim(trimres, 0, '\t')
    if ("\"" == strmid(trimres, 0, 1) && cnvwtos(v) = "\"") : break
    if ("\"" != strmid(trimres, 0, 1) && cnvwtos(v) = " " && response != "") : break
    response = response + cnvwtos(v)
  loop

  // トリム
  response = strtrim(response, 0)
  response = strtrim(response, 0, ' ')
  response = strtrim(response, 0, '\t')
  response = strtrim(response, 0, '\"')

  return response

#global
