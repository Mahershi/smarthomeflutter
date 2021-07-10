import 'package:flutter/material.dart';
import 'package:homeautomation/custompaint/topcurve.dart';
import 'package:homeautomation/helpers/constants.dart';
import 'package:homeautomation/repo/user_repo.dart' as ur;
import 'package:homeautomation/repo/master_repo.dart' as mr;

// class LoginControl extends StatefulWidget{
//   @override
//   PageState createState() => PageState();
// }

class LoginControl extends StatelessWidget{
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: Stack(
            children: [
              Container(
                  child: CustomPaint(
                    painter: TopCurve(myColor: primaryColor),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, right: 20, left: 20, bottom: 20),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(height: 50,),
                          Container(
                            child: Text(
                              "Control Panel Login",
                              style: font.merge(TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * head3,
                                  color: secondColor
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, right: 20, left: 20, bottom: 20),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 40
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // SizedBox(height: 50,),
                        // Container(
                        //   child: Text(
                        //     "Control Panel Login",
                        //     style: font.merge(TextStyle(
                        //         fontSize: MediaQuery.of(context).size.width * head3,
                        //         color: secondColor
                        //     )),
                        //   ),
                        // ),
                        // Spacer(),
                        Container(
                          padding: all20,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: borderRadius20
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    controller: name,
                                    validator: (value){
                                      if (value == null || value.isEmpty){
                                        return "Device name required";
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style: font.merge(
                                        TextStyle(
                                            color: accentColor,
                                            letterSpacing: 1.4,
                                            fontWeight: FontWeight.w800
                                        )
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Device Name",
                                      hintStyle: font.merge(
                                          TextStyle(color: accentColor.withOpacity(0.3), letterSpacing: 1.2,)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: accentColor.withOpacity(0.3))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: accentColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: accentColor)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: TextFormField(
                                    controller: password,
                                    validator: (value){
                                      if (value == null || value.isEmpty){
                                        return "Password required";
                                      }
                                      return null;
                                    },
                                    textAlign: TextAlign.center,
                                    style: font.merge(
                                        TextStyle(
                                            color: accentColor,
                                            letterSpacing: 1.4,
                                            fontWeight: FontWeight.w800
                                        )
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: font.merge(
                                          TextStyle(color: accentColor.withOpacity(0.3), letterSpacing: 1.2,)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: accentColor.withOpacity(0.3))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: accentColor)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: borderRadius12,
                                          borderSide: BorderSide(color: accentColor)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async{
                                    print("connect");
                                    await mr.masterLogin(name.text, password.text, ur.currentUser.id).then((value){
                                      if(value){
                                        Navigator.of(context).pushNamedAndRemoveUntil('/Main', (route) => false);
                                      }

                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 20, bottom: 10),
                                    padding: all12,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: borderRadius12,
                                      color: accentColor,
                                      // border: Border.all(color: accentColor)
                                    ),
                                    child: Text(
                                      "Connect",
                                      style: font.merge(TextStyle(
                                          color: primaryColor,
                                          fontSize:
                                          MediaQuery.of(context).size.width * 0.042,
                                          letterSpacing: 1.2)),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async{
                                    await ur.logoutDevice().then((value){
                                      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
                                    });
                                  },
                                  child: Container(
                                    padding: vert10,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "Log in from another account?",
                                      style: font.merge(TextStyle(
                                          color: secondColor
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
}

// class PageState extends State<LoginControl>{
//   TextEditingController name = TextEditingController();
//   TextEditingController password = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Container(
//                 child: CustomPaint(
//                   painter: TopCurve(myColor: primaryColor),
//                   child: Container(
//                     height: MediaQuery.of(context).size.height,
//                     width: MediaQuery.of(context).size.width,
//                   ),
//                 )
//             ),
//             Container(
//               padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, right: 20, left: 20, bottom: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 50,),
//                   Container(
//                     child: Text(
//                         "Control Panel Login",
//                       style: font.merge(TextStyle(
//                           fontSize: MediaQuery.of(context).size.width * head3,
//                           color: secondColor
//                       )),
//                     ),
//                   ),
//                   Spacer(),
//                   Container(
//                     padding: all20,
//                     decoration: BoxDecoration(
//                       color: primaryColor,
//                       borderRadius: borderRadius20
//                     ),
//                     child: Form(
//                       key: formKey,
//                       child: Column(
//                         children: [
//                           Container(
//                             padding: EdgeInsets.symmetric(vertical: 10),
//                             child: TextFormField(
//                               controller: name,
//                               validator: (value){
//                                 if (value == null || value.isEmpty){
//                                   return "Device name required";
//                                 }
//                                 return null;
//                               },
//                               textAlign: TextAlign.center,
//                               style: font.merge(
//                                   TextStyle(
//                                       color: accentColor,
//                                       letterSpacing: 1.4,
//                                       fontWeight: FontWeight.w800
//                                   )
//                               ),
//                               decoration: InputDecoration(
//                                 hintText: "Device Name",
//                                 hintStyle: font.merge(
//                                     TextStyle(color: accentColor.withOpacity(0.3), letterSpacing: 1.2,)),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: accentColor.withOpacity(0.3))),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: accentColor)),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: red)),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: accentColor)),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.symmetric(vertical: 10),
//                             child: TextFormField(
//                               controller: password,
//                               validator: (value){
//                                 if (value == null || value.isEmpty){
//                                   return "Password required";
//                                 }
//                                 return null;
//                               },
//                               textAlign: TextAlign.center,
//                               style: font.merge(
//                                   TextStyle(
//                                       color: accentColor,
//                                       letterSpacing: 1.4,
//                                       fontWeight: FontWeight.w800
//                                   )
//                               ),
//                               decoration: InputDecoration(
//                                 hintText: "Password",
//                                 hintStyle: font.merge(
//                                     TextStyle(color: accentColor.withOpacity(0.3), letterSpacing: 1.2,)),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: accentColor.withOpacity(0.3))),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: accentColor)),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: red)),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                     borderRadius: borderRadius12,
//                                     borderSide: BorderSide(color: accentColor)),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: (){
//                               print("connect");
//
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               margin: EdgeInsets.only(top: 20, bottom: 10),
//                               padding: all12,
//                               width: MediaQuery.of(context).size.width,
//                               decoration: BoxDecoration(
//                                   borderRadius: borderRadius12,
//                                   color: accentColor,
//                                 // border: Border.all(color: accentColor)
//                               ),
//                               child: Text(
//                                 "Connect",
//                                 style: font.merge(TextStyle(
//                                     color: primaryColor,
//                                     fontSize:
//                                     MediaQuery.of(context).size.width * 0.042,
//                                     letterSpacing: 1.2)),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () async{
//                               await ur.logoutDevice().then((value){
//                                 Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
//                               });
//                             },
//                             child: Container(
//                               padding: vert10,
//                               alignment: Alignment.centerRight,
//                               child: Text(
//                                 "Log in from another account?",
//                                 style: font.merge(TextStyle(
//                                   color: secondColor
//                                 )),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//           ],
//         )
//       ),
//     );
//   }
// }


