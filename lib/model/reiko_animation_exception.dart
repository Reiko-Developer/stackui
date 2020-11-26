import 'package:flutter/material.dart';

enum ReikoExceptions {
  DecorationException,
  MovementException,
}

class ReikoAnimationException implements Exception {
  ReikoAnimationException({
    @required message,
    @required ReikoExceptions reikoException,
  }) {
    _message = message;
    _exception = reikoException.index;
  }
  String _message;
  int _exception;

  @override
  String toString() {
    return '${ReikoExceptions.values[_exception]}Exception: Status code: $_exception.\n' +
        _message;
  }

  String get message {
    return _message;
  }
}
