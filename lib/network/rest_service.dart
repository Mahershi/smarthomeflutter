import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app_config.dart';


class RestService {
  static Dio dio = Dio();
  static String baseUrl = AppConfig.config!.directUrl;

  static void init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 3000,
    ));
      // ..interceptors.add(AppInterceptors());
    print(baseUrl.toString());

    //due to handlers as a new addition in this version, dio request is not called when interceptors are added.
    // right now interceptors are not needed

    // dio.interceptors
    //     .add(InterceptorsWrapper(onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
    //   print("Request Data ${options.data}");
    //   print("RequestPath ${options.path}");
    //   print("Request QP ${options.queryParameters}");
    //   print("RequestORP ${options.onReceiveProgress}");
    // }, onResponse: (Response response, handler) async {
    //   print("Response DATA${response.data}");// continue
    // }, onError: (DioError e, errorHandler) async {
    //   print("Calling EMSG${e.message}");
    //   print("Calling ETYPE${e.type}");
    //   print("Calling ERES${e.response}");
    // }));
    print("dio init done");
  }

  static Future<void> switchToIndirect() async{
    dio.options.baseUrl = AppConfig.config!.baseUrl;
    dio.options.connectTimeout = 8000;
  }

  static Future<void> switchToDirect() async{
    dio.options.baseUrl = AppConfig.config!.directUrl;
    dio.options.connectTimeout = 3000;
  }

  static Future<dynamic> request(
      {required String endpoint,
        String method = 'GET',
        bool authRequired = false,
        Map<String, dynamic> queryParameters = const {},
        dynamic data = const {},
      bool direct = false}) async {
    try {

      String language = 'es';

      Options _cacheOptions = Options();
      _cacheOptions.method = method;
      _cacheOptions.headers = {
        'accept-language': language,
        'authrequired': authRequired
      };


      print(endpoint);
      Response<dynamic> response = await dio.request(
        '$endpoint',
        data: data,
        queryParameters: queryParameters,
        options: _cacheOptions,
      );
      var apiResponJson = response.data;
      var json = jsonDecode(response.toString());
      print(response.statusCode);
      print("RES:" + apiResponJson.toString());
      if (json['success'] == "true" || response.statusCode == 200 || response.statusCode == 201) {
        print("Success");
        return response.data;
      } else {
        print("Server Error");
        return response.data;
      }
    } on DioError catch (e) {
      String erMsg = 'Connection Error';
      String erMsg2 = '';
      if(e.response != null){
        int? i = e.response!.statusCode;
        switch(i!){
          case 401:
            erMsg = "Invalid Credentials";
            break;
          case 500:
            erMsg = "Server Error";
            break;
          default:
            erMsg = "Unknown Error";
        }
        var l = e.response!.data['error'];
        if(l is List<dynamic>){
          erMsg2 = l[0]['message'][0].toString();
        }
      }
      return {
        "success": "false",
        "error": erMsg2 == '' ? erMsg : erMsg2
      };
    } catch(e){
      return {
        "success": "false",
        "error": "Connection Error"
      };
    }
  }
}

class AppInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options, handler) async {
    options.headers.addAll({
      'x-client-id': AppConfig.config!.clientId,
      'x-client-device': AppConfig.config!.clientDevice,
    });

    if (options.headers['authrequired'] == 'true') {
      options.headers.remove("authrequired");
      options.headers.addAll({
        // 'Authorization': 'Token ' + userRepo.currentUser.authToken
      });

      return options;
    }else{
      options.headers.remove('authrequired');
    }
    print(options.headers.toString());
  }

}
