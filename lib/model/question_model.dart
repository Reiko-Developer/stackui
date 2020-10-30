class QuestionModel {
  final String _header;
  final List<String> _allAnswers;

  QuestionModel(this._header, this._allAnswers);

  String get header {
    return _header;
  }

  List<String> get answers {
    return _allAnswers;
  }
}
