import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_app/models/user_model.dart';
import 'package:english_app/screens/auth/signin_screen.dart';
import 'package:english_app/screens/home_screen.dart';
import 'package:english_app/screens/navigator_screen.dart';
import 'package:english_app/screens/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<UserCredential> registerAccount(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return userCredential;
  }

  Future<void> signinAccount(String email, String password) async {
    try {

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Get.snackbar(
          "Sucess",
          "You has been logged sucessful.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
        Get.to(() => const NavigatorScreen(index: 0));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Error",
          "No user found for that email.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.5),
          colorText: Colors.orange,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Error",
          "Wrong password provided for that user.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.5),
          colorText: Colors.orange,
        );
      }
    }
  }

  Future<void> logoutAccount() async {
    await FirebaseAuth.instance.signOut();
    Get.to(() => const SignInScreen());
  }

  createUser(UserModel user) async {
    await _db
        .collection('users')
        .doc(user.id)
        .set(user.toJson())
        // .add(user.toJson())
        .whenComplete(() {
      Get.snackbar(
        "Sucess",
        "Your account has been created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
      Get.to(() => const NavigatorScreen(index: 0));
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.5),
        colorText: Colors.orange,
      );
    });
  }

  updateUser(UserModel user) async {
    await _db
        .collection('users')
        .doc(user.id)
        .update(user.toJson())
        .whenComplete(() {
      Get.snackbar(
        "Sucess",
        "Your info has been updated.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
      Get.to(() => const ProfileScreen());
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.5),
        colorText: Colors.orange,
      );
    });
  }

  changePassword(String email, String oldPass, String newPass) async {
    //Create an instance of the current user.
    var user = await FirebaseAuth.instance.currentUser!;
    final cred =
        await EmailAuthProvider.credential(email: email, password: oldPass);

    //Pass in the password to updatePassword.
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPass).then((_) {
        _db
            .collection('users')
            .doc(user.uid)
            .update({"password": newPass}).then((value) {
          Get.snackbar(
            "Sucess",
            "Your password has been updated.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          );
          Get.to(() => ProfileScreen());
        }).catchError((error, stackTrace) {
          Get.snackbar(
            "Error",
            "Something went wrong. Try again.",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.redAccent.withOpacity(0.5),
            colorText: Colors.orange,
          );
        });
      }).catchError((error) {
        Get.snackbar(
          "Error",
          "Something went wrong. Try again.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.5),
          colorText: Colors.orange,
        );
      });
    }).catchError((err) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try again.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.5),
        colorText: Colors.orange,
      );
    });
  }

  Future<UserModel> getUserDetail() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    late UserModel user;

    if (currentUser != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where("id", isEqualTo: currentUser.uid)
          .get();
      user = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    } else {
      // print('No User Logged');
    }
    return user;
  }

  String getUserId() {
    var currentUser = FirebaseAuth.instance.currentUser;
    return currentUser!.uid;
  }

  Future<bool> isUserLogged() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    late UserModel user;

    if (currentUser != null) {
      return true;
    }
    return false;
  }
}
