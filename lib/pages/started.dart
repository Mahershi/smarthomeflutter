import 'package:flutter/material.dart';
import 'package:homeautomation/helpers/constants.dart';


class StartedPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, right: 20, left: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  Container(
                    child: Text(
                      "Looks like you have no Home Control added",
                      style: font.merge(TextStyle(
                          fontSize: MediaQuery.of(context).size.width * head6_5,
                          color: grey.withOpacity(0.8)
                      )),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Container(
                    child: Text(
                      "OR password may have been changed!",
                      style: font.merge(TextStyle(
                          fontSize: MediaQuery.of(context).size.width * head6_5,
                          color: grey.withOpacity(0.8)
                      )),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Text(
                      "Lets get you started!",
                      style: font.merge(TextStyle(
                          fontSize: MediaQuery.of(context).size.width * head3,
                          color: primaryColor
                      )),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: Image.asset(
                      'assets/img/homelock.png',
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Text(
                      "Add a Home Control to access your devices",
                      style: font.merge(TextStyle(
                          fontSize: MediaQuery.of(context).size.width * head5,
                          color: accentColor2
                      )),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamedAndRemoveUntil('/LoginControl', (route) => false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor
                        ),
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                        child: Icon(
                          Icons.chevron_right,
                          color: secondColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(-MediaQuery.of(context).size.width * 0.4, MediaQuery.of(context).size.height / 2),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // border: testBorder,
                  color: primaryColor
                ),
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            )
          ],
        )
    );
  }
}


