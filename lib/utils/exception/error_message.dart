class EM {
  static Exception primaryError = Exception('ネットワーク環境とURLをご確認の上\nもう一度実行して下さい。');

  static Exception urlError = Exception('URLに誤りがあるようです。'
      '\n'
      '再度ご確認の上、もう一度実行して下さい。');

  static Exception netWorkError = Exception('エラーが発生しました。'
      '\n'
      'ネットワーク環境をご確認の上'
      '\n'
      'もう一度実行して下さい。');

  static Exception unKnownError = Exception('不明なエラーが発生しました'
      '\n'
      '${EM.primaryError}');

  static Exception photoAccessDenied = Exception('写真フォルダのアクセスがありません'
      '\n'
      '権限を変更してもう一度実行してください。');

  static Exception invalidPhoto = Exception('無効な画像です'
      '\n'
      '別の写真を選択するか、もう一度実行してみてください。');
}
