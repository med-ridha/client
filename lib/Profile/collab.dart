import 'dart:collection';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/remove_button.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:juridoc/widgets/sendButton.dart';
import 'package:overlay_support/overlay_support.dart';

class Collab extends StatefulWidget {
  @override
  CollabState createState() => CollabState();
}

class CollabState extends State<Collab> with TickerProviderStateMixin {
  // String addToCollabURL = 'http://10.0.2.2:42069/addToCollab'; emulator
  String addToCollabURL = 'http://192.168.1.11:42069/addToCollab'; // real

  bool waiting = false;
  bool emailWaiting = false;
  bool empty = false;
  bool isAdd = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;
  bool _emailIsError = false;
  Map<String, dynamic> listCollabs = HashMap();

  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    setState(() {
      waiting = true;
    });
    UserModule.getCollabs().then((res) {
      if (res.length == 0) {
        setState(() {
          empty = true;
          waiting = false;
        });
      } else {
        listCollabs = res;
      }
      setState(() {
        waiting = false;
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  Widget _buildEmail() {
    return TextFormField(
      focusNode: _emailFocusNode,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        border: InputBorder.none,
        iconColor: Colors.purple,
        errorStyle: TextStyle(fontSize: 16.0),
        hintText: 'Email',
      ),
      onChanged: (String? value) {
        if (RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value!)) {
          setState(() {
            _emailIsError = false;
          });
          return null;
        }
      },
      onSaved: (String? value) {
        _email = value!.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                    child: SecondBarUi("Mes collabarotateurs", true, func: () {
                      setState(() {
                        isAdd = !isAdd;
                      });
                    })),
                SizedBox(
                  height: 30,
                ),
                (isAdd)
                    ? Container(
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Form(
                            key: _formKey,
                            child: Container(
                              alignment: Alignment.center,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        RoundedTextFieldContainer(
                                            customWidth: width * 0.8,
                                            child: _buildEmail(),
                                            error: _emailIsError),
                                        Container(
                                            width: width * 0.1,
                                            height: width * 0.1,
                                            child: (emailWaiting)
                                                ? SpinKitDualRing(
                                                    size: 35,
                                                    color: Colors.green)
                                                : SendButton(func: addCollab)),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.01)
                                  ],
                                ),
                              ),
                            )))
                    : Container(),
                SizedBox(height: height * 0.05),
                Container(
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
                        SizedBox(height: height * 0.05),
                        Container(
                            child: (waiting)
                                ? SpinKitDualRing(size: 40, color: Colors.green)
                                : null),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: (empty)
                                ? [Text("empty")]
                                : [
                                    for (String item in listCollabs.keys)
                                      Container(
                                        child: Column(
                                          children: [
                                            collabWidget(
                                                context,
                                                listCollabs[item]["fullName"],
                                                item,
                                                listCollabs[item]
                                                    ["phoneNumber"]),
                                            SizedBox(height: height * 0.03)
                                          ],
                                        ),
                                      )
                                  ]),
                        SizedBox(height: height * 0.02)
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

  Widget collabWidget(
      BuildContext context, String name, String email, String phone) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {},
        child: Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "SVG/user.svg",
                        height: 30,
                        width: 30,
                        color: Colors.red,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      RemoveButton(func: () {})
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "SVG/mail.svg",
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "SVG/phone.svg",
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        phone,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  Future<void> addCollab() async {
    _formKey.currentState!.validate();
    if (validateEmail(_email!)) return;

    print(_email);

    setState(() {
      emailWaiting = true;
    });

    Map<String, String?> data = {
      "email": _email,
      "collabId": UserPrefs.getCollabId()
    };

    var result = await http.post(
      Uri.parse(addToCollabURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    setState(() {
      emailWaiting = false;
    });

    if (result.statusCode == 200) {
      showSimpleNotification(
          Text("User add to this collab", style: TextStyle()),
          duration: Duration(seconds: 2),
          foreground: Colors.white,
          background: Colors.greenAccent);
    } else if (result.statusCode == 405) {
      showError("User already in a collab");
    } else if (result.statusCode == 404) {
      showError("User not found!");
    } else {
      showError("Internal server error");
    }
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      _emailFocusNode.requestFocus();
      setState(() {
        _emailIsError = true;
      });
      return false;
    }
    if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(email)) {
      showError("Email adress non valid");
      setState(() {
        _emailIsError = true;
      });
      _emailFocusNode.requestFocus();
      return false;
    }
    setState(() {
      _emailIsError = false;
    });
    return true;
  }

  void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent);
  }
}
