import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/screens/Cart.dart';
import 'package:juridoc/screens/home.dart';
import 'package:juridoc/screens/modules.dart';
import 'package:juridoc/screens/favoris.dart';
import 'package:juridoc/screens/profile.dart';

class AppBarUI extends StatefulWidget {
  AppBarState createState() => AppBarState();
}

class AppBarState extends State<AppBarUI> {
  String name = UserPrefs.getName() ?? '';
  String surname = UserPrefs.getSurname() ?? '';

  @override
  build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Container(
          height: 50,
          width: width,
          decoration: BoxDecoration(
              //borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
              ]),
          child: Row(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeScreen(0)));
                  },
                  child: Image.asset('images/Logo.png'),
                )
              ],
            ),
            SizedBox(width: width - 350),
            Row(children: [rightSideButtons(context)]),
          ])),
    );
  }

  Widget rightSideButtons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        SizedBox.fromSize(
          size: Size(40, 40), // button width and height
          child: ClipOval(
            child: Material(
              color: Color(0xFF00a3af),
              // button color
              child: InkWell(
                splashColor: Color(0xFF3f407a), // splash color
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Cart()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SvgPicture.asset(
                      'SVG/cart.svg',
                      height: 30.0,
                      width: 30.0,
                      color: Colors.white,
                      allowDrawingOutsideViewBox: true,
                    ),
                    // icon
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // give it width
        SizedBox.fromSize(
          size: Size(40, 40), // button width and height
          child: ClipOval(
            child: Material(
              color: Color(0xFF00a3af),
              // button color
              child: InkWell(
                splashColor: Color(0xFF3f407a), // splash color
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Modules()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SvgPicture.asset(
                      'SVG/bell.svg',
                      height: 30.0,
                      width: 30.0,
                      color: Colors.white,
                      allowDrawingOutsideViewBox: true,
                    ),
                    // icon
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // give it width
        SizedBox.fromSize(
          size: Size(40, 40), // button width and height
          child: ClipOval(
            child: Material(
              color: Color(0xFF00a3af),
              // button color
              child: InkWell(
                splashColor: Color(0xFF3f407a), // splash color
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Favoris(
                              UserPrefs.getListFavorit(),
                              UserPrefs.getEmail() ?? '',
                              UserPrefs.getName() ?? '')));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new SvgPicture.asset(
                      'SVG/like.svg',
                      height: 30.0,
                      width: 30.0,
                      color: Colors.white,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10), // give it width
        SizedBox.fromSize(
          size: Size(40, 40), // button width and height
          child: ClipOval(
            child: Material(
              color: Color(0xFF00a3af),
              // button color
              child: InkWell(
                splashColor: Color(0xFF3f407a), // splash color
                onTap: () {
                  print(ModalRoute.of(context)!.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen(2)));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.network(
                      'https://avatars.dicebear.com/api/initials/$name%20$surname.png?r=50&scale=101&b=%23379ad7',
                      height: 30.0,
                      width: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
