import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/drawer.dart';
import 'package:homeautomation/elements/toppad.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/pages/home.dart';
import 'package:homeautomation/pages/myrooms.dart';
import 'package:homeautomation/pages/userspage.dart';

class MainPage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<MainPage>{
  int curPage = home;
  Widget body = Container();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();
    setPage(myRooms);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(curPage: curPage, setPage: setPage,),
      body: Column(
        children: [
          TopPad(),
          Container(
            padding: all20,
            // decoration: testDec,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    scaffoldKey.currentState!.openDrawer();
                  },
                  child: Image.asset(
                    'assets/img/menu2.png',
                    width: MediaQuery.of(context).size.width * 0.06,
                    color: primaryColor,
                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed('/Profile');
                  },
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: MediaQuery.of(context).size.width * 0.08,
                    child: Image.asset(
                      'assets/img/user.png',
                      width: MediaQuery.of(context).size.width * 0.09,
                      color: secondColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          body,
        ],
      )
    );
  }

  void setPage(int page){
    curPage = page;
    if(curPage == home){
      body = HomePage();
    }else if(curPage == profile){

    }else if(curPage == myRooms){
      body = MyRoomsPage();
    }else if(curPage == users){
      body = UsersPage();
    }
    setState(() {

    });
  }
}