import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyTheme{

  static ThemeData lightTheme(BuildContext context) => ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: MyTheme.skyblue
    ),
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      color: MyTheme.orange,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: Theme.of(context).textTheme
    )
  );

  static ThemeData darkTheme(BuildContext context) =>ThemeData(
    brightness: Brightness.dark,
  );

  static Color creamColor = Color(0xfff5f5f5);
  static Color darkBluishColor = Color(0xff403b58);
  static Color smokeyWhite = Color(0xFFEEEEEE);
  static Color orange = Color(0xFFC95A18);
  static Color lightorange = Color(0xFFE17C3F);
  static Color skyblue = Color(0xFF3F90B8);
  static Color lightskyblue = Color(0xFF89C4E1);
  static Color darkblue = Color(0xFF1E3B7F);
  static Color backgroundlayout = Color(0xFFF1ECEC);
  static Color bglayout = Color(0xFFD1EAFA);
  static Color bg2layout = Color(0xFFD1E3FA);
  static Color bg3layout = Color(0xFFF3F1F8);
  static Color bg4layout = Color(0xFFFDF3ED);
}