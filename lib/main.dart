import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:task3/screens/home.dart';
import 'package:task3/themes.dart';

import 'auth/loginscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 3',
      themeMode: ThemeMode.system,
      theme:Themes.lighttheme,
      darkTheme: Themes.darktheme,
      home: FirebaseAuth.instance.currentUser!=null ? Home():LoginScreen(),
    );
  }
}