import 'dart:convert';

class User{
  late String id;
  late String name;
  late String email;
  late String password;
  late String imageurl;
  late String fcmtoken;

  User();

  User.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      name = jsonMap['name'] ?? "";
      email = jsonMap['email'] ?? "";
      imageurl = jsonMap['imageurl'] ?? "";
      password = "";
      fcmtoken = jsonMap['fcmtoken'] ?? "";
    }catch(e){
      print("Exception(" + this.runtimeType.toString() + " ): " + e.toString());
    }
  }

  toMap(){
    Map<String, dynamic> m = Map<String, dynamic>();
    m['id'] = id;
    m['name'] = name;
    m['email'] = email;
    m['fcm_token'] = fcmtoken;
    m['image_url'] = imageurl;

    return m;
  }

  Map saveToSP(){
    var m = Map<String, dynamic>();
    m['id'] = id;
    m['name'] = name;
    m['email'] = email;
    m['password'] = password;
    m['fcm_token'] = fcmtoken;
    m['image_url'] = imageurl;

    return m;
  }
}