import 'package:flutter/material.dart';
import 'package:expt1_login/components/text_input.dart';
import 'package:expt1_login/components/constants.dart' show Question_Type;

class QuestionCard extends StatefulWidget with ChangeNotifier {
  double marks = 0;
  String optionA,
      optionB,
      optionC,
      optionD,
      question,
      questionImage,
      correctAnswer,
      solutionImage;
  List<String> correctAnswers;
  bool imagePresent;
  bool isTest;
  Question_Type qt;
  double que_marks;
  Function callback;
  int year;
  bool showAnswers;

  QuestionCard(
      {this.question = "Question Statement",
      this.optionA = "OPTION A",
      this.optionB = "OPTION B",
      this.optionC = "OPTION C",
      this.optionD = "OPTION D",
      this.correctAnswer = "OPTION A",
      this.correctAnswers = const ['OPTION A', 'OPTION D'],
      this.imagePresent = false,
      this.questionImage = 'exam.png',
      this.qt = Question_Type.MULTIPLE_CORRECT_ANSWER,
      this.que_marks = 2,
      this.solutionImage = '',
      this.isTest = false,
      required this.callback,
      this.year = 2022,
      this.showAnswers = false});

  double getTotalMarks() {
    return marks;
  }

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool showSolution = false;
  bool answerCorrectA = false;
  bool answerCorrectB = false;
  bool answerCorrectC = false;
  bool answerCorrectD = false;
  String _selectedValue = '';
  List<String> _selectedValues = [];
  bool selectedA = false,
      selectedB = false,
      selectedC = false,
      selectedD = false;
  bool checkingAnswerA = false,
      checkingAnswerB = false,
      checkingAnswerC = false,
      checkingAnswerD = false;
  bool showStatus = false, answerCorrect = false;
  late bool showAnswer;
  @override
  void initState() {
    showAnswer = widget.showAnswers;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0,
        ),
        color: Colors.white,
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.year.toString(),
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${widget.que_marks.toInt().toString()} Marks',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            widget.question,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 30.0),
          Container(
            height: widget.imagePresent ? 150.0 : null,
            width: double.infinity,
            child: widget.imagePresent
                ? Image.asset('${widget.questionImage}')
                : null,
          ),
          SizedBox(height: 30.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: widget.qt == Question_Type.FILL_IN_THE_BLANKS
                ? [
                    TextInput(
                        hint: 'Your Answer',
                        onChanged: (value) {
                          _selectedValue = value;
                        }),
                    SizedBox(height: 20.0),
                    showAnswer
                        ? Text(
                            widget.correctAnswer,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : showStatus
                            ? Text(
                                answerCorrect
                                    ? 'You are Correct'
                                    : 'You are Wrong',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      answerCorrect ? Colors.green : Colors.red,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : SizedBox(),
                  ]
                : [
                    Container(
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                      color: !checkingAnswerA
                          ? (!selectedA
                              ? const Color(0xFFf0edfe)
                              : const Color(0xFFFFE28D))
                          : (!answerCorrectA ? Colors.red : Colors.green),
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (widget.qt ==
                              Question_Type.MULTIPLE_CORRECT_ANSWER) {
                            setState(() {
                              _selectedValues.remove(widget.optionA);
                              selectedA = false;
                              answerCorrectA = false;
                              answerCorrectB = false;
                              answerCorrectC = false;
                              answerCorrectD = false;
                              checkingAnswerA = false;
                              checkingAnswerB = false;
                              checkingAnswerC = false;
                              checkingAnswerD = false;
                            });
                          }
                        },
                        onTap: () {
                          setState(() {
                            if (widget.qt ==
                                Question_Type.SINGLE_CORRECT_ANSWER) {
                              selectedB = false;
                              selectedC = false;
                              selectedD = false;
                              _selectedValue = widget.optionA;
                            } else if (widget.qt ==
                                Question_Type.MULTIPLE_CORRECT_ANSWER) {
                              _selectedValues.add(widget.optionA);
                            }
                            answerCorrectA = false;
                            answerCorrectB = false;
                            answerCorrectC = false;
                            answerCorrectD = false;
                            checkingAnswerA = false;
                            checkingAnswerB = false;
                            checkingAnswerC = false;
                            checkingAnswerD = false;
                            selectedA = true;
                          });
                        },
                        child: Text(
                          'A. ${widget.optionA} ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 10.0,
                      ),
                      color: !checkingAnswerB
                          ? (!selectedB
                              ? const Color(0xFFf0edfe)
                              : const Color(0xFFFFE28D))
                          : (!answerCorrectB ? Colors.red : Colors.green),
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (widget.qt ==
                              Question_Type.MULTIPLE_CORRECT_ANSWER) {
                            setState(() {
                              _selectedValues.remove(widget.optionB);
                              selectedB = false;
                              answerCorrectA = false;
                              answerCorrectB = false;
                              answerCorrectC = false;
                              answerCorrectD = false;
                              checkingAnswerA = false;
                              checkingAnswerB = false;
                              checkingAnswerC = false;
                              checkingAnswerD = false;
                            });
                          }
                        },
                        onTap: () {
                          setState(() {
                            if (widget.qt ==
                                Question_Type.SINGLE_CORRECT_ANSWER) {
                              selectedA = false;
                              selectedC = false;
                              selectedD = false;
                            } else if (widget.qt ==
                                Question_Type.MULTIPLE_CORRECT_ANSWER) {
                              _selectedValues.add(widget.optionB);
                            }
                            answerCorrectA = false;
                            answerCorrectB = false;
                            answerCorrectC = false;
                            answerCorrectD = false;
                            checkingAnswerA = false;
                            checkingAnswerB = false;
                            checkingAnswerC = false;
                            checkingAnswerD = false;
                            selectedB = true;
                            _selectedValue = widget.optionB;
                          });
                        },
                        child: Text(
                          'B. ${widget.optionB} ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 10.0,
                      ),
                      color: !checkingAnswerC
                          ? (!selectedC
                              ? const Color(0xFFf0edfe)
                              : const Color(0xFFFFE28D))
                          : (!answerCorrectC ? Colors.red : Colors.green),
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (widget.qt ==
                              Question_Type.MULTIPLE_CORRECT_ANSWER) {
                            setState(() {
                              _selectedValues.remove(widget.optionC);
                              answerCorrectA = answerCorrectB = answerCorrectC =
                                  answerCorrectD = checkingAnswerA =
                                      checkingAnswerB = checkingAnswerC =
                                          checkingAnswerD = selectedC = false;
                            });
                          }
                        },
                        onTap: () {
                          setState(() {
                            if (widget.qt ==
                                Question_Type.SINGLE_CORRECT_ANSWER) {
                              selectedB = false;
                              selectedA = false;
                              selectedD = false;
                            } else if (widget.qt ==
                                Question_Type.MULTIPLE_CORRECT_ANSWER) {
                              _selectedValues.add(widget.optionC);
                            }
                            answerCorrectA = answerCorrectB = answerCorrectC =
                                answerCorrectD = checkingAnswerA =
                                    checkingAnswerB = checkingAnswerC =
                                        checkingAnswerD = false;

                            selectedC = true;
                            _selectedValue = widget.optionC;
                          });
                        },
                        child: Text(
                          'C. ${widget.optionC} ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 10.0,
                      ),
                      color: !checkingAnswerD
                          ? (!selectedD
                              ? const Color(0xFFf0edfe)
                              : const Color(0xFFFFE28D))
                          : (!answerCorrectD ? Colors.red : Colors.green),
                      child: GestureDetector(
                        onDoubleTap: () {
                          if (widget.qt ==
                              Question_Type.MULTIPLE_CORRECT_ANSWER) {
                            setState(() {
                              _selectedValues.remove(widget.optionD);
                              selectedD = answerCorrectA = answerCorrectB =
                                  answerCorrectC = answerCorrectD =
                                      checkingAnswerA = checkingAnswerB =
                                          checkingAnswerC =
                                              checkingAnswerD = false;
                            });
                          }
                        },
                        onTap: () {
                          setState(() {
                            if (widget.qt ==
                                Question_Type.SINGLE_CORRECT_ANSWER) {
                              selectedB = selectedC = selectedA = false;
                            } else if (widget.qt ==
                                Question_Type.MULTIPLE_CORRECT_ANSWER) {
                              _selectedValues.add(widget.optionD);
                            }
                            answerCorrectA = answerCorrectB = answerCorrectC =
                                answerCorrectD = checkingAnswerA =
                                    checkingAnswerB = checkingAnswerC =
                                        checkingAnswerD = false;
                            selectedD = true;
                            _selectedValue = widget.optionD;
                          });
                        },
                        child: Text(
                          'D. ${widget.optionD} ',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
          SizedBox(height: 50.0),
          Container(
            child: showSolution
                ? (widget.solutionImage.endsWith('.JPG') ||
                        widget.solutionImage.endsWith('.png'))
                    ? Image.asset('${widget.solutionImage}')
                    : Text(
                        widget.solutionImage + '.',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                : null,
          ),
          SizedBox(height: 40.0),
          !widget.showAnswers
              ? Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF791eff),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        checkingAnswerA = selectedA;
                        checkingAnswerB = selectedB;
                        checkingAnswerC = selectedC;
                        checkingAnswerD = selectedD;
                        if (widget.qt == Question_Type.SINGLE_CORRECT_ANSWER) {
                          if (_selectedValue == widget.correctAnswer) {
                            widget.marks = widget.que_marks;
                            if (_selectedValue == widget.optionA) {
                              answerCorrectA = true;
                              answerCorrectB =
                                  answerCorrectC = answerCorrectD = false;
                            } else if (_selectedValue == widget.optionB) {
                              answerCorrectB = true;
                              answerCorrectA =
                                  answerCorrectC = answerCorrectD = false;
                            } else if (_selectedValue == widget.optionC) {
                              answerCorrectC = true;
                              answerCorrectB =
                                  answerCorrectA = answerCorrectD = false;
                            } else if (_selectedValue == widget.optionD) {
                              answerCorrectD = true;
                              answerCorrectB =
                                  answerCorrectC = answerCorrectA = false;
                            }
                            // checkingAnswer = false;
                            // answerCorrect = false;
                          } else {
                            if (widget.que_marks == 1) {
                              widget.marks = -1 / 3;
                            } else if (widget.que_marks == 2) {
                              widget.marks = -2 / 3;
                            }
                            answerCorrectA = answerCorrectB =
                                answerCorrectC = answerCorrectD = false;
                            if (_selectedValue == widget.optionA) {
                              checkingAnswerA = true;
                            } else if (_selectedValue == widget.optionB) {
                              checkingAnswerB = true;
                            } else if (_selectedValue == widget.optionC) {
                              checkingAnswerC = true;
                            } else if (_selectedValue == widget.optionD) {
                              checkingAnswerD = true;
                            }
                          }
                        } else if (widget.qt ==
                            Question_Type.MULTIPLE_CORRECT_ANSWER) {
                          Set commonSelected = _selectedValues
                              .toSet()
                              .intersection(widget.correctAnswers.toSet());
                          if (commonSelected.length ==
                              widget.correctAnswers.length) {
                            widget.marks = widget.que_marks;
                          } else {
                            widget.marks = 0;
                          }
                          for (String value in commonSelected) {
                            if (value == widget.optionA) {
                              answerCorrectA = true;
                            } else if (value == widget.optionB) {
                              answerCorrectB = true;
                            } else if (value == widget.optionC) {
                              answerCorrectC = true;
                            } else if (value == widget.optionD) {
                              answerCorrectD = true;
                            }
                          }
                          Set selectedButNotCorrect = _selectedValues
                              .toSet()
                              .difference(widget.correctAnswers.toSet());
                          for (String value in selectedButNotCorrect) {
                            if (value == widget.optionA) {
                              answerCorrectA = false;
                            } else if (value == widget.optionB) {
                              answerCorrectB = false;
                            } else if (value == widget.optionC) {
                              answerCorrectC = false;
                            } else if (value == widget.optionD) {
                              answerCorrectD = false;
                            }
                          }
                        } else {
                          showStatus = true;
                          if (widget.correctAnswer == _selectedValue) {
                            setState(() {
                              answerCorrect = true;
                            });
                            widget.marks = widget.que_marks;
                          } else {
                            setState(() {
                              answerCorrect = false;
                            });
                            widget.marks = 0;
                          }
                        }
                        widget.callback(widget.marks);
                      });
                    },
                  ),
                )
              : Container(),
          SizedBox(height: 60.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.isTest
                ? []
                : [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xBF791eff),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        child: Text(
                          'Show Answer',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (widget.qt ==
                                Question_Type.SINGLE_CORRECT_ANSWER) {
                              answerCorrectA = checkingAnswerA =
                                  widget.optionA == widget.correctAnswer;
                              answerCorrectB = checkingAnswerB =
                                  widget.optionB == widget.correctAnswer;
                              answerCorrectC = checkingAnswerC =
                                  widget.optionC == widget.correctAnswer;
                              answerCorrectD = checkingAnswerD =
                                  widget.optionD == widget.correctAnswer;
                            } else if (widget.qt ==
                                Question_Type.MULTIPLE_CORRECT_ANSWER) {
                              for (String option in widget.correctAnswers) {
                                if (option == widget.optionA) {
                                  checkingAnswerA = true;
                                  answerCorrectA = true;
                                } else if (option == widget.optionB) {
                                  checkingAnswerB = true;
                                  answerCorrectB = true;
                                } else if (option == widget.optionC) {
                                  checkingAnswerC = true;
                                  answerCorrectC = true;
                                } else if (option == widget.optionD) {
                                  checkingAnswerD = true;
                                  answerCorrectD = true;
                                }
                              }
                            } else {}
                          });
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xBF791eff),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        child: Text(
                          '${showSolution ? 'Hide' : 'Show'} Solution',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            showSolution = !showSolution;
                          });
                        },
                      ),
                    ),
                  ],
          )
        ]),
      ),
    );
  }
}
