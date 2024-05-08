import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:is_first_run/is_first_run.dart';

import '../../../utils/SharedPreferences.dart';
import '../controller/SplashScreenController.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? _isFirstRun = false;
  void _checkFirstRun() async {
    bool ifr = await IsFirstRun.isFirstRun();
    setState(() {
      _isFirstRun = ifr;
      SharedPref.setIsFirstTime(ifr);
      print("IS FIRST RUN $ifr");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkFirstRun();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset("assets/logo.png"),
        ),
      );
    });
  }
}
