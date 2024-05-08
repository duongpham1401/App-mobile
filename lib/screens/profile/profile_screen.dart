import 'package:english_app/component/loading_overlay.dart';
import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/models/user_model.dart';
import 'package:english_app/screens/profile/change_password_screen.dart';
import 'package:english_app/screens/profile/update_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthController _controller = Get.put(AuthController());
    return FutureBuilder(
        future: _controller.getUserDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingOverlay();
          }
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          UserModel userData = snapshot.data as UserModel;

          _emailController.text = userData.email;
          _fullNameController.text = userData.fullName;

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text("Profile"),
              backgroundColor: Colors.blue,
              // elevation: 0.0,
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
                          width: 100,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(userData.fullName,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(userData.email,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 14)),
                    const SizedBox(
                      height: 30,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuWidget(
                      title: 'Edit Profile',
                      icon: Icons.edit,
                      onTap: () {
                        Get.to(UpdateProfileScreen(
                          user: userData,
                        ));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuWidget(
                      title: 'Change Password',
                      icon: Icons.password,
                      onTap: () {
                        Get.to(ChangePasswordScreen(
                          user: userData,
                        ));
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MenuWidget(
                      title: 'Log out',
                      icon: Icons.logout,
                      onTap: () {
                        _controller.logoutAccount();
                      },
                      endIcon: false,
                      textColor: Colors.red,
                    ),
                  ],
                ),
              )),
            ),
          );
        });
  }
}

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap();
      },
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.lightBlueAccent.withOpacity(0.1)),
        child: Icon(
          icon,
          color: Colors.blue,
          size: 26,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            color: textColor, fontSize: 16, fontWeight: FontWeight.w400),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: const Icon(
                Icons.arrow_right,
                size: 24,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
