import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app_style.dart';
import '../size_config.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        100,
      );
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeHorizontal = SizeConfig.blockSizeHorizontal!;
    // print('sizeHorizontal' + sizeHorizontal.toString());
    // print('sizeVertical' + sizeVertical.toString());
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    const userProfile = 'assets/user/man.png';

    User? auth = FirebaseAuth.instance.currentUser;

    String? yourName = auth?.displayName;
    String? yourprofilePictureUrl = auth?.photoURL;

    return Container(
      width: double.infinity,
      height: 100.0 + statusBarHeight,
      decoration: const BoxDecoration(
        color: kPrimaryWhite,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: statusBarHeight,
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  child: ClipOval(
                    child: yourprofilePictureUrl != null
                        ? Image.network(
                            yourprofilePictureUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                userProfile,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            userProfile,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  width: sizeHorizontal * 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hello,",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      yourName ?? "Your Name",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(), // Add a spacer for better alignment
            Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () {
                  // AppDrawer().openDrawer();
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
