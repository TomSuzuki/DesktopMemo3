// ------------------------------------------------------------
// JsonParser - 簡易JSONパーサー
// ------------------------------------------------------------
// 単純な Key:Value の解析・生成を行います（配列には非対応）。
// 区切り文字はキーやデータで使用されていない想定。

#module

// jsonsel ...JSON文字列を設定します。
#deffunc jsonsel str _p1

  // unicode に変換
  tmp = _p1
  sdim jsondatauni, strlen(tmp) * 8
  cnvstow jsondatauni, tmp

  // 不要な文字を消去
  sdim tmp, strlen(tmp) * 8
  isdata = 0
  repeat
    v = wpeek(jsondatauni, cnt * 2)
    if (v == 0) : break
    if cnvwtos(v) == "\"" : isdata = (isdata == 0)

    // データ部以外は不要な文字を除外
    if (isdata == 0) {
      if cnvwtos(v) == " "  : continue
      if cnvwtos(v) == "\t" : continue
      if cnvwtos(v) == "\n" : continue
      if cnvwtos(v) == "\r" : continue
      if cnvwtos(v) == ""   : continue
      if v == $0A : continue // \n
      if v == $0D : continue // \r
    }

    // 文字追加
    tmp = tmp + cnvwtos(v)
  loop

  // 消去した文字を設定
  sdim jsondatauni, strlen(tmp) * 8
  cnvstow jsondatauni, tmp

  return

// jsontostr ...JSON文字列を取得します。
#defcfunc jsontostr
  tmp = ""
  indent = 0
  repeat
    v = wpeek(jsondatauni, cnt * 2)
    if v == 0 : break
    s = cnvwtos(v)
    if s == "}" : indent--
    if s == "}" {
      tmp = tmp + "\n"
      repeat indent * 2
        tmp = tmp + " "
      loop
    }

    tmp = tmp + s

    if s == ":" {
      tmp = tmp + " "
    }

    if s == "{" : indent++
    if s == "{" || s == "," {
      tmp = tmp + "\n"
      repeat indent * 2
        tmp = tmp + " "
      loop
    }
  loop
  return tmp

// jsonget ...JSON値を取得します。
//  p1 ...キーセット（Key1,Key2...）。
#defcfunc jsonget str _p1
  return jsonwork(_p1, 0, "")

// jsonset ...JSON値を登録または更新します。
//  p1 ...キーセット（Key1,Key2...）。
//  p2 ...更新後の値。
#defcfunc jsonset str _p1, str _p2
  tmp = _p2
  if (str(int(tmp)) == tmp) {
    // 何もしない
  } else {
    tmp = strtrim(tmp, 0, '\"')
    tmp = "\"" + tmp + "\""
  }
  return jsonwork(_p1, 1, tmp)

// jsonwork ...内部用関数
//  p1 ...キーセット
//  p2 ...更新有無
//  p3 ...更新値
#defcfunc jsonwork str _p1, int _p2, str _p3
  keyset = _p1
  isUpsert = _p2
  upsertValue = _p3

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
      w = wpeek(keyuni, ch * 2)
      if (v == 0) : break

      // 開始括弧より多い閉じ括弧の場合は終了（キーや値に括弧が含まれない想定）
      if ch == 0 {
        if cnvwtos(v) == "{" : kakko++
        if cnvwtos(v) == "}" : kakko--
        if kakko < 0 : break
      }

      // 一致チェック
      if (w == 0) {
        // 空白、タブを除いて「:」が次に来るかチェック
        isComplete = 0
        repeat
          vp = wpeek(jsondatauni, nmoji * 2)
          nmoji++
          if cnvwtos(vp) = ":" : isComplete = 1 : break
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
    if sh == -1 {
      if (isUpsert) {
        nmoji--
        ins = ""
        toji = ""
        repeat length(keysets) - cnt, cnt
          if ins != "" : ins = ins + "{" : toji = toji + "}"
          ins = ins + "\"" + keysets.cnt + "\":"
        loop
        insstr = ins + upsertValue + toji

        tmp = ""
        before = ""
        repeat
          v = wpeek(jsondatauni, cnt * 2)
          if v == 0 : break
          tmp = tmp + cnvwtos(v)
          if cnt == nmoji {
            if before != "{" : tmp = tmp + ","
            tmp = tmp + insstr
          }
          before = cnvwtos(v)
        loop

        sdim jsondatauni, strlen(tmp) * 8
        cnvstow jsondatauni, tmp
      }
      break
    }

  loop

  // 見つからなかった
  if (sh == -1) {
    return ""
  }

  // 見つかった
  response = ""
  isExit = 0
  repeat -1, nmoji
    v = wpeek(jsondatauni, cnt * 2)
    if (v == 0) : break
    if (cnvwtos(v) == ",") : break
    if (cnvwtos(v) == "}") : break

    // 数値
    isExit = isExit || ("\"" != strmid(response, 0, 1) && cnvwtos(v) == " " && response != "")
    isExit = isExit || ("\"" != strmid(response, 0, 1) && cnvwtos(v) == "," && response != "")
    isExit = isExit || ("\"" != strmid(response, 0, 1) && cnvwtos(v) == "}" && response != "")
    if isExit : break

    // 文字列
    isExit = isExit || ("\"" == strmid(response, 0, 1) && cnvwtos(v) == "\"")
    response = response + cnvwtos(v) ; 戻り値
    if isExit : break
  loop

  // 更新
  if (isUpsert) {
    tmp = ""
    k = 0
    flg = 1
    sdim responseuni, strlen(response) * 8
    cnvstow responseuni, response
    repeat
      v = wpeek(jsondatauni, k * 2)
      if v == 0 : break

      // 文字結合
      if nmoji == k && flg == 1 {
        flg = 0
        repeat
          w = wpeek(responseuni, cnt * 2)
          if w == 0 : break
          k++
        loop
        tmp = tmp + upsertValue
      } else {
        tmp = tmp + cnvwtos(v)
        k++
      }

    loop

    sdim jsondatauni, strlen(tmp) * 8
    cnvstow jsondatauni, tmp
  }

  // トリム
  response = strtrim(response, 0)
  if str(int(response)) == response : return int(response)
  response = strtrim(response, 0, '\"')

  return response

#global
