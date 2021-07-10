import 'package:flutter/material.dart';
import 'package:homeautomation/models/room.dart';
import 'package:homeautomation/models/routeargument.dart';
import 'package:homeautomation/pages/LoginControl.dart';
import 'package:homeautomation/pages/home.dart';
import 'package:homeautomation/pages/login.dart';
import 'package:homeautomation/pages/mainpage.dart';
import 'package:homeautomation/pages/newroom.dart';
import 'package:homeautomation/pages/profilepage.dart';
import 'package:homeautomation/pages/roompage.dart';
import 'package:homeautomation/pages/started.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/Main':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/Started':
        return MaterialPageRoute(builder: (_) => StartedPage());
      case '/RoomEdit':
        return MaterialPageRoute(builder: (_) => NewRoom(room: args as Room,));
      case '/LoginControl':
        return MaterialPageRoute(builder: (_) => LoginControl());
      case '/Login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/Room':
        return MaterialPageRoute(builder: (_) => RoomPage(room: args as Room,));
      case '/Profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: SafeArea(child: Text('Route Error'))));
    }
  }
}
