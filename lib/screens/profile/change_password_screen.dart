import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/models/user_model.dart';
import 'package:english_app/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, required this.user});

  final UserModel user;

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newRepeatPasswordController = TextEditingController();
  final AuthController _controller = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Change Password"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              editTextField("Enter Your Password", Icons.password, true, true,
                  _oldPasswordController),
              const SizedBox(
                height: 20,
              ),
              editTextField("Enter New Password", Icons.password, true, true,
                  _newPasswordController),
              const SizedBox(
                height: 20,
              ),
              editTextField("Enter New Repeat Password", Icons.password, true,
                  true, _newRepeatPasswordController),
              const SizedBox(
                height: 30,
              ),
              customButton(context, 'Change Password', false, () async {
                if (_oldPasswordController.text != widget.user.password) {
                  Get.snackbar(
                    "Error",
                    "Your password incorrect.",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.redAccent.withOpacity(0.5),
                    colorText: Colors.orange,
                  );
                } else if (_newPasswordController.text !=
                    _newRepeatPasswordController.text) {
                  Get.snackbar(
                    "Error",
                    "New password different Repeat Password.",
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.redAccent.withOpacity(0.5),
                    colorText: Colors.orange,
                  );
                } else {
                  _controller.changePassword(widget.user.email,
                      widget.user.password, _newPasswordController.text);
                }
              }),
            ],
          ),
        )),
      ),
    );
  }
}
