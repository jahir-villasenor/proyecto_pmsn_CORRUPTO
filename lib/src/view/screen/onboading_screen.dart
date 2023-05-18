import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/core/app_color.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/widget/onboarding_contents.dart';

import '../../provider/theme_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: AppColor.lightOrange,
      ),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData? currentThemeData = themeProvider.getthemeData();

    return Scaffold(
      backgroundColor: currentThemeData?.brightness == Brightness.dark
          ? AppColor.modeDark
          : AppColor.lightGrey,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final screenHeight = MediaQuery.of(context).size.height;
            final screenWidth = MediaQuery.of(context).size.width;
            final isSmallScreen = screenHeight <= 500;
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    onPageChanged: (value) =>
                        setState(() => _currentPage = value),
                    itemCount: contents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 20 : 40,
                          vertical: isSmallScreen ? 10 : 40,
                        ),
                        child: Column(
                          children: [
                            Lottie.asset(
                              contents[index].animation,
                              width: isSmallScreen ? 250 : 500,
                              height: isSmallScreen ? 150 : 300,
                            ),
                            SizedBox(
                              height: isSmallScreen ? 30 : 60,
                            ),
                            Text(
                              contents[index].title,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: AppColor.darkOrange),
                            ),
                            SizedBox(
                              height: isSmallScreen ? 15 : 20,
                            ),
                            Text(
                              contents[index].desc,
                              style: TextStyle(
                                fontSize: 18,
                                color: currentThemeData?.brightness ==
                                        Brightness.dark
                                    ? AppColor.textDark
                                    : AppColor.textLight,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          contents.length,
                          (int index) => _buildDots(index: index),
                        ),
                      ),
                      _currentPage + 1 == contents.length
                          ? Padding(
                              padding: EdgeInsets.all(isSmallScreen ? 10 : 30),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text("START"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.darkOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        isSmallScreen ? 25 : 50),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 20 : 100,
                                    vertical: isSmallScreen ? 10 : 20,
                                  ),
                                  textStyle: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.all(isSmallScreen ? 10 : 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () => _controller.jumpToPage(5),
                                    child: const Text(
                                      "SKIP",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: AppColor.darkGrey,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _controller.nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    child: Text('NEXT'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.darkOrange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            isSmallScreen ? 25 : 50),
                                      ),
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isSmallScreen ? 10 : 30,
                                        vertical: isSmallScreen ? 10 : 20,
                                      ),
                                      textStyle: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
