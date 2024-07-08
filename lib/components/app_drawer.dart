// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'layouts/main_layout.dart';
import '../pages/auth/social_login.dart';
import '../app_style.dart';
import '../size_config.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;

  //logout user
  void logout() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    // print('SignOut Successfully!');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final appDrawerSize = SizeConfig.appDrawerSize!;
    return SizedBox(
      width: appDrawerSize,
      child: Drawer(
        backgroundColor: kPrimaryWhite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 100.0,
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/logo/appLogo.png"),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                  "IncoXpense",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text(
                      "Home",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainLayout(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                bottom: 40.0,
              ),
              child: ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text(
                  "SignOut",
                  style: TextStyle(fontSize: 15.0),
                ),
                onTap: () {
                  logout();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SocialLogin(),
                    ),
                  );
                  // Redirect to the login page
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
