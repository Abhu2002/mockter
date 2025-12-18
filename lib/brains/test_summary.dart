import 'package:flutter/material.dart';

class TestSummary extends ChangeNotifier {
  double totalMarks;
  int correct, inCorrect, missed;

  TestSummary(
      {required this.totalMarks,
      required this.correct,
      required this.inCorrect,
      required this.missed});

  void updateSummary(
      double newMarks, int newCorrect, int newIncorrect, int newMissed) {
    totalMarks = newMarks;
    correct = newCorrect;
    inCorrect = newIncorrect;
    missed = newMissed;
    notifyListeners();
  }
}
