import 'package:expt1_login/screens/login_screen.dart';
import 'package:expt1_login/screens/network_error.dart';
import 'package:expt1_login/screens/practice_options_screen.dart';
import 'package:expt1_login/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:expt1_login/brains/login_brain.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:provider/provider.dart';
import 'package:expt1_login/models/authentication_details.dart';
import 'package:expt1_login/components/option_tab.dart';
import 'package:expt1_login/screens/profile_screen.dart';

// Create a key

class HomeScreen extends StatefulWidget {
  static String id = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    AuthenticationDetails ae = Provider.of<AuthenticationDetails>(context);
    return !ae.isLoggedIn
        ? LoginScreen()
        : Scaffold(
            drawerEnableOpenDragGesture: false,
            drawer: NetworkError(),
            body: SafeArea(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              Provider.of<AuthenticationDetails>(context).name,
                              style: TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Builder(
                          builder: (context) => GestureDetector(
                            onTap: () {
                              Scaffold.of(context).openDrawer();
                            },
                            child: Icon(
                              Icons.account_circle,
                              size: 60.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Divider(
                      thickness: 2.0,
                      color: Colors.black,
                    ),
                    SizedBox(height: 20.0),
                    OptionTab(
                      nextPage: TestScreen.id,
                      text1: 'Want to test your preparations for GATE exam?',
                      text2: 'Take a Test',
                      fileName: 'tests/test1.csv',
                      isTest: true,
                    ),
                    SizedBox(height: 20.0),
                    OptionTab(
                      nextPage: PracticeOptionsScreen.id,
                      text1: 'Want to practice more before taking a test?',
                      text2: 'Practice',
                    ),
                    SizedBox(height: 20.0),
                    OptionTab(
                      nextPage: 'https://gate.iitkgp.ac.in/',
                      isURL: true,
                      text1:
                          'Want to know more about GATE exam and get live updates',
                      text2: 'Know More',
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

// () async {
// Login_Brain lb = Login_Brain();
// await lb.doLogOutOfGoogle();
// Provider.of<AuthenticationDetails>(context,
// listen: false)
// .updateLogInStatus(false, '', '', '');
// Future.delayed(
// Duration.zero,
// () => SuccessAlertBox(
// context: context,
// title: "LOGOUT SUCCESSFULL",
// messageText:
// "You have successfully logged out",
// buttonColor: Colors.blueAccent,
// titleTextColor: Colors.blueAccent,
// ));
// Navigator.pushNamed(context, LoginScreen.id);
// },
