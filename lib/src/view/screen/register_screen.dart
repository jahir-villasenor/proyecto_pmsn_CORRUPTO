import 'package:auth_buttons/auth_buttons.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/core/app_color.dart';

import '../../firebase/email_auth.dart';
import '../../firebase/facebook_auth.dart';
import '../../firebase/google_auth.dart';
import '../../provider/theme_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = '';
  EmailAuth emailAuth = EmailAuth();
  TextEditingController conEmail = TextEditingController();
  TextEditingController conPass = TextEditingController();
  GoogleAuth googleAuth = GoogleAuth();
  FaceAuth faceAuth = FaceAuth();

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
                    "Register",
                    style: TextStyle(color: AppColor.lightGrey, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome New User",
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
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.person,
                                                color: AppColor.darkOrange),
                                            hintText: 'Insert your Name',
                                            labelText: 'Name',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                        )),
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
                                            icon: Icon(Icons.email,
                                                color: AppColor.darkOrange),
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
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color:
                                                        AppColor.lightGrey))),
                                        child: TextFormField(
                                          controller: conPass,
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.lock,
                                                color: AppColor.darkOrange),
                                            hintText: 'Insert your Password',
                                            labelText: 'Password',
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
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
                                  if (_formKey.currentState!.validate()) {
                                    emailAuth
                                        .registerWithEmailAndPassword(
                                            email: conEmail.text,
                                            password: conPass.text)
                                        .then((value) {
                                      if (value) {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'Successfully registered user',
                                                style: TextStyle(fontSize: 20)),
                                            content: const Text(
                                                'Open the link sent to your email to confirm your email'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                        Navigator.pushNamed(context, '/login');
                                      } else {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'Email already exists',
                                                style: TextStyle(fontSize: 20)),
                                            content: const Text(
                                                'The email is already associated with another account'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'OK'),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    });
                                  }
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
                                  "Register",
                                  style: TextStyle(
                                      color: AppColor.lightGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "Or register with social media",
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      child: Center(
                                        child: FacebookAuthButton(
                                          onPressed: () {
                                            faceAuth
                                                .signUpWithFacebook()
                                                .then((value) {
                                              if (value) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Facebook user successfully registered',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    content: const Text(
                                                        'You can login using Facebook right now'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                Navigator.pushNamed(
                                                    context, '/login');
                                              } else {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'The Facebook user is already registered',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    content: const Text(
                                                        'The Facebook account is already associated with another account'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                          themeMode:currentThemeData?.brightness ==
                                        Brightness.dark
                                    ? ThemeMode.dark
                                    : ThemeMode.light, 
                                          style: const AuthButtonStyle(
                                            buttonType: AuthButtonType.icon,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      child: Center(
                                        child: GoogleAuthButton(
                                          onPressed: () {
                                            googleAuth
                                                .registerWithGoogle()
                                                .then((value) {
                                              if (value) {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Google user successfully registered',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    content: const Text(
                                                        'You can login using Google right now'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                Navigator.pushNamed(
                                                    context, '/login');
                                              } else {
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'The Google user is already registered',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    content: const Text(
                                                        'The Google account is already associated with another account'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context, 'OK'),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            });
                                          },
                                          themeMode:currentThemeData?.brightness ==
                                        Brightness.dark
                                    ? ThemeMode.dark
                                    : ThemeMode.light, 
                                          style: const AuthButtonStyle(
                                            buttonType: AuthButtonType.icon,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
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
