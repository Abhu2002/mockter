import 'package:expt1_login/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:expt1_login/brains/questions_csv.dart';

class OptionTabTopic extends StatelessWidget {
  String title;
  String subjectName;

  OptionTabTopic({this.title = '', this.subjectName = ''});
  final Map _subjectImages = {
    'Programming And Data Structures': 'ds.png',
    'Digital Logic': 'dl.png',
    'Computer Organization And Architecture': 'coa.png',
    'Algorithms': 'algo.png',
    'Theory Of Computation': 'toc.png',
    'Compiler Design': 'cd.png',
    'Operating System': 'os.png',
    'Database Management System': 'dbms.png',
    'Computer Networks': 'cn.png',
  };
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: title == 'Linked List'
          ? () async {
              QuestionsCsvBrain qcsvb = QuestionsCsvBrain();
              Navigator.pushNamed(context, TestScreen.id, arguments: {
                'isTest': false,
                'questions': await qcsvb
                    .loadCSV('data_structures/linkedList/linkedList1.csv')
              });
            }
          : () {},
      child: Stack(
        children: <Widget>[
          Image.asset(
            'images/${_subjectImages[subjectName]}',
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: title.length <= 17 ? 25.0 : 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
