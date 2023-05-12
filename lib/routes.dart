import 'package:flutter/material.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/forgot_password.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/home_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/login_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/register_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginScreen(),
    '/register': (BuildContext context) => RegisterScreen(),
    '/dash': (BuildContext context) => HomeScreen(),
    '/forgot': (BuildContext context) => ForgotScreen(),
  };
}
