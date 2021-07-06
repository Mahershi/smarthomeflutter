import 'package:flutter/material.dart';
import 'package:homeautomation/models/routeargument.dart';
import 'package:homeautomation/pages/home.dart';
import 'package:homeautomation/pages/mainpage.dart';
import 'package:homeautomation/pages/profilepage.dart';
import 'package:homeautomation/pages/roompage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Main':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/Room':
        return MaterialPageRoute(builder: (_) => RoomPage(argument: RouteArgument(param: args),));
      case '/Profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
