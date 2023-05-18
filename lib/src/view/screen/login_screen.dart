import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/core/app_color.dart';

import '../../firebase/email_auth.dart';
import '../../firebase/facebook_auth.dart';
import '../../firebase/google_auth.dart';
import '../../provider/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  EmailAuth emailAuth = EmailAuth();
  GoogleAuth googleAuth = GoogleAuth();
  FaceAuth faceAuth = FaceAuth();
  TextEditingController txtemailCont = TextEditingController();
  TextEditingController txtPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
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
                    "Login",
                    style: TextStyle(color: AppColor.lightGrey, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: AppColor.lightGrey, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: currentThemeData?.brightness == Brightness.dark
                        ? AppColor.modeDark
                        : AppColor.modeLight,
                    borderRadius: const BorderRadius.only(
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
                                height: 50,
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
                                          controller: txtemailCont,
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.email,
                                                color: AppColor.darkOrange),
                                            hintText: 'Insert your Email',
                                            labelText: 'Email',
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
                                          controller: txtPassController,
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
                                height: 30,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/forgot');
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: AppColor.darkGrey),
                                  )),
                              const Text(
                                "---Or---",
                                style: TextStyle(color: AppColor.darkGrey),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: const Text(
                                    "Sing Up",
                                    style: TextStyle(color: AppColor.darkGrey),
                                  )),
                              const SizedBox(
                                height: 30,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  isLoading = true;
                                  setState(() {});
                                  emailAuth
                                      .signInWithEmailAndPassword(
                                          email: txtemailCont.text,
                                          password: txtPassController.text)
                                      .then((value) {
                                    if (value) {
                                      isLoading = false;
                                      setState(() {});
                                      Navigator.pushNamed(context, '/dash');
                                    } else {
                                      isLoading = false;

                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text(
                                              'Email does not exist',
                                              style: TextStyle(fontSize: 20)),
                                          content: const Text(
                                              'Email not registered, create a new account in the Sign in section'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                      setState(() {});
                                    }
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
                                  "Login",
                                  style: TextStyle(
                                      color: AppColor.lightGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Text(
                                "Continue with social media",
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
                                          onPressed: () async {
                                            isLoading = true;
                                            setState(() {});
                                            faceAuth
                                                .signInWithFacebook()
                                                .then((value) {
                                              if (value.name != null) {
                                                Navigator.pushNamed(
                                                    context, '/dash',
                                                    arguments: value);
                                                isLoading = false;
                                              } else {
                                                isLoading = false;
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'The Facebook user has not been registered',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    content: const Text(
                                                        'Please, create an account with facebook from the sign in section'),
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
                                              setState(() {});
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
                                          onPressed: () async {
                                            isLoading = true;
                                            setState(() {});
                                            await googleAuth
                                                .signInWithGoogle()
                                                .then((value) {
                                              if (value.name != null) {
                                                isLoading = false;
                                                Navigator.pushNamed(
                                                    context, '/dash',
                                                    arguments: value);
                                              } else {
                                                isLoading = false;
                                                setState(() {});
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'The Google user has not been registered',
                                                        style: TextStyle(
                                                            fontSize: 20)),
                                                    content: const Text(
                                                        'Please, create an account with Google account from the sign in section'),
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
