import 'package:flutter/material.dart';
class ApplicationThemeManager{
  static Color primaryMainColor=const Color(0xFF5D9CEC);
  static Color secondaryMainColor=const Color(0xFFDFECDB);

  static ThemeData lightTheme=ThemeData(
    primaryColor: primaryMainColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    scaffoldBackgroundColor: secondaryMainColor,
    bottomNavigationBarTheme:BottomNavigationBarThemeData(
     showSelectedLabels: false,
     showUnselectedLabels: false,
      selectedItemColor: primaryMainColor,
      unselectedItemColor: const Color(0xFFC8C9CB),
      selectedIconTheme: const IconThemeData(
        size: 35,
      ),
      unselectedIconTheme: const IconThemeData(
        size: 30
      )
    ),
    textTheme: const TextTheme(
      bodyLarge:TextStyle(
        fontFamily: "Poppins",
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
          fontFamily: "Poppins",
          fontSize: 18,
          fontWeight: FontWeight.w700,
      ),
       bodySmall:  TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        displayLarge: TextStyle(
      fontFamily: "Poppins",
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),

      displayMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 12,
        fontWeight: FontWeight.w400,
      )
    )
  );
}