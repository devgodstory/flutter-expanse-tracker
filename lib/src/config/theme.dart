import 'package:flutter/cupertino.dart';

class Theme {
  const Theme();

  static const Color gradientStart = Color(0xFF12c2e9);
  static const Color gradientCenter =  Color(0xFFc471ed);
  static const Color gradientEnd =  Color(0xFFf64f59);

  static const gradient =  LinearGradient(
    colors: [gradientStart, gradientCenter, gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.3, 1.0],
  );
}
