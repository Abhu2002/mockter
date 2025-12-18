import 'package:expt1_login/models/authentication_details.dart';
import 'package:expt1_login/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';
import 'package:expt1_login/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:expt1_login/screens/network_error.dart';
import 'package:expt1_login/screens/test_screen.dart';
import 'package:expt1_login/screens/result_screen.dart';
import 'package:provider/provider.dart';
import 'package:expt1_login/brains/test_summary.dart';
import 'package:expt1_login/screens/practice_options_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            TestSummary ts =
                TestSummary(totalMarks: 0, correct: 0, inCorrect: 0, missed: 0);
            return ts;
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            AuthenticationDetails ad = AuthenticationDetails(isLoggedIn: false);
            return ad;
          },
        ),
      ],
      builder: (context, ts) => MaterialApp(
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          NetworkError.id: (context) => NetworkError(),
          TestScreen.id: (context) => TestScreen(),
          ResultScreen.id: (context) => ResultScreen(),
          PracticeOptionsScreen.id: (context) => PracticeOptionsScreen(),
        },
        home: SafeArea(
          child: Provider.of<AuthenticationDetails>(context).isLoggedIn
              ? HomeScreen()
              : LoginScreen(),
        ),
      ),
    );
  }
}
