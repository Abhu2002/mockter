import 'package:csv/csv.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:expt1_login/components/constants.dart';
import 'package:expt1_login/models/question.dart';
import 'package:flutter/services.dart';

class QuestionsCsvBrain {
  List<List<dynamic>> _data = [];
  List<Question> _questions = [];

  // This function is triggered when the floating button is pressed
  Future<List<Question>> loadCSV(String fileName) async {
    final _rawData = await rootBundle.loadString("questions/${fileName}");
    _data = const CsvToListConverter().convert(_rawData);
    print(_data);

    for (int i = 1; i < _data.length; i++) {
      Question question = Question();
      question.question = _data[i][0];
      question.optionA = _data[i][1].toString();
      question.optionB = _data[i][2].toString();
      question.optionC = _data[i][3].toString();
      question.optionD = _data[i][4].toString();
      question.correctAnswer = _data[i][5].toString();
      question.correctAnswers = _data[i][6] == 'FALSE' ? [] : _data[i][6];
      question.imagePresent = _data[i][7] == 'FALSE' ? false : true;
      question.questionImage = _data[i][8] == 'FALSE' ? '' : _data[i][8];
      question.qt = EnumToString.fromString(Question_Type.values, _data[i][9])!;
      question.que_marks = _data[i][10];
      question.solutionImage = _data[i][11] == 'FALSE' ? '#' : _data[i][11];
      question.year = _data[i][12];
      _questions.add(question);
    }
    return _questions;
  }
}
