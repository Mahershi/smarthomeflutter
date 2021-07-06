import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/constants.dart';

class ProfilePage extends StatefulWidget{
  @override
  PageState createState() => PageState();
}

class PageState extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: MediaQuery.of(context).size.width * 0.25,
                    child: Image.asset(
                      'assets/img/user.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: secondColor,
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    child: Text(
                      "Mahershi Bhavsar",
                      style: font.merge(
                        TextStyle(
                          fontSize: MediaQuery.of(context).size.width * head2
                        )
                      ),
                    )
                  ),

                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: borderRadius20,
                ),
                  margin: EdgeInsets.all(40),
                  padding: all20,
                  child: Text(
                    "Logout",
                    style: font.merge(TextStyle(
                      color: secondColor
                    )),
                  )
              )
            ],
          )
        ),
      )
    );
  }
}