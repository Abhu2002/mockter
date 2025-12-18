import 'package:expt1_login/components/rounded_button.dart';
import 'package:expt1_login/models/authentication_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expt1_login/components/text_input_with_icon.dart';
import 'package:expt1_login/screens/registration_screen.dart';
import 'package:expt1_login/screens/home_screen.dart';
import 'package:expt1_login/brains/login_brain.dart';
import 'package:expt1_login/components/constants.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:expt1_login/components/text_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/login_screen';
  bool connected;

  LoginScreen({this.connected = false});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email = '', password = '';
  bool _submitting = false;
  bool _showPassword = true;
  Map<String, dynamic> log = {};

  void checkConnectivity() async {
    final List<ConnectivityResult> cr =
    await Connectivity().checkConnectivity();

    setState(() {
      widget.connected = !cr.contains(ConnectivityResult.none);
    });
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.connected) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/network_error.jpg'),
            const SizedBox(height: 40),
            Container(
              color: Colors.blueAccent,
              child: TextButton(
                onPressed: checkConnectivity,
                child: const Text(
                  'TRY AGAIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (Provider.of<AuthenticationDetails>(context).isLoggedIn) {
      return HomeScreen();
    }

    return Stack(
      children: [
        /// ---------------- MAIN UI ----------------
        SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('images/bg_image_exam.jpg'),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 50.0, bottom: 50.0),
                    child: CircleAvatar(
                      radius: 70.0,
                      child: Image.asset('images/exam.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        TextInputWithIcon(
                          icon: Icons.account_circle,
                          hint: 'E-mail Address',
                          onChanged: (inputEmail) {
                            email = inputEmail;
                          },
                        ),
                        const SizedBox(height: 25),
                        TextInputWithIcon(
                          icon: Icons.lock_outlined,
                          hint: 'Password',
                          ObscureText: _showPassword,
                          suffixIcon: Icons.remove_red_eye_outlined,
                          onTapForSuffixIcon: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          onChanged: (inputPassword) {
                            password = inputPassword;
                          },
                        ),
                        const SizedBox(height: 40),

                        /// -------- SIGN IN --------
                        RoundedButton(
                          buttonTitle: "Sign In",
                          onPressed: () async {
                            setState(() => _submitting = true);

                            int error = 1;
                            late String warningMessage;
                            late String warningTitle;

                            if (email.isNotEmpty && password.isNotEmpty) {
                              Login_Brain lb =
                              Login_Brain(email: email, password: password);

                              log = await lb.doLogin();

                              if (log['auth_exception'] ==
                                  Auth_Exceptions.LOGIN_SUCCESSFULL) {
                                error = 0;

                                Provider.of<AuthenticationDetails>(context,
                                    listen: false)
                                    .updateLogInStatus(
                                  true,
                                  log['email'],
                                  log['mobile'],
                                  log['name'],
                                );

                                SuccessAlertBox(
                                  context: context,
                                  title: "LOGIN SUCCESSFULL",
                                  messageText:
                                  "You have successfully logged in",
                                  buttonColor: Colors.blueAccent,
                                  titleTextColor: Colors.blueAccent,
                                );

                                Navigator.pushNamed(
                                  context,
                                  HomeScreen.id,
                                  arguments: log,
                                );
                              } else if (log['auth_exception'] ==
                                  Auth_Exceptions.ACCOUNT_NOT_FOUND) {
                                warningMessage =
                                "Account related with entered email not found";
                                warningTitle = "ACCOUNT NOT FOUND";
                              } else if (log['auth_exception'] ==
                                  Auth_Exceptions.EMAIL_NOT_VERIFIED) {
                                warningMessage =
                                "Please verify your email before login";
                                warningTitle = "EMAIL NOT VERIFIED";
                              } else if (log['auth_exception'] ==
                                  Auth_Exceptions.INVALID_PASSWORD) {
                                warningMessage =
                                "Password does not match the email";
                                warningTitle = "INVALID PASSWORD";
                              }
                            } else {
                              warningMessage =
                              "Please enter email and password";
                              warningTitle = "INVALID DETAILS";
                            }

                            if (error == 1) {
                              WarningAlertBox(
                                context: context,
                                title: warningTitle,
                                messageText: warningMessage,
                                titleTextColor: Colors.blueAccent,
                                buttonColor: Colors.blueAccent,
                              );
                            }

                            setState(() => _submitting = false);
                          },
                        ),

                        const SizedBox(height: 10),

                        /// -------- SIGN UP --------
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        /// -------- FORGOT PASSWORD --------
                        TextButton(
                          onPressed: _showForgotPasswordSheet,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Forgot Password",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                              SizedBox(width: 8),
                              CircleAvatar(
                                backgroundColor: Colors.blueAccent,
                                radius: 9,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 8,
                                  child: Text(
                                    '?',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /// ---------------- LOADING OVERLAY ----------------
        if (_submitting) ...[
          const Opacity(
            opacity: 0.6,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
          const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ],
      ],
    );
  }

  void _showForgotPasswordSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "FORGOT PASSWORD",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextInput(
                hint: "Enter your Email",
                onChanged: (inputEmail) {
                  email = inputEmail;
                },
              ),
              const SizedBox(height: 20),
              RoundedButton(
                buttonTitle: 'RESET PASSWORD',
                onPressed: () async {
                  setState(() => _submitting = true);

                  Login_Brain lb = Login_Brain();
                  var resetException = await lb.resetPassword(email);

                  setState(() => _submitting = false);

                  WarningAlertBox(
                    context: context,
                    title: resetException ==
                        Auth_Exceptions.RESET_LINK_SENT
                        ? "RESET LINK SENT"
                        : "ERROR",
                    messageText:
                    "Please check your email for reset instructions",
                    titleTextColor: Colors.blueAccent,
                    buttonColor: Colors.blueAccent,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
