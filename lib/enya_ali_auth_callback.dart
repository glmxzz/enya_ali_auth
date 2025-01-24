
abstract class EnyaAliAuthCallback {
  /// sdk响应结果，原始数据，一般的交互不需要在该方法做处理，已经分发给以下几个方法了。
  void onResponseResult(String result);

  void onThirdLogin(int type);

  void onCheckChange(bool isCheck);

  void onTokenSuc(String token);

  void onLoginExist();

  void onUserExist();

  void onTokenFail();
}
