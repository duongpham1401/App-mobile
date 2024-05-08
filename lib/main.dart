import 'package:english_app/exxample.dart';
import 'package:english_app/screens/auth/signin_screen.dart';
import 'package:english_app/screens/game/home_game_screen.dart';
import 'package:english_app/screens/game/rankings_game_screen.dart';
import 'package:english_app/screens/grammar/home_typeG_screen.dart';
import 'package:english_app/screens/home_screen.dart';
import 'package:english_app/screens/listen/home_typeL_screen.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:english_app/screens/score/score_screen.dart';
import 'package:english_app/screens/splash/splash_screen.dart';
import 'package:english_app/screens/translate/translate_screen.dart';
import 'package:english_app/screens/vocabulary/home_typeV_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'English Exercise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: NavigatorScreen(index: 0,)
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return NavigatorScreen(index: 0,);
            } else {
              return const SignInScreen();
            }
          }
        },
      ),
    );
  }
}
