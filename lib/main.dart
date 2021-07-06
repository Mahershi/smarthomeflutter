import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homeautomation/pages/splashscreen.dart';

import 'app_config.dart';
import 'helpers/route_gen.dart';
import 'network/rest_service.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  setUpConfiguration();
  RestService.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // navigatorObservers: [settingsRepo.routeObserver],
    );
  }

}

void setUpConfiguration() {
  AppConfig.setEnvironment(Environment.STAGING);
  if (Platform.isAndroid) {
    AppConfig.config!.clientDevice = Device.ANDROID.toString();
  } else {
    AppConfig.config!.clientDevice = Device.IOS.toString();
  }
}