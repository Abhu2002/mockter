import 'package:expt1_login/components/constants.dart';
import 'package:enum_to_string/enum_to_string.dart';

class Question {
  late String _optionA,
      _optionB,
      _optionC,
      _optionD,
      _question,
      _questionImage,
      _correctAnswer,
      _solutionImage;
  late List<String> _correctAnswers;
  late bool _imagePresent;
  late Question_Type _qt;
  late int _que_marks;
  late int _year;

  void set optionA(String optionA) {
    _optionA = optionA;
  }

  void set optionB(String optionB) {
    _optionB = optionB;
  }

  void set optionC(String optionC) {
    _optionC = optionC;
  }

  void set optionD(String optionD) {
    _optionD = optionD;
  }

  void set question(String question) {
    _question = question;
  }

  void set questionImage(String questionImage) {
    _questionImage = questionImage;
  }

  void set correctAnswer(String correctAnswer) {
    _correctAnswer = correctAnswer;
  }

  void set solutionImage(String solutionImage) {
    _solutionImage = solutionImage;
  }

  void set correctAnswers(List<String> correctAnswers) {
    _correctAnswers = correctAnswers;
  }

  void set imagePresent(bool imagePresent) {
    _imagePresent = imagePresent;
  }

  void set que_marks(int que_marks) {
    _que_marks = que_marks;
  }

  void set year(int year) {
    _year = year;
  }

  void set qt(Question_Type qt) {
    _qt = qt;
  }

  String get optionA {
    return _optionA;
  }

  String get optionB {
    return _optionB;
  }

  String get optionC {
    return _optionC;
  }

  String get optionD {
    return _optionD;
  }

  String get question {
    return _question;
  }

  String get questionImage {
    return _questionImage;
  }

  String get correctAnswer {
    return _correctAnswer;
  }

  String get solutionImage {
    return _solutionImage;
  }

  List<String> get correctAnswers {
    return _correctAnswers;
  }

  bool get imagePresent {
    return _imagePresent;
  }

  Question_Type get qt {
    return _qt;
  }

  int get que_marks {
    return _que_marks;
  }

  int get year {
    return _year;
  }
}
