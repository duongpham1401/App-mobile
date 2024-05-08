import 'package:english_app/component/drawer.dart';
import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/models/user_model.dart';
import 'package:english_app/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.user});

  final UserModel user;

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthController _controller = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    _emailController.text = widget.user.email;
    _fullNameController.text = widget.user.fullName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.blue,
        // elevation: 0.0,
      ),
      // drawer: const NavigatorDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(colors: [
        //   hexStringToColor("0E89E7"),
        //   hexStringToColor("2B88CF"),
        //   hexStringToColor("CBDBE8")
        // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.1, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                      "https://i.pinimg.com/736x/53/fa/94/53fa941122c8d54ec88af31eedd2f884.jpg",
                      height: 100,
                      width: 100),
                ),
              ),
              editTextField(
                  "Enter Email", Icons.email, false, false, _emailController),
              const SizedBox(
                height: 20,
              ),
              editTextField("Enter Your Name", Icons.person_outline, false,
                  true, _fullNameController),
              const SizedBox(
                height: 40,
              ),
              customButton(context, 'Update Profile', false, () async {
                final newUser = UserModel(
                    id: widget.user.id,
                    fullName: _fullNameController.text,
                    email: widget.user.email,
                    password: widget.user.password);
                _controller.updateUser(newUser);
              }),
            ],
          ),
        )),
      ),
    );
  }
}
