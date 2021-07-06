import 'package:flutter/cupertino.dart';

class UsersPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<UsersPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text("Users")
    );
  }
}