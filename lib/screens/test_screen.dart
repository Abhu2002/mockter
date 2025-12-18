import 'dart:async';
import 'package:expt1_login/models/question.dart';
import 'package:expt1_login/screens/home_screen.dart';
import 'package:expt1_login/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:expt1_login/components/question_card.dart';
import 'package:carousel_slider/carousel_slider.dart'
    hide CarouselController;
import 'package:provider/provider.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:expt1_login/brains/test_summary.dart';
import 'package:expt1_login/components/constants.dart' show Question_Type;

const kTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
);

String fileName = 'tests/test1.csv';

class TestScreen extends StatefulWidget {
  static String id = '/test_screen';
  bool isTest;
  List<Question> questions;
  bool showAnswers;

  TestScreen(
      {this.isTest = true,
      this.questions = const [],
      this.showAnswers = false});
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  CustomTimerController _controller = CustomTimerController();
  int que_no = 1;
  double totalMarks = 0;
  int correct = 0, inCorrect = 0, missed = 65;
  List<bool> _questionStatus = [];
  Timer _timer = Timer(Duration(seconds: 0), () {});
  _TestScreenState() {
    _timer = Timer(Duration(hours: 3), () {
      Future.delayed(
        Duration.zero,
        () => SuccessAlertBox(
          context: context,
          title: "TEST ENDED",
          messageText:
              "Time Finished........ Your answers are submitted automatically",
          buttonColor: Colors.blueAccent,
          titleTextColor: Colors.blueAccent,
        ),
      );
      Navigator.pushNamed(context, ResultScreen.id);
    });
  }

  Future<bool> _onPressedBack() async {
    widget.isTest
        ? ConfirmAlertBox(
            context: context,
            title: "END TEST",
            titleTextColor: Color(0xFF791eff),
            infoMessage: " Are you sure you want to end the test ?",
            buttonTextForYes: "YES",
            buttonTextForNo: "NO",
            onPressedYes: () {
              _controller.finish();
              Provider.of<TestSummary>(context, listen: false)
                  .updateSummary(totalMarks, correct, inCorrect, missed);
              Navigator.pushNamedAndRemoveUntil(
                context,
                ResultScreen.id,
                ModalRoute.withName(HomeScreen.id),
                arguments: {'fileName': fileName},
              );
              return true;
            },
            onPressedNo: () {
              return false;
            },
          )
        : null;
    return true;
  }

  @override
  void initState() {
    super.initState();
    _controller.start();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments == null
        ? {'isTest': widget.isTest, 'questions': widget.questions}
        : ModalRoute.of(context)!.settings.arguments as Map;
    widget.isTest = args['isTest'];
    widget.questions = args['questions'];
    for (int i = 0; i < widget.questions.length; i++) {
      _questionStatus.add(false);
    }
    return WillPopScope(
      onWillPop: _onPressedBack,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            color: Color(0xFF791eff),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.isTest
                          ? GestureDetector(
                              child: Container(
                                child: Text(
                                  'End Test',
                                  style: kTextStyle,
                                ),
                              ),
                              onTap: () {
                                ConfirmAlertBox(
                                  context: context,
                                  title: "END TEST",
                                  titleTextColor: Color(0xFF791eff),
                                  infoMessage:
                                      " Are you sure you want to end the test ?",
                                  buttonTextForYes: "YES",
                                  buttonTextForNo: "NO",
                                  onPressedYes: () {
                                    _controller.finish();
                                    Provider.of<TestSummary>(context,
                                            listen: false)
                                        .updateSummary(totalMarks, correct,
                                            inCorrect, missed);
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        ResultScreen.id,
                                        ModalRoute.withName(HomeScreen.id),
                                        arguments: {'fileName': fileName});
                                  },
                                );
                              },
                            )
                          : Container(),
                      Text(
                        'Q.$que_no',
                        style: kTextStyle,
                      ),
                      widget.isTest
                          ? CustomTimer(
                              controller: _controller,
                              begin: Duration(hours: 3),
                              end: Duration(),
                              builder: (time) {
                                return Text(
                                  "${time.hours}:${time.minutes}:${time.seconds}",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: time.hours.endsWith('00') &&
                                            !time.minutes.endsWith('15')
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                );
                              },
                            )
                          : Container(),
                      // Text(
                      //   'Time',
                      //   style: kTextStyle,
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: widget.questions.length,
                    itemBuilder: (context, itemIndex, pageViewIndex) =>
                        QuestionCard(
                      question: widget.questions[itemIndex].question,
                      optionA: widget.questions[itemIndex].optionA,
                      optionB: widget.questions[itemIndex].optionB,
                      optionC: widget.questions[itemIndex].optionC,
                      optionD: widget.questions[itemIndex].optionD,
                      correctAnswer: widget.questions[itemIndex].correctAnswer,
                      correctAnswers:
                          widget.questions[itemIndex].correctAnswers,
                      imagePresent: widget.questions[itemIndex].imagePresent,
                      questionImage: widget.questions[itemIndex].questionImage,
                      qt: widget.questions[itemIndex].qt,
                      que_marks:
                          widget.questions[itemIndex].que_marks.toDouble(),
                      solutionImage: widget.questions[itemIndex].solutionImage,
                      year: widget.questions[itemIndex].year,
                      isTest: widget.isTest,
                      showAnswers: widget.showAnswers,
                      callback: (marks) {
                        setState(() {
                          if (!_questionStatus[que_no]) {
                            totalMarks += marks;
                            if (marks <= 0) {
                              inCorrect++;
                              _questionStatus[que_no] = true;
                            } else {
                              correct++;
                              _questionStatus[que_no] = true;
                            }
                            missed = 65 - (correct + inCorrect);
                            Provider.of<TestSummary>(context, listen: false)
                                .updateSummary(
                                    totalMarks, correct, inCorrect, missed);
                            print(totalMarks);
                          }
                        });
                      },
                    ),
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          que_no = index + 1;
                        });
                      },
                      height: double.infinity,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 0.8,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
