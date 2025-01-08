import 'package:flutter/material.dart';

class AppTheme {
  // 马卡龙风格主题
  static final ThemeData macaronTheme = ThemeData(
    primarySwatch: createMaterialColor(const Color(0xFFFFDDE1)), // 淡粉
    scaffoldBackgroundColor: const Color(0xFFF2ECE3), // 米白
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFDDE1),
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFFC2C6), // 稍深的粉色
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  // 莫兰迪风格主题
  static final ThemeData morandiTheme = ThemeData(
    primarySwatch: createMaterialColor(const Color(0xFFA7BBC7)), // 莫兰迪蓝
    scaffoldBackgroundColor: const Color(0xFFF2ECE3), // 米白
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFA7BBC7),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFA7BBC7),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.black87),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );

  // 将颜色转换为MaterialColor
  static MaterialColor createMaterialColor(Color color) {
    List<double> strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  // 获取颜色方案
  static Map<String, Color> getColorScheme(bool isMorandi) {
    return isMorandi
        ? {
            'primary': Color(0xFFA7BBC7),
            'secondary': Color(0xFFE2C4C0),
            'background': Color(0xFFF2ECE3),
            'card': Colors.white,
            'text': Colors.black87,
          }
        : {
            'primary': Color(0xFFFFDDE1),
            'secondary': Color(0xFFCAF0F8),
            'background': Color(0xFFF2ECE3),
            'card': Colors.white,
            'text': Colors.black87,
          };
  }
}
