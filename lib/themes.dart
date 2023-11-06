import 'package:flutter/material.dart';

class Themes
{
  static final lighttheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: Colors.black,size: 30),
        titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
        elevation:2
    ),
    indicatorColor: Colors.white,
    primaryColor: Colors.black,
    primaryColorDark: Colors.white,
    textTheme: const TextTheme(
      displaySmall: TextStyle(fontSize: 16,color: Colors.black),
      displayMedium: TextStyle(fontSize: 22,color: Colors.black),
      titleMedium: TextStyle(fontSize: 18,color: Colors.black),
      titleSmall: TextStyle(fontSize: 16,color: Colors.black)

    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 18,color: Colors.black),
      labelStyle: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        foregroundColor: Colors.black,
      ),
    ),
  );

  static final darktheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.white,size: 30),
      centerTitle: true,
      titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
      elevation: 5
    ),
    indicatorColor: Colors.black,
    primaryColor: Colors.white,
    primaryColorDark: Colors.black,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontSize: 18,color: Colors.white),
      displaySmall: TextStyle(fontSize: 16,color: Colors.white),
      displayMedium: TextStyle(fontSize: 22,color: Colors.white),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(fontSize: 18,color: Colors.white),
      labelStyle: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        foregroundColor: Colors.white,
      ),
    ),
  );

}