import 'package:flutter/material.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/widget/profile_menu.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/widget/profile_pics.dart';

import '../../firebase/facebook_auth.dart';
import '../../firebase/google_auth.dart';
import '../../model/user_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  GoogleAuth googleAuth = GoogleAuth();

  FaceAuth faceAuth = FaceAuth();

  UserModel? user;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      user = ModalRoute.of(context)!.settings.arguments as UserModel;
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfilePics(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                {Navigator.pushNamed(context, '/userprofile', arguments: user)},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () =>
                {Navigator.pushNamed(context, '/settings', arguments: user)},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
