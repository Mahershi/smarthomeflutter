import 'package:flutter/widgets.dart';

enum Environment { DEVELOPMENT, STAGING, PRODUCTION }
enum Device { IOS, ANDROID }

class Config {
  String environment;
  String baseUrl;
  String directUrl;
  String clientId;
  String clientSecret;
  String clientDevice;
  String token;

  Config({
    required this.environment,
    required this.baseUrl,
    required this.directUrl,
    required this.clientId,
    required this.clientSecret,
    required this.clientDevice,
    required this.token,
  });


}

class AppConfig {
  static Config? config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEVELOPMENT:
        config = _Config.development;
        break;
      case Environment.STAGING:
        config = _Config.staging;
        break;
      case Environment.PRODUCTION:
        config = _Config.production;
        break;
    }
  }
}

class _Config {

  static const version = "1.0.0";
  static const api = 'app/';
  static const baseUrl = "http://192.168.1.200:8000/";
  static const directUrl = "http://192.168.1.200:8000/";

  static Config development = Config(
    environment: 'development',
    baseUrl: '$baseUrl$api',
    directUrl: '$baseUrl$api',
    clientId: '',
    clientSecret: '',
    clientDevice: '',
    token: '',
  );

  static Config staging = Config(
    environment: 'staging',
    baseUrl: '$baseUrl$api',
    directUrl: '$baseUrl$api',
    clientId: '',
    clientSecret: '',
    clientDevice: '',
    token: '',
  );

  static Config production = Config(
    environment: 'production',
    baseUrl: '$baseUrl$api',
    directUrl: '$baseUrl$api',
    clientId: '',
    clientSecret: '',
    clientDevice: '',
    token: '',
  );
}
