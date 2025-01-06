import 'package:flutter/material.dart';
import 'package:programing_languages/Client/App_drawer/app_dawer.dart';
import 'package:programing_languages/Login/login.dart';
import 'package:programing_languages/utils/shared_prefirance.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
