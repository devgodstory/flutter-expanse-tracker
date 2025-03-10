import 'package:flutter/cupertino.dart';
// import 'package:flutter_application_oat/src/pages/pages.dart'; // รวมการ import page ที่จะใช้ทั้งหมดไว้ในไฟล์นี้

class Route {
  static const home = '/home';
  static const login = '/login';
  static const dashboard = '/dashboard';

  static Map<String, WidgetBuilder> getAll() => _route;

  static final Map<String, WidgetBuilder> _route = {
    // home: (context) => HomePage(),
    // login: (context) => LoginPage(),
    // dashboard: (context) => DashBoardPage(),
  };
}
