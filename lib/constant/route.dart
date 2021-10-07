import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import '../pages/pages.dart';

class Route {
  static const home = '/home';
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const app = '/app';

  static Map<String, WidgetBuilder> getAll() => _route;
  static final Map<String, WidgetBuilder> _route = {
   /* '/home': (context) => HomePage(),
    '/login': (context) => LoginPage(),
    '/dashboard': (context) => DashboardPage(),
    '/app': (context) => App(),*/
  };
}
