import 'package:flutter/material.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/forgot_password_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/home_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/login_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/profile_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/register_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/settings_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/user_profile_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (BuildContext context) => LoginScreen(),
    '/register': (BuildContext context) => RegisterScreen(),
    '/dash': (BuildContext context) => HomeScreen(),
    '/forgot': (BuildContext context) => ForgotScreen(),
    '/userprofile': (BuildContext context) => UserProfileScreen(),
    '/profile': (BuildContext context) => ProfileScreen(),
    '/settings': (BuildContext context) => SettingsScreen(),
  };
}
