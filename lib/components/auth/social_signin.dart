// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import '../../../size_config.dart';

class SocialSignIn extends StatelessWidget {
  dynamic imagePath;
  final String socialLoginText;
  dynamic socialLoginTextColor;
  dynamic btnColor;
  final Function()? onTap;

  SocialSignIn({
    super.key,
    required this.imagePath,
    required this.socialLoginText,
    required this.socialLoginTextColor,
    required this.btnColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeVertical = SizeConfig.blockSizeVertical!;
    double sizeHorizontal = SizeConfig.blockSizeHorizontal!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: sizeVertical * 9, // Set the height as needed
        width: sizeHorizontal * 80, // Set the width as needed
        padding: const EdgeInsets.all(10), // Adjust padding as needed
        decoration: BoxDecoration(
          color: btnColor, // Background color
          borderRadius:
              BorderRadius.circular(50), // Adjust border radius as needed
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: sizeHorizontal * 4,
            ),
            Image(
              image: imagePath,
              height: sizeVertical * 5,
              // width: 30,
            ),
            SizedBox(
              width: sizeHorizontal * 4,
            ),
            Text(
              socialLoginText,
              style: TextStyle(
                fontSize: 20.0, // Adjust the font size as needed
                color: socialLoginTextColor, // Text color
                // Add more styling as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
