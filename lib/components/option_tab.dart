import 'package:expt1_login/screens/practice_options_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'dart:io';

import '../brains/questions_csv.dart';

class OptionTab extends StatelessWidget {
  String nextPage, text1, text2, fileName;
  bool isURL, isTest;

  OptionTab(
      {this.nextPage = '',
      this.text1 = '',
      this.text2 = '',
      this.isURL = false,
      this.fileName = '',
      this.isTest = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset('images/bluebg.png'),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                text1,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 60.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text2,
                    style: const TextStyle(
                      fontSize: 40.0,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  GestureDetector(
                    onTap: isURL
                        ? () async {
                            if (!await launch(nextPage)) {
                              DangerAlertBox(
                                title: 'Network Error',
                                messageText:
                                    'Cannot redirect to official website at this moment',
                              );
                            }
                          }
                        : () async {
                            QuestionsCsvBrain qcsvb = QuestionsCsvBrain();
                            isTest
                                ? Navigator.pushNamed(
                                    context, nextPage, arguments: {
                                    'isTest': isTest,
                                    'questions': await qcsvb.loadCSV(fileName)
                                  })
                                : Navigator.pushNamed(
                                    context, PracticeOptionsScreen.id);
                          },
                    child: const Icon(
                      Icons.arrow_right_alt,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
