import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/reusable_widgets/reusable_widget.dart';
import 'package:english_app/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:english_app/utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthController _controller = Get.put(AuthController());

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("0E89E7"),
          hexStringToColor("2B88CF"),
          hexStringToColor("CBDBE8")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Column(
            children: <Widget>[
              logoWidget("assets/images/logo512.png"),
              const SizedBox(
                height: 10,
              ),
              newTextField(
                  "Enter Email", Icons.person_outline, false, _emailController),
              const SizedBox(
                height: 20,
              ),
              newTextField("Enter Password", Icons.lock_outline, true,
                  _passwordController),
              const SizedBox(
                height: 20,
              ),
              signInsignUpButton(context, true, () async {
                _controller.signinAccount(
                    _emailController.text, _passwordController.text);
              }),
              signUpOption()
            ],
          ),
        )),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Get.to(SignUpScreen());
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
