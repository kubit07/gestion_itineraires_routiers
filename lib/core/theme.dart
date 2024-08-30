import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

// Construction d'un Thème clair personnalisé avec couleurs, styles de texte, AppBar, boutons, icônes, et bordures.

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    textTheme: const TextTheme(
      labelLarge: lableTextStyle,
      labelMedium: lableTextStyle,
      labelSmall: lableTextStyle,
      bodyMedium: TextStyle(color: secondaryColor40LightTheme),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 222, 224, 207),
      elevation: 10.0,
      toolbarTextStyle: TextStyle(color: textColorLightTheme),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
      fillColor: Color.fromARGB(255, 232, 233, 229),
      filled: true,
      border: lightThemeOutlineInputBorder,
      enabledBorder: lightThemeOutlineInputBorder,
      focusedBorder: lightThemeOutlineInputBorder,
      disabledBorder: lightThemeOutlineInputBorder,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.infinity, 48),
        shape: const StadiumBorder(),
        backgroundColor: const Color.fromARGB(255, 222, 224, 207),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: textColorLightTheme),
    dividerColor: secondaryColor5LightTheme,
  );
}

const OutlineInputBorder lightThemeOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide.none,
);

const lableTextStyle = TextStyle(color: secondaryColor20LightTheme);
