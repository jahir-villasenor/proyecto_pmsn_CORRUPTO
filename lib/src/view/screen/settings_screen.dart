import 'dart:math';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_color.dart';
import '../../provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  @override
  bool val = false;
  late AnimationController _controller;
  late Size size;
  static const dayColor = Color(0xFFd56352);
  static const nightColor = Color(0xFF1e2230);
  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchValue();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  void _loadSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool switchValue = prefs.getBool('themeSwitchValue') ?? false;
    setState(() {
      _switchValue = switchValue;
      val = switchValue;
    });
  }

  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData? currentThemeData = themeProvider.getthemeData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text("Settings",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: currentThemeData?.brightness == Brightness.dark
                  ? AppColor.textDark
                  : AppColor.textLight,
            )),
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
      body: View(context),
    );
  }

  Widget View(BuildContext context) {
    size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    ThemeData? currentThemeData = themeProvider.getthemeData();
    return Scaffold(
      backgroundColor: const Color(0xFF414a4c),
      body: AnimatedContainer(
        color: val ? nightColor : dayColor,
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: <Widget>[
            ..._buildStars(20),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height: 200,
              child: Opacity(
                opacity: val ? 0 : 1.0,
                child: Image.asset(
                  'assets/images/cloud.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              height: 200,
              child: Image.asset(
                val
                    ? 'assets/images/mountain2_night.png'
                    : 'assets/images/mountain2.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              height: 140,
              child: Image.asset(
                val
                    ? 'assets/images/mountain_night.png'
                    : 'assets/images/mountain1.png',
                fit: BoxFit.cover,
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: -20,
                      right: 0,
                      left: 0,
                      child: Transform.translate(
                        offset: Offset(50 * _controller.value, 0),
                        child: Opacity(
                          opacity: val ? 0.0 : 0.8,
                          child: Image.asset(
                            'assets/images/cloud2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      right: 0,
                      left: 0,
                      child: Transform.translate(
                        offset: Offset(100 * _controller.value, 0),
                        child: Opacity(
                          opacity: val ? 0.0 : 0.4,
                          child: Image.asset(
                            'assets/images/cloud3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            // _buildSun(),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DayNightSwitch(
                      value: _switchValue,
                      moonImage: const AssetImage('assets/images/moon.png'),
                      onChanged: (value) {
                        _switchValue = value;
                        _saveSwitchValue(value);
                        val
                            ? themeProvider.setthemeData(1, context)
                            : themeProvider.setthemeData(0, context);
                        setState(() {
                          val = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      currentThemeData?.brightness == Brightness.dark
                          ? "Dark Mode is enabled"
                          : "Light Mode is enabled",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: currentThemeData?.brightness == Brightness.dark
                            ? AppColor.lightOrange
                            : AppColor.lightGrey,
                      ),
                    ),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Transform.translate(
        offset: const Offset(160, -360),
        child: _buildSun(),
      ),
    );
  }

  void _saveSwitchValue(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('themeSwitchValue', value);
  }

  Widget _buildSun() {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: AnimatedBuilder(
        animation:
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildContainer(400 * _controller.value),
              _buildContainer(500 * _controller.value),
              _buildContainer(600 * _controller.value),
              SizedBox(
                width: 256,
                height: 256,
                child: val
                    ? Image.asset('assets/images/moon.png')
                    : const CircleAvatar(
                        backgroundColor: Color(0xFFFDB813),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (val ? Colors.amber[100] : Colors.orangeAccent)
            ?.withOpacity(1 - _controller.value),
      ),
    );
  }

  List<Widget> _buildStars(int starCount) {
    List<Widget> stars = [];
    for (int i = 0; i < starCount; i++) {
      stars.add(_buildStar(top: randomX, left: randomY, val: val));
    }
    return stars;
  }

  double get randomX {
    int maxX = (size.height).toInt();
    return Random().nextInt(maxX).toDouble();
  }

  double get randomY {
    int maxY = (size.width).toInt();
    return Random().nextInt(maxY).toDouble();
  }

  Widget _buildStar({
    double top = 0,
    double left = 0,
    bool val = false,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Opacity(
        opacity: val ? 1 : 0,
        child: const CircleAvatar(
          radius: 2,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
