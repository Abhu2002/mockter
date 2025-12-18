import 'package:flutter/material.dart';
import 'package:expt1_login/components/text_input.dart';
import 'package:expt1_login/components/label_text.dart';
import 'package:expt1_login/components/rounded_button.dart';
import 'package:expt1_login/screens/login_screen.dart';
import 'package:expt1_login/brains/registration_brain.dart';
import 'package:expt1_login/components/constants.dart';
import 'package:flutter_awesome_alert_box/flutter_awesome_alert_box.dart';
import 'package:provider/provider.dart';
import '../models/authentication_details.dart';
import 'home_screen.dart';


class RegistrationScreen extends StatefulWidget {
  static String id = '/registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String name, email, password, mobile;

  TextEditingController controller = TextEditingController();

  bool passwordStrong = false,
      mobileCorrect = false,
      emailCorrect = false,
      nameCorrect = false,
      _submitting = false;

  RegistrationBrain rb = RegistrationBrain();

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn =
        Provider.of<AuthenticationDetails>(context).isLoggedIn;

    if (isLoggedIn) {
      return HomeScreen();
    }

    return Stack(
      children: [
        /// ---------------- MAIN UI ----------------
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFF2269D5),
          body: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 30.0, bottom: 30.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    child: const Icon(
                      Icons.app_registration,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    left: 30.0,
                    right: 30.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelText(label: 'Basic Information'),
                      const SizedBox(height: 10),

                      /// -------- NAME --------
                      TextInput(
                        hint: 'Full Name',
                        borderColor:
                        !nameCorrect ? 0xFFFF0000 : 0xFF008000,
                        onChanged: (inputName) {
                          setState(() {
                            nameCorrect = rb.checkName(inputName);
                            if (nameCorrect) name = inputName;
                          });
                        },
                      ),

                      const SizedBox(height: 10),

                      /// -------- EMAIL --------
                      TextInput(
                        hint: 'Email',
                        borderColor:
                        !emailCorrect ? 0xFFFF0000 : 0xFF008000,
                        onChanged: (inputEmail) {
                          setState(() {
                            emailCorrect = rb.checkEmail(inputEmail);
                            if (emailCorrect) email = inputEmail;
                          });
                        },
                      ),

                      const SizedBox(height: 40),
                      LabelText(label: "Private Information"),
                      const SizedBox(height: 10),

                      /// -------- PASSWORD --------
                      TextInput(
                        obscureText: true,
                        hint: 'Password',
                        borderColor:
                        !passwordStrong ? 0xFFFF0000 : 0xFF008000,
                        onChanged: (inputPassword) {
                          setState(() {
                            passwordStrong =
                                rb.checkPasswordStrength(inputPassword);
                            if (passwordStrong) password = inputPassword;
                          });
                        },
                      ),

                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          "Password should be minimum 8 characters long,\n"
                              "with at least:\n"
                              "1 lowercase letter,\n"
                              "1 uppercase letter,\n"
                              "1 digit and\n"
                              "1 special character",
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// -------- MOBILE --------
                      TextInput(
                        hint: 'Mobile',
                        borderColor:
                        !mobileCorrect ? 0xFFFF0000 : 0xFF008000,
                        onChanged: (inputMobile) {
                          setState(() {
                            mobileCorrect = rb.checkMobile(inputMobile);
                            if (mobileCorrect) mobile = inputMobile;
                          });
                        },
                      ),

                      const SizedBox(height: 40),

                      /// -------- SIGN UP BUTTON --------
                      RoundedButton(
                        buttonTitle: "Sign Up",
                        onPressed: () async {
                          setState(() => _submitting = true);

                          if (nameCorrect &&
                              passwordStrong &&
                              emailCorrect &&
                              mobileCorrect) {
                            RegistrationBrain regBrain = RegistrationBrain(
                              name: name,
                              password: password,
                              email: email,
                              mobile: mobile,
                            );

                            Map reg = await regBrain.doRegistration();

                            setState(() => _submitting = false);

                            if (reg['auth_exception'] ==
                                Auth_Exceptions.REGISTRATION_SUCCESS) {
                              SuccessAlertBox(
                                context: context,
                                title: "REGISTRATION SUCCESSFUL",
                                messageText:
                                "Registration successful. Please confirm your email and login.",
                                buttonColor: Colors.blueAccent,
                                titleTextColor: Colors.blueAccent,
                              );

                              Navigator.pushNamed(
                                  context, LoginScreen.id);
                            } else {
                              String warningMessage = "Something went wrong";
                              String warningTitle = "ERROR";

                              if (reg['auth_exception'] ==
                                  Auth_Exceptions.EMAIL_ALREADY_EXISTS) {
                                warningMessage =
                                "Account already exists, please login.";
                                warningTitle = "ACCOUNT EXISTS";
                              } else if (reg['auth_exception'] ==
                                  Auth_Exceptions.NETWORK_ERROR) {
                                warningMessage =
                                "Check your network and try again.";
                                warningTitle = "NETWORK ERROR";
                              }

                              WarningAlertBox(
                                context: context,
                                messageText: warningMessage,
                                title: warningTitle,
                                buttonColor: Colors.blueAccent,
                                icon: Icons.warning,
                                titleTextColor: Colors.blue,
                              );
                            }
                          } else {
                            setState(() => _submitting = false);

                            WarningAlertBox(
                              context: context,
                              messageText:
                              "Please enter all the details properly",
                              title: "VALIDATION ERROR",
                              buttonColor: Colors.blueAccent,
                              icon: Icons.warning,
                              titleTextColor: Colors.blue,
                            );
                          }
                        },
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.id);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Already have an account",
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w400,
                              ),
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
              ),
            ],
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
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ],
      ],
    );
  }
}
