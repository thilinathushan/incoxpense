import 'package:flutter/material.dart';
import 'components/layouts/main_layout.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';
import 'pages/auth/social_login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //the user data that the provider provides this can be a
    //user data or  can be null
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return const SocialLogin();
    } else {
      return MainLayout();
    }
  }
}
