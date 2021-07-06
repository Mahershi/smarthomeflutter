import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/constants.dart';

class MyDrawer extends StatefulWidget{
  int? curPage;
  Function? setPage;
  MyDrawer({this.curPage, this.setPage});

  @override
  PageState createState() => PageState();
}

class PageState extends State<MyDrawer>{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.width * 0.16 + 40),
            height: MediaQuery.of(context).size.height,
            width: 150,
            color: primaryColor,
            child: Column(
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();

                        widget.setPage!(home);
                      },
                      child: Container(
                        padding: all10,
                        decoration: BoxDecoration(
                          borderRadius: borderRadius20,
                          color: widget.curPage == home ? secondColor : primaryColor
                        ),
                        child: Image.asset(
                          'assets/img/home.png',
                          width: MediaQuery.of(context).size.width * 0.1,
                          color: widget.curPage == home ? primaryColor : secondColor,
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Home",
                      style: font.merge(TextStyle(
                        fontWeight: FontWeight.w600,
                        color: secondColor
                      ))
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        widget.setPage!(myRooms);
                      },
                      child: Container(
                        padding: all10,
                        decoration: BoxDecoration(
                            borderRadius: borderRadius20,
                            color: widget.curPage == myRooms ? secondColor : primaryColor
                        ),
                        child: Image.asset(
                          'assets/img/myrooms.png',
                          width: MediaQuery.of(context).size.width * 0.1,
                          color: widget.curPage == myRooms ? primaryColor : secondColor,
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                        "My Rooms",
                        style: font.merge(TextStyle(
                            fontWeight: FontWeight.w600,
                            color: secondColor
                        ))
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                        widget.setPage!(users);
                      },
                      child: Container(
                        padding: all10,
                        decoration: BoxDecoration(
                            borderRadius: borderRadius20,
                            color: widget.curPage == users ? secondColor : primaryColor
                        ),
                        child: Image.asset(
                          'assets/img/users.png',
                          width: MediaQuery.of(context).size.width * 0.1,
                          color: widget.curPage == users ? primaryColor : secondColor
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                        "Users",
                        style: font.merge(TextStyle(
                            fontWeight: FontWeight.w600,
                            color: secondColor
                        ))
                    )
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(MediaQuery.of(context).size.width * 0.08, MediaQuery.of(context).size.width * 0.08),
            child: Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  // alignment: Alignment.topRight,
                  padding: all10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: secondColor
                  ),
                  width: MediaQuery.of(context).size.width * 0.16,
                  height: MediaQuery.of(context).size.width * 0.16,
                  child: Icon(
                    Icons.chevron_left,
                    size: MediaQuery.of(context).size.width * 0.08,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}