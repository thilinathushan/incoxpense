import 'package:flutter/material.dart';
import 'database/transaction_db.dart';
import 'models/user_model.dart';
import 'services/auth_service.dart';
import 'wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/user_details_provider.dart';
import 'providers/user_widget_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<UserModel?> authUser = AuthService().user;

    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
          initialData: UserModel(uid: ""),
          value: authUser,
        ),
        ChangeNotifierProvider(
          create: (context) => UserDetailsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserWidgetProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionDB(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
