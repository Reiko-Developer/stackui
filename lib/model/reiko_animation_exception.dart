class ReikoAnimationException implements Exception {
  ReikoAnimationException(this._message, this._code);
  final String _message;

  final int _code;

  @override
  String toString() {
    return 'Status code: $_code, ' + _message;
  }

  String get message {
    return _message;
  }

  int get code {
    return _code;
  }
}
