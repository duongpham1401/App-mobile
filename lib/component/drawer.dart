import 'package:english_app/controllers/auth_controller.dart';
import 'package:english_app/models/user_model.dart';
import 'package:english_app/screens/game/home_game_screen.dart';
import 'package:english_app/screens/grammar/home_typeG_screen.dart';
import 'package:english_app/screens/home_screen.dart';
import 'package:english_app/screens/listen/home_typeL_screen.dart';
import 'package:english_app/screens/profile/change_password_screen.dart';
import 'package:english_app/screens/profile/profile_screen.dart';
import 'package:english_app/screens/profile/update_profile_screen.dart';
import 'package:english_app/screens/translate/translate_screen.dart';
import 'package:english_app/screens/vocabulary/home_typeV_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          buildHeader(context),
          buildMenuItems(context),
        ]),
      ),
    ));
  }

  Widget buildHeader(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    AuthController _controller = Get.put(AuthController());

    return FutureBuilder(
        future: _controller.getUserDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          UserModel userData = snapshot.data as UserModel;

          return Container(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: InkWell(
                onTap: () {
                  Get.back();
                  Get.to(() => const ProfileScreen());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://i.pinimg.com/736x/53/fa/94/53fa941122c8d54ec88af31eedd2f884.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(userData.fullName,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(userData.email,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildMenuItems(BuildContext context) {
    AuthController _controller = Get.put(AuthController());

    return FutureBuilder(
        future: _controller.getUserDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          UserModel userData = snapshot.data as UserModel;
          return Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 24.0),
            child: Wrap(
              children: [
                MenuWidget(
                  title: 'Translate',
                  icon: Icons.g_translate,
                  onTap: () {
                    Get.back();
                    Get.to(() => TranslateScreen());
                  },
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
            color: textColor, fontSize: 16, fontWeight: FontWeight.w600),
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
