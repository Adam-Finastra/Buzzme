import 'package:buzzme/user/controller/provider.dart';
import 'package:buzzme/splash_screen.dart';
import 'package:buzzme/user/view/auth/login_screen.dart';
import 'package:buzzme/user/view/onbording/preferemce_screen.dart';
import 'package:buzzme/user/view/screens/bottombar.dart';
import 'package:buzzme/user/view/screens/profile/rejeted_screen.dart';
import 'package:buzzme/user/view/screens/profile/profile_screen.dart';
import 'package:buzzme/user/view/screens/profile/settings_screen.dart';
import 'package:buzzme/user/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const BuzzMeApp());
}

class BuzzMeApp extends StatelessWidget {
  const BuzzMeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppProvider())],
      child: MaterialApp(
        title: 'Buzz Me',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: const Color(0xFF2A2A2A),
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
