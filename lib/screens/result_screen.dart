import 'package:expt1_login/brains/questions_csv.dart';
import 'package:expt1_login/models/question.dart';
import 'package:expt1_login/screens/test_screen.dart';
import 'package:provider/provider.dart';
import 'package:expt1_login/brains/test_summary.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../components/photo_manager.dart';
import '../models/authentication_details.dart';
import 'login_screen.dart';

GlobalKey previewContainer = GlobalKey();

class ResultScreen extends StatefulWidget {
  static String id = '/ResultScreen';
  String fileName;

  ResultScreen({super.key, this.fileName = ''});
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late TestSummary ts;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments == null
        ? {'fileName': widget.fileName}
        : ModalRoute.of(context)!.settings.arguments as Map;
    widget.fileName = args['fileName'];
    ts = Provider.of<TestSummary>(context);
    return !Provider.of<AuthenticationDetails>(context).isLoggedIn
        ? LoginScreen()
        : SafeArea(
            child: Scaffold(
              body: RepaintBoundary(
                key: previewContainer,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF791eff),
                        Colors.white,
                      ],
                      stops: [
                        0.0,
                        0.3,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    child: ListView(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFF791eff),
                          radius: 150.0,
                          child: Image.asset('images/trophy.png'),
                        ),
                        const SizedBox(height: 20.0),
                        const Text(
                          'Your test\'s results are here:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      '${ts.correct} / 65',
                                      style: TextStyle(fontSize: 22.0),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Correct',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30.0),
                            Container(
                              height: 50.0,
                              width: 2.0,
                              color: Colors.grey[350],
                            ),
                            SizedBox(width: 30.0),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 11.0,
                                      backgroundColor: Colors.blue,
                                      child: CircleAvatar(
                                        radius: 10.0,
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      '${ts.missed} / 65',
                                      style: TextStyle(fontSize: 22.0),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Skipped',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30.0),
                            Container(
                              height: 50.0,
                              width: 2.0,
                              color: Colors.grey[350],
                            ),
                            SizedBox(width: 30.0),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.red[100],
                                      radius: 11.0,
                                      child: Icon(
                                        Icons.close,
                                        size: 18.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      '${ts.inCorrect} / 65',
                                      style: TextStyle(fontSize: 22.0),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Wrong',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 35.0),
                        Container(
                          width: double.infinity,
                          height: 2.0,
                          color: Colors.grey[350],
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Marks',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  '${ts.totalMarks.toStringAsFixed(2)} / 100',
                                  style: TextStyle(fontSize: 22.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 35.0),
                        Container(
                          width: double.infinity,
                          height: 2.0,
                          color: Colors.grey[350],
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Share',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.share,
                                size: 30.0,
                              ),
                              onTap: () {
                                print('Tapped');
/*                                ShareFilesAndScreenshotWidgets().shareScreenshot(
                                    previewContainer,
                                    800,
                                    "Title",
                                    "result.png",
                                    "image/png",
                                    text:
                                        "Hey,check out my result of the mock test I took on Mockter !!!!");*/
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                            'Share with your friends to let them know your score'),
                        SizedBox(height: 35.0),
                        Container(
                          width: double.infinity,
                          height: 2.0,
                          color: Colors.grey[350],
                        ),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Save',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              child: Icon(
                                Icons.save,
                                size: 30.0,
                              ),
                              onTap: () async {
                                if (await Permission.storage
                                    .request()
                                    .isGranted) {
                                  // Either the permission was already granted before or the user just granted it.
                                  RenderRepaintBoundary? boundary =
                                      previewContainer
                                              .currentContext!
                                              .findRenderObject()
                                          as RenderRepaintBoundary?;
                                  if (boundary!.debugNeedsPaint) {}
                                  ui.Image image = await boundary.toImage();
                                  ByteData? byteData = await image.toByteData(
                                      format: ui.ImageByteFormat.png);
                                  await saveImageWithPhotoManager(context, byteData!);

                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(
                            'Save your achievements on your device to obviously show off later'),
                        SizedBox(height: 35.0),
                        Container(
                          width: double.infinity,
                          height: 2.0,
                          color: Colors.grey[350],
                        ),
                        SizedBox(height: 25.0),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFF791eff),
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              QuestionsCsvBrain qcsvb = QuestionsCsvBrain();
                              List<Question> questions =
                                  await qcsvb.loadCSV(widget.fileName);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TestScreen(
                                      showAnswers: true,
                                      isTest: false,
                                      questions: questions),
                                ),
                              );
                            },
                            child: Text(
                              'CHECK SOLUTIONS',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
