import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/elements/drawer.dart';
import 'package:homeautomation/elements/toppad.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/pages/home.dart';
import 'package:homeautomation/pages/myrooms.dart';
import 'package:homeautomation/pages/userspage.dart';
import 'package:homeautomation/repo/room_repo.dart' as rr;
import 'package:homeautomation/repo/user_repo.dart' as ur;

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
    setPage(home);
    rr.createIconList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryColor,
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
                    color: themeColor,
                  ),
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed('/Profile');
                  },
                  child: ur.currentUser.imageurl != '' ? Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(color: themeColor),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        ur.currentUser.imageurl,
                        width: MediaQuery.of(context).size.width * 0.16,
                      )
                    ),
                  ) :
                  CircleAvatar(
                    backgroundColor: themeColor,
                    radius: MediaQuery.of(context).size.width * 0.08,
                    child: Image.asset(
                      'assets/img/user.png',
                      width: MediaQuery.of(context).size.width * 0.09,
                      color: txtColor,
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