import 'package:flutter/material.dart';
import '../app_style.dart';
import 'auth/social_login.dart';
import '../size_config.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void pageRoute() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SocialLogin(),
      ),
    );
  }

  Future<void> _loadData() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Simulate 3 seconds loading time
    pageRoute();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeVertical = SizeConfig.blockSizeVertical!;
    double sizeHorizontal = SizeConfig.blockSizeHorizontal!;
    // print('sizeHorizontal: ' + sizeHorizontal.toString());
    // print('sizeVertical: ' + sizeVertical.toString());

    return Scaffold(
      backgroundColor: kDarkWhiteColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/logo/appLogo.png',
                height: sizeVertical * 15,
              ),
            ),
            SizedBox(
              height: sizeVertical * 2,
            ),
            Text(
              "IncoXpense",
              style: TextStyle(
                fontSize: sizeHorizontal * 7,
                color: kDarkGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
