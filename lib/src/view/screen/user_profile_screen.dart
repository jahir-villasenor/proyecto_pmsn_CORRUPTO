import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/core/app_color.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/widget/profile_pics.dart';

import '../../model/user_model.dart';
import '../../provider/theme_provider.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool showPassword = false;
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      user = ModalRoute.of(context)!.settings.arguments as UserModel;
    }
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData? currentThemeData = themeProvider.getthemeData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: currentThemeData?.brightness == Brightness.dark
                ? AppColor.textDark
                : AppColor.textLight,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.darkOrange,
          ),
          onPressed: () {
            Navigator.pop(context, '/profile');
          },
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      ProfilePics(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                buildTextFieldName("Full Name", user!.name.toString()),
                buildTextFieldEmail("E-mail", user!.email.toString()),
                buildTextFieldPhone("Phone Number", "4613114498"),
                buildTextFieldLocation("Location", "Celaya, Mexico"),
                SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: AppColor.darkOrange,
                    elevation: 2,
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    minimumSize: const Size(0, 40),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                        color: AppColor.lightGrey, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldName(
    String labelText,
    String placeholder,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            icon: const Icon(Icons.person, color: AppColor.darkOrange),
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.lightOrange,
            )),
      ),
    );
  }

  Widget buildTextFieldEmail(
    String labelText,
    String placeholder,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            icon: const Icon(Icons.email, color: AppColor.darkOrange),
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.lightOrange,
            )),
      ),
    );
  }

  Widget buildTextFieldPhone(
    String labelText,
    String placeholder,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            icon: const Icon(Icons.phone, color: AppColor.darkOrange),
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.lightOrange,
            )),
      ),
    );
  }

  Widget buildTextFieldLocation(
    String labelText,
    String placeholder,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            icon: const Icon(Icons.location_on, color: AppColor.darkOrange),
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.lightOrange,
            )),
      ),
    );
  }
}
