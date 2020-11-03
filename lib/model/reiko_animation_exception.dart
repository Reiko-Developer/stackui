import 'package:flutter/material.dart';

enum ReikoExceptions {
  SizeAnimations,
  ColorAnimations,
  OpacityAnimations,
  TranslateAnimations,
  BorderAnimations,
  ThreeDX,
  ThreeDY,
  ThreeDZ
}

class ReikoAnimationException implements Exception {
  ReikoAnimationException(
      {@required code, @required message, @required reikoException}) {
    _message = message;
    _code = code;
    _exception = reikoException;
  }
  String _message;
  int _exception;
  int _code;

  @override
  String toString() {
    return '${ReikoExceptions.values[_exception]}Exception: Status code: $_code.\n' +
        _message;
  }

  String get message {
    return _message;
  }

  int get code {
    return _code;
  }
}
