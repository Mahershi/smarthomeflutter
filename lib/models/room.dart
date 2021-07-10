class Room{
  late String id;
  late String name;

  Room.fromJson(jsonMap){
    try{
      id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
      name = jsonMap['name'] ?? "Unnamed Room";
    }catch(e){
      print("Exception(" + this.runtimeType.toString() + " ): " + e.toString());
    }
  }

  toMap(){
    Map<String, dynamic> m = {};
    m['id'] = id;
    m['name'] = name;
    return m;
  }
}