import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/layouts/main_layout.dart';
import '../../app_style.dart';
import '../../components/auth/social_signin.dart';
import '../../services/auth_service.dart';
import '../../services/user_save.dart';
import '../../size_config.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeVertical = SizeConfig.blockSizeVertical!;
    double sizeHorizontal = SizeConfig.blockSizeHorizontal!;

    final AuthService auth = AuthService();
    final fireAuth = FirebaseAuth.instance;
    User? user;
    final UserSave userSave = UserSave();

    void pageRoute() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainLayout(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kDarkWhiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: sizeVertical * 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign",
                    style: TextStyle(color: kPrimaryBlue, fontSize: 40),
                  ),
                  SizedBox(
                    width: sizeHorizontal * 2,
                  ),
                  const Text(
                    "In",
                    style: TextStyle(color: kDarkGray, fontSize: 40),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: sizeVertical * 10,
                  ),
                  Container(
                    height: sizeVertical * 0.5,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: kDarkGray,
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(10), // Adjust the top-left corner
                        bottomLeft: Radius.circular(
                            10), // Adjust the bottom-left corner
                      ),
                    ),
                  ),
                  Container(
                    height: sizeVertical * 0.5,
                    width: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight:
                            Radius.circular(10), // Adjust the top-left corner
                        bottomRight: Radius.circular(
                            10), // Adjust the bottom-left corner
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: sizeVertical * 5,
              ),

              Center(
                child: SvgPicture.asset('assets/auth/Signin.svg',
                    height: sizeVertical * 40),
              ),

              // scocial  log in
              SizedBox(
                height: sizeVertical * 8,
              ),

              // google
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SocialSignIn(
                    imagePath: const AssetImage('assets/auth/google.png'),
                    socialLoginText: "Continue with Google",
                    socialLoginTextColor: kPrimaryBlack,
                    btnColor: Colors.white,
                    onTap: () async {
                      dynamic result = await auth.signInWithGoogle();
                      if (result != null) {
                        user = fireAuth.currentUser;
                        // print("Logged In: " + result.uid);
                        userSave.storeUserData(user!);
                        pageRoute();
                      } else {
                        // print("Error in sign in");
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
