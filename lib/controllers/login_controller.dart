import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_signin/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';

User? googleUser;

class LoginController extends ControllerMVC{
  // factory LoginController() {
  //   print("Factory called");
  //   //private constructor called if first time
  //   if (_this == null) _this = LoginController._();
  //   return _this!;
  // }
  // static LoginController? _this;
  //
  // //private constructor
  // LoginController._();
  //
  // /// Allow for easy access to 'the Controller' throughout the application.
  // static LoginController get con => _this!;

  Future<void> login() async{
    googleUser = await MyGoogleSignin.googleSignInProcess();
    print(googleUser!.email);
  }
}