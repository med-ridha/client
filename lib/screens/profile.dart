//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juridoc/Profile/edit_profile.dart';
import 'package:juridoc/Profile/achats.dart';
import 'package:juridoc/Profile/change_pwd.dart';
import 'package:juridoc/Profile/alert_juridique.dart';
import 'package:juridoc/Profile/collab.dart';
import 'package:juridoc/Profile/abonnements.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/screens/welcome/login.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String name;
  String surname;

  @override
  void initState() {
    super.initState();
    name = UserPrefs.getName();
    surname = UserPrefs.getSurname();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  height: 20,
                ),
                Container(
                  height: height * 0.25,
                  child: LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          // Positioned(
                          //   bottom: 0,
                          //   left: 0,
                          //   right: 0,
                          //   child: Container(
                          //     height: innerHeight * 0.55,
                          //     width: innerWidth,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(30),
                          //       color: Colors.white,
                          //     ),
                          //     child: Column(
                          //       children: [
                          //         SizedBox(
                          //           height: 50,
                          //         ),
                          //         Text(
                          //           "$name $surname",
                          //           style: TextStyle(
                          //             color: Color.fromRGBO(39, 105, 171, 1),
                          //             fontFamily: 'Nunito',
                          //             fontSize: (45 - "$name $surname".length)
                          //                 .toDouble(),
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: 5,
                          //         ),
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                child: Image.network(
                                  'https://avatars.dicebear.com/api/initials/$name$surname.png?r=50&scale=101&b=%23379ad7',
                                  width: innerWidth * 0.35,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "$name $surname",
                          style: TextStyle(
                            color: Color.fromRGBO(39, 105, 171, 1),
                            fontFamily: 'Nunito',
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        profile(context),
                        SizedBox(
                          height: 15,
                        ),
                        alert(context),
                        SizedBox(
                          height: 15,
                        ),
                        abonnement(context),
                        SizedBox(
                          height: 15,
                        ),
                        achat(context),
                        SizedBox(
                          height: 15,
                        ),
                        collab(context),
                        SizedBox(
                          height: 15,
                        ),
                        password(context),
                        SizedBox(
                          height: 15,
                        ),
                        logout(context),
                        SizedBox(
                          height: 15,
                        ),
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

  Widget logout(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        UserPrefs.clear().then((res) {
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => LogInScreen()),
            ModalRoute.withName('/homescreen'),
          );
        });
      },
      child: Container(
          height: height * 0.15,
          decoration: BoxDecoration(
            color: Color.fromRGBO(39, 105, 171, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'SVG/user.svg',
                  height: 100.0,
                  width: 100.0,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Log out",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget profile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => EditProfile(),
            ));
      },
      child: Container(
          height: height * 0.15,
          decoration: BoxDecoration(
            color: Color.fromRGBO(39, 105, 171, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'SVG/user.svg',
                  height: 100.0,
                  width: 100.0,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Mon Profil",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget alert(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Alert()));
      },
      child: Container(
          height: height * 0.15,
          decoration: BoxDecoration(
            color: Color.fromRGBO(39, 105, 171, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'SVG/bell.svg',
                  height: 100.0,
                  width: 100.0,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Alerte juridique",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget abonnement(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Abonnements()));
      },
      child: Container(
          height: height * 0.15,
          decoration: BoxDecoration(
            color: Color.fromRGBO(39, 105, 171, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'SVG/paper-plane.svg',
                  height: 100.0,
                  width: 100.0,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Mes abonnements",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget achat(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Achats()));
      },
      child: Container(
          height: height * 0.15,
          decoration: BoxDecoration(
            color: Color.fromRGBO(39, 105, 171, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'SVG/shopbag.svg',
                  height: 100.0,
                  width: 100.0,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Mes Achats",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget collab(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Collab()));
      },
      child: Container(
          height: height * 0.15,
          decoration: BoxDecoration(
            color: Color.fromRGBO(39, 105, 171, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'SVG/users.svg',
                  height: 100.0,
                  width: 100.0,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Mes Collaborateurs",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget password(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => ChangePwd()));
      },
      child: Container(
          height: height * 0.15,
          decoration: BoxDecoration(
            color: Color.fromRGBO(39, 105, 171, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SvgPicture.asset(
                  'SVG/lock.svg',
                  height: 100.0,
                  width: 100.0,
                  allowDrawingOutsideViewBox: true,
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Changer le",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    Text(
                      "mot de passe",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
