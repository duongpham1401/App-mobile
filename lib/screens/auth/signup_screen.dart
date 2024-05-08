import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/models/user_model.dart';
import 'package:english_app/reusable_widgets/reusable_widget.dart';
import 'package:english_app/screens/auth/signin_screen.dart';
import 'package:english_app/utils/color_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();
  String errMsg = '';

  @override
  Widget build(BuildContext context) {
    AuthController _controller = Get.put(AuthController());

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${errMsg}",
                    style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              newTextField("Enter Your Name", Icons.person_outline, false,
                  _fullNameController),
              const SizedBox(
                height: 20,
              ),
              newTextField(
                  "Enter Email", Icons.email, false, _emailController),
              const SizedBox(
                height: 20,
              ),
              newTextField("Enter Password", Icons.lock_outline, true,
                  _passwordController),
              const SizedBox(
                height: 20,
              ),
              newTextField("Enter Repeat Password", Icons.lock_outline,
                  true, _repeatPasswordController),
              const SizedBox(
                height: 20,
              ),
              signInsignUpButton(
                context,
                false,
                () async {
                  if (_fullNameController.text == '' ||
                      _emailController.text == '' ||
                      _passwordController.text == '' ||
                      _repeatPasswordController.text == '') {
                    setState(() {
                      errMsg = 'Please fill text field.';
                    });
                  } else if (_passwordController.text !=
                      _repeatPasswordController.text) {
                    setState(() {
                      errMsg = 'Password different Repeat Password.';
                    });
                  } else {
                    try {
                      UserCredential userCredential =
                          await _controller.registerAccount(
                              _emailController.text, _passwordController.text);

                      if (userCredential.user != null) {
                        final user = UserModel(
                            fullName: _fullNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            id: userCredential.user?.uid);

                        _controller.createUser(user);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        setState(() {
                          errMsg = 'The password provided is too weak.';
                        });
                      } else if (e.code == 'email-already-in-use') {
                        setState(() {
                          errMsg = 'The account already exists for that email.';
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
              signInOption(),
            ],
          ),
        )),
      ),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Does have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Get.to(SignInScreen());
          },
          child: const Text(
            "LogIn",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
