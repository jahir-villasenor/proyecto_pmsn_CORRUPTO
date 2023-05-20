import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/core/app_color.dart';
import '../../firebase/email_auth.dart';
import '../../provider/theme_provider.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  ForgotScreenState createState() {
    return ForgotScreenState();
  }
}

class ForgotScreenState extends State<ForgotScreen> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  EmailAuth emailAuth = EmailAuth();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();

  @override
  Widget build(BuildContext context) {ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData? currentThemeData = themeProvider.getthemeData();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          AppColor.darkOrange,
          AppColor.lightOrange,
          Color.fromARGB(255, 255, 167, 38)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "Forgot your password?",
                    style: TextStyle(color: AppColor.lightGrey, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Complete form to get your new password",
                    style: TextStyle(color: AppColor.lightGrey, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: currentThemeData?.brightness ==
                                            Brightness.dark
                                        ? AppColor.modeDark
                                        : AppColor.modeLight,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 60,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: currentThemeData?.brightness ==
                                            Brightness.dark
                                        ? AppColor.modeDark
                                        : AppColor.modeLight,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(225, 95, 27, .3),
                                          blurRadius: 20,
                                          offset: Offset(0, 10))
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        AppColor.lightGrey))),
                                        child: TextFormField(
                                          controller: conEmail,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                              Icons.email,
                                              color: AppColor.darkOrange,
                                            ),
                                            hintText: 'Insert your email',
                                            labelText: 'Email',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Email can not be empty";
                                            } else if (!EmailValidator.validate(
                                                value, true)) {
                                              return "Invalid Email Address";
                                            } else {
                                              return null;
                                            }
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: conEmail.text)
                                      .then((_) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Send new password',
                                            style: TextStyle(fontSize: 20)),
                                        content: const Text(
                                            'Open the link sent to your email to recover your password'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).catchError((error) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text(
                                            'The email does not exist',
                                            style: TextStyle(fontSize: 20)),
                                        content: const Text(
                                            'Create an account in the sign in section'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  backgroundColor: AppColor.darkOrange,
                                  elevation: 2,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100),
                                  minimumSize: const Size(0, 40),
                                ),
                                child: const Text(
                                  "New Password",
                                  style: TextStyle(
                                      color: AppColor.lightGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
