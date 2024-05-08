import 'dart:async';
import 'package:english_app/reusable_widgets/reusable_widget.dart';
import 'package:english_app/screens/auth/signin_screen.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        Get.offAll(const SignInScreen());
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexStringToColor("0E89E7"),
            hexStringToColor("2B88CF"),
            hexStringToColor("CBDBE8")
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: ClipOval(
                child: logoWidget("assets/images/logo512.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
