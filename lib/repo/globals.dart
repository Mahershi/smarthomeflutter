import 'package:homeautomation/network/API.dart';
import 'package:homeautomation/network/rest_service.dart';

class Globals{
  static bool directConnection = false;
  static bool testConnection = false;

  static Future<bool> checkIndirectConnection() async{
    print("checking indirect con");
    await RestService.switchToIndirect();
    var res = await RestService.request(
      endpoint: API.test
    );

    if(res['success'] == 'true'){
      print("InDirect Succeed");
      testConnection = true;
      return true;
    }
    print("Indirect Fail");
    return false;
  }

  static Future<bool> checkDirectConnection() async{
    directConnection = false;
    print("checking direct con");
    await RestService.switchToDirect();
    var res = await RestService.request(
        endpoint: API.test
    );

    if(res['success'] == 'true'){
      print("Direct Succeed");
      directConnection = true;
      testConnection = true;
      return true;
    }
    print("Direct Fail");
    return false;
  }
}