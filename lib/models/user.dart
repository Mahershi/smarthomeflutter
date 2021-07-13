import 'dart:convert';

class User{
  late String id;
  late String name;
  late String email;
  late bool restricted;
  late bool admin;
  late bool loggedin;
  late String imageurl;
  late String fcmtoken;
  late String master_id;

  User();

  User.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : '';
      name = jsonMap['name'] ?? "";
      email = jsonMap['email'] ?? "";
      imageurl = jsonMap['image_url'] ?? "";
      fcmtoken = jsonMap['fcmtoken'] ?? "";
      restricted = jsonMap['restricted'] ?? false;
      admin = jsonMap['admin'] ?? false;
      loggedin = jsonMap['loggedin'] ?? false;
      master_id = jsonMap['master'] != null ? jsonMap['master'].toString() : "";
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
    m['admin'] = admin;
    m['restricted'] = restricted;
    m['loggedin'] = loggedin;
    m['master'] = master_id;

    return m;
  }

  Map saveToSP(){
    var m = Map<String, dynamic>();
    m['id'] = id;
    m['name'] = name;
    m['email'] = email;
    m['fcm_token'] = fcmtoken;
    m['image_url'] = imageurl;

    m['admin'] = admin;
    m['restricted'] = restricted;
    m['loggedin'] = loggedin;
    m['master'] = master_id;
    return m;
  }
}