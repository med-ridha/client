import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/checkbox.dart';

class Collab extends StatefulWidget {
  @override
  CollabState createState() => CollabState();
}

class CollabState extends State<Collab> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(fit: StackFit.expand, children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(4, 9, 35, 1),
              Color.fromRGBO(39, 105, 171, 1),
            ],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
            child: Column(
              children: [
                AppBarUI(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text1()
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 400,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                       // ch1(context),
                        SizedBox(
                          height: 20,
                        ),
                       // ch2(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget Text1() {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 600),
      child: Text(
        "Mes collaborateurs",
        style: titleText5,
      ),
    );
  }

 // Widget ch1(BuildContext context) {
 //   return GestureDetector(
 //       onTap: () {},
 //       child: Container(
 //           height: 120,
 //           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
 //           decoration: BoxDecoration(
 //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
 //               color: Colors.white,
 //               boxShadow: [
 //                 BoxShadow(
 //                     color: Colors.black.withAlpha(100), blurRadius: 10.0),
 //               ]),
 //           child: Padding(
 //             padding:
 //                 const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
 //             child: Column(
 //               mainAxisAlignment: MainAxisAlignment.center,
 //               children: <Widget>[
 //                 Row(
 //                   crossAxisAlignment: CrossAxisAlignment.center,
 //                   children: <Widget>[
 //                     SvgPicture.asset(
 //                       "SVG/user.svg",
 //                       height: 30,
 //                       width: 30,
 //                       color: Colors.red,
 //                     ),
 //                     Text(
 //                       "AMAL ZITOUNI",
 //                       style: const TextStyle(
 //                           fontSize: 12, fontWeight: FontWeight.bold),
 //                     ),
 //                   ],
 //                 ),
 //                 Divider(
 //                   color: Colors.black,
 //                   height: 10,
 //                 ),
 //                 Row(
 //                   crossAxisAlignment: CrossAxisAlignment.center,
 //                   children: <Widget>[
 //                     SvgPicture.asset(
 //                       "SVG/mail.svg",
 //                       height: 30,
 //                       width: 30,
 //                     ),
 //                     Text(
 //                       "zitouni.amal97@gmail.com",
 //                       style: const TextStyle(
 //                           fontSize: 12, fontWeight: FontWeight.normal),
 //                     ),
 //                   ],
 //                 ),
 //                 Row(
 //                   crossAxisAlignment: CrossAxisAlignment.center,
 //                   children: <Widget>[
 //                     SvgPicture.asset(
 //                       "SVG/phone.svg",
 //                       height: 30,
 //                       width: 30,
 //                     ),
 //                     Text(
 //                       "55959135",
 //                       style: const TextStyle(
 //                           fontSize: 12, fontWeight: FontWeight.normal),
 //                     ),
 //                   ],
 //                 ),
 //               ],
 //             ),
 //           )));
 // }

 // Widget ch2(BuildContext context) {
 //   return GestureDetector(
 //       onTap: () {},
 //       child: Container(
 //           height: 120,
 //           margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
 //           decoration: BoxDecoration(
 //               borderRadius: BorderRadius.all(Radius.circular(20.0)),
 //               color: Colors.white,
 //               boxShadow: [
 //                 BoxShadow(
 //                     color: Colors.black.withAlpha(100), blurRadius: 10.0),
 //               ]),
 //           child: Padding(
 //             padding:
 //                 const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
 //             child: Column(
 //               mainAxisAlignment: MainAxisAlignment.center,
 //               children: <Widget>[
 //                 Row(
 //                   crossAxisAlignment: CrossAxisAlignment.center,
 //                   children: <Widget>[
 //                     SvgPicture.asset(
 //                       "SVG/user.svg",
 //                       height: 30,
 //                       width: 30,
 //                       color: Colors.green,
 //                     ),
 //                     Text(
 //                       "AMAL DAFAA",
 //                       style: const TextStyle(
 //                           fontSize: 12, fontWeight: FontWeight.bold),
 //                     ),
 //                   ],
 //                 ),
 //                 Divider(
 //                   color: Colors.black,
 //                   height: 10,
 //                 ),
 //                 Row(
 //                   crossAxisAlignment: CrossAxisAlignment.center,
 //                   children: <Widget>[
 //                     SvgPicture.asset(
 //                       "SVG/mail.svg",
 //                       height: 30,
 //                       width: 30,
 //                     ),
 //                     Text(
 //                       "amal@juridoc.tn",
 //                       style: const TextStyle(
 //                           fontSize: 12, fontWeight: FontWeight.normal),
 //                     ),
 //                   ],
 //                 ),
 //                 Row(
 //                   crossAxisAlignment: CrossAxisAlignment.center,
 //                   children: <Widget>[
 //                     SvgPicture.asset(
 //                       "SVG/phone.svg",
 //                       height: 30,
 //                       width: 30,
 //                     ),
 //                     Text(
 //                       "99138928",
 //                       style: const TextStyle(
 //                           fontSize: 12, fontWeight: FontWeight.normal),
 //                     ),
 //                   ],
 //                 ),
 //               ],
 //             ),
 //           )));
 // }
}
