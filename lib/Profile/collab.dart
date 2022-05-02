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
import 'package:juridoc/module/service.dart';
import 'package:juridoc/screens/favoris.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/widgets/addButton.dart';
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
  String addToCollabURL = Service.url + 'addToCollab'; // real

  bool waiting = false;
  bool emailWaiting = false;
  bool empty = false;
  bool isAdd = false;
  bool isCreate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;
  bool _emailIsError = false;
  String? _name;
  bool _nameIsError = false;
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  List<dynamic> listCollabs = [];
  late FocusNode _emailFocusNode;
  late FocusNode _nameFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _nameFocusNode = FocusNode();
    setState(() {
      waiting = true;
    });
    UserModule.getCollabs().then((res) {
      if (res == null || res.length == 0) {
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
    _nameFocusNode.dispose();
    super.dispose();
  }

  Widget _buildName() {
    return TextFormField(
        focusNode: _nameFocusNode,
        decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'name',
            border: InputBorder.none),
        onSaved: (String? value) {
          _name = value;
        },
        onChanged: (String? value) {
          setState(() {
            _nameIsError = false;
          });
        });
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
          _email = value.trim();
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
    double safePadding = MediaQuery.of(context).padding.top;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Stack(fit: StackFit.expand, children: [
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
                child: Column(
              children: [
                Container(
                  height: safePadding,
                  width: width,
                  decoration: BoxDecoration(color: Colors.white70, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withAlpha(100), blurRadius: 10.0),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    children: [
                      AppBarUI(),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                  height: 60,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: SecondBarUi(
                                      "Mes collabarotateurs", !empty,
                                      fontSize: 16, func: () {
                                    setState(() {
                                      isAdd = !isAdd;
                                    });
                                  },
                                      icon:
                                          (!isAdd) ? Icons.add : Icons.cancel)),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: height * 0.01),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      RoundedTextFieldContainer(
                                                          customWidth:
                                                              width * 0.8,
                                                          child: _buildEmail(),
                                                          error: _emailIsError),
                                                      Container(
                                                          width: width * 0.1,
                                                          height: width * 0.1,
                                                          child: (emailWaiting)
                                                              ? SpinKitDualRing(
                                                                  size: 35,
                                                                  color: Colors
                                                                      .green)
                                                              : SendButton(
                                                                  func:
                                                                      addCollab)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.01)
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
                                  color: Colors.grey,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: height * 0.05),
                                      Container(
                                          child: (waiting)
                                              ? SpinKitDualRing(
                                                  size: 40, color: Colors.green)
                                              : null),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: (empty)
                                              ? [
                                                  Text("La liste est vide,"),
                                                  Text(
                                                      "Veuillez creer une collaboration"),
                                                  SizedBox(height: 20),
                                                  AddButton(
                                                      func: () {
                                                        setState(() {
                                                          isCreate = !isCreate;
                                                        });
                                                      },
                                                      icon: (!isCreate)
                                                          ? Icons.add
                                                          : Icons.cancel)
                                                ]
                                              : [
                                                  for (Map<String, dynamic> item
                                                      in listCollabs)
                                                    Container(
                                                      child: Column(
                                                        children: [
                                                          collabWidget(
                                                              context,
                                                              //listCollabs[item]["fullName"],
                                                              item['fullName'],
                                                              item['email'],
                                                              item[
                                                                  'phoneNumber'],
                                                              List<String>.from(
                                                                  item['listFavored']
                                                                      .map((x) =>
                                                                          x))),
                                                          SizedBox(
                                                              height:
                                                                  height * 0.03)
                                                        ],
                                                      ),
                                                    )
                                                ]),
                                      SizedBox(height: height * 0.02),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height * 0.05),
                              (isCreate)
                                  ? Container(
                                      width: width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                      ),
                                      child: Form(
                                          key: _nameKey,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                      height: height * 0.01),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      RoundedTextFieldContainer(
                                                          customWidth:
                                                              width * 0.8,
                                                          child: _buildName(),
                                                          error: _nameIsError),
                                                      Container(
                                                          width: width * 0.1,
                                                          height: width * 0.1,
                                                          child: (emailWaiting)
                                                              ? SpinKitDualRing(
                                                                  size: 35,
                                                                  color: Colors
                                                                      .green)
                                                              : SendButton(
                                                                  func:
                                                                      createCollab)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.01)
                                                ],
                                              ),
                                            ),
                                          )))
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )))
      ]),
    );
  }

  Widget collabWidget(BuildContext context, String name, String email,
      String phone, List<String> listDocumentIds) {
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Favoris(
                                      listDocumentIds,
                                      email,
                                      name.split(" ")[0])));
                        },
                        child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              color: Colors.black,
                            ),
                            child: Icon(Icons.favorite_sharp,
                                size: 30, color: Colors.white)),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      RemoveButton(
                          email: email,
                          func: () async {
                            String text = "";
                            if (UserPrefs.getEmail() == email &&
                                UserPrefs.getIsCollabOwner()) {
                              text =
                                  "this is you, you will be removed from your own collab, are you sure?";
                            } else if (UserPrefs.getEmail() == email) {
                              text = "do you really want to leave this collab?";
                            } else {
                              text =
                                  "are you sure you want to remove this user from this collab?";
                            }
                            showAlertDialog(context, text, () async {
                              bool result =
                                  await UserModule.deleteCollab(email);
                              if (result) {
                                UserModule.getCollabs().then((res) {
                                  if (res == null || res.length == 0) {
                                    setState(() {
                                      empty = true;
                                      waiting = false;
                                    });
                                  } else {
                                    listCollabs = res;
                                  }
                                  setState(() {
                                    waiting = false;
                                    showSimpleNotification(
                                        Text(
                                            "Suppression effectuee avec success",
                                            style: TextStyle()),
                                        duration: Duration(seconds: 2),
                                        foreground: Colors.white,
                                        background: Colors.greenAccent);
                                  });
                                });
                              } else {
                                showError('something went wrong');
                              }
                            });
                          }),
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

  Future<void> createCollab() async {
    _nameKey.currentState!.validate();
    _nameKey.currentState!.save();
    if (!validateName(_name!)) {
      return;
    }

    setState(() {
      emailWaiting = true;
    });

    String email = UserPrefs.getEmail() ?? "";

    bool result = await UserModule.createCollab(email, _name!);

    setState(() {
      emailWaiting = false;
    });
    if (result) {
      showSimpleNotification(Text("collab created", style: TextStyle()),
          duration: Duration(seconds: 2),
          foreground: Colors.white,
          background: Colors.greenAccent);
      UserModule.getCollabs().then((res) {
        if (res == null || res.length == 0) {
          print(res);
          setState(() {
            empty = true;
            waiting = false;
          });
        } else {
          isCreate = false;
          empty = false;
          listCollabs = res;
        }
        setState(() {
          waiting = false;
        });
      });
    } else {
      showError("something went wrong");
    }
  }

  Future<void> addCollab() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    if (!validateEmail(_email!)) {
      return;
    }

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
          isAdd = false;
          waiting = false;
        });
      });
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

  bool validateName(String name) {
    if (name.isEmpty) {
      _nameFocusNode.requestFocus();
      setState(() {
        _nameIsError = true;
      });
      return false;
    }
    setState(() {
      _nameIsError = false;
    });
    return true;
  }

  void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent);
  }

  showAlertDialog(BuildContext context, String text, Future<void> func()) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text(text),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
                return;
              },
            ),
            TextButton(
              child: Text("Continue"),
              onPressed: () {
                func();
                Navigator.of(context).pop();
                return;
              },
            ),
          ],
        );
      },
    );
  }
}
