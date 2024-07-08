import 'package:flutter/material.dart';

//for responsive design
class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? appbarSize;
  static double? bottomNavBarSize;
  static double? useableScreenHeight;
  static double? useableBlockSizeVertical;
  static double? appbars;
  static double? appDrawerSize;
  // static double? bottomNavBar;
  // final coupleAppbar = const CoupleAppBar();

  // final bottomNavBar = bottomNavigationBar;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
    // appbarSize = coupleAppbar.preferredSize.height;
    // bottomNavBarSize = kBottomNavigationBarHeight;
    // appbars = appbarSize! + bottomNavBarSize!;
    // useableScreenHeight = screenHeight! - appbars!;
    // useableBlockSizeVertical = useableScreenHeight! / 100;
    appDrawerSize = blockSizeHorizontal! * 75;
  }
}
