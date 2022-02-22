import 'package:flutter/material.dart';

List<BoxShadow> shadow = <BoxShadow>[
  BoxShadow(
      blurRadius: 10,
      offset: const Offset(5, 5),
      color: AppTheme.apptheme.colorScheme.secondary,
      spreadRadius: 1)
];
String get description {
  return '';
}

TextStyle get onPrimaryTitleText {
  return const TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
}

TextStyle get onPrimarySubTitleText {
  return const TextStyle(
    color: Colors.white,
  );
}

BoxDecoration softDecoration = const BoxDecoration(boxShadow: <BoxShadow>[
  BoxShadow(
      blurRadius: 8,
      offset: Offset(5, 5),
      color: Color(0xffe2e5ed),
      spreadRadius: 5),
  BoxShadow(
      blurRadius: 8,
      offset: Offset(-5, -5),
      color: Color(0xffffffff),
      spreadRadius: 5)
], color: Color(0xfff1f3f6));
TextStyle get titleStyle {
  return const TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}

TextStyle get subtitleStyle {
  return const TextStyle(
      color: AppColor.darkGrey, fontSize: 14, fontWeight: FontWeight.bold);
}

TextStyle get userNameStyle {
  return const TextStyle(
      color: AppColor.darkGrey, fontSize: 14, fontWeight: FontWeight.bold);
}

TextStyle get textStyle14 {
  return const TextStyle(
      color: AppColor.darkGrey, fontSize: 14, fontWeight: FontWeight.bold);
}

class TwitterColor {
  static const Color bondiBlue = Color.fromRGBO(0, 132, 180, 1.0);
  static const Color cerulean = Color.fromRGBO(0, 172, 237, 1.0);
  static const Color spindle = Color.fromRGBO(192, 222, 237, 1.0);
  static const Color white = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color black = Color.fromRGBO(0, 0, 0, 1.0);
  static const Color woodsmoke = Color.fromRGBO(20, 23, 2, 1.0);
  static const Color woodsmoke_50 = Color.fromRGBO(20, 23, 2, 0.5);
  static const Color mystic = Color.fromRGBO(230, 236, 240, 1.0);
  static const Color dodgetBlue = Color.fromRGBO(29, 162, 240, 1.0);
  static const Color dodgetBlue_50 = Color.fromRGBO(29, 162, 240, 0.5);
  static const Color paleSky = Color.fromRGBO(101, 119, 133, 1.0);
  static const Color ceriseRed = Color.fromRGBO(224, 36, 94, 1.0);
  static const Color paleSky50 = Color.fromRGBO(101, 118, 133, 0.5);
}

class AppColor {
  static const Color primary = Colors.indigo;
  static const Color secondary = Color(0xff14171A);
  static const Color darkGrey = Color(0xff1657786);
  static const Color lightGrey = Color(0xffAAB8C2);
  static const Color extraLightGrey = Color(0xffE1E8ED);
  static const Color extraExtraLightGrey = Color(0xfF5F8FA);
  static const Color white = Color(0xFFffffff);
}

class AppTheme {
  static final ThemeData apptheme = ThemeData(
      primarySwatch: Colors.blue,
      // fontFamily: 'HelveticaNeue',
      backgroundColor: TwitterColor.white,
      accentColor: TwitterColor.dodgetBlue,
      brightness: Brightness.light,
      primaryColor: AppColor.primary,
      cardColor: Colors.white,
      unselectedWidgetColor: Colors.grey,
      bottomAppBarColor: Colors.white,
      bottomSheetTheme:
          const BottomSheetThemeData(backgroundColor: AppColor.white),
      appBarTheme: const AppBarTheme(
          brightness: Brightness.light,
          color: TwitterColor.white,
          iconTheme: IconThemeData(
            color: TwitterColor.dodgetBlue,
          ),
          elevation: 0,
          textTheme: TextTheme(
            headline6: TextStyle(
                color: Colors.black, fontSize: 26, fontStyle: FontStyle.normal),
          )),
      tabBarTheme: TabBarTheme(
        labelStyle: titleStyle.copyWith(color: TwitterColor.dodgetBlue),
        unselectedLabelColor: AppColor.darkGrey,
        unselectedLabelStyle: titleStyle.copyWith(color: AppColor.darkGrey),
        labelColor: TwitterColor.dodgetBlue,
        labelPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: TwitterColor.dodgetBlue,
      ),
      colorScheme: const ColorScheme(
          background: Colors.white,
          onPrimary: Colors.white,
          onBackground: Colors.black,
          onError: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          error: Colors.red,
          primary: Colors.blue,
          primaryVariant: Colors.blue,
          secondary: AppColor.secondary,
          secondaryVariant: AppColor.darkGrey,
          surface: Colors.white,
          brightness: Brightness.light));
}
