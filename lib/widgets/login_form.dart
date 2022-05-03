import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:juridoc/firebase/services/notifications.dart' as notif;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:juridoc/module/FireBaseModule.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/module/service.dart';
import 'package:juridoc/screens/home.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/widgets/primary_button.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:http/http.dart' as http;

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> with TickerProviderStateMixin {
  String loginUrl = Service.url + 'login';
  String checkTokenURL = Service.url + 'checkToken';

  String? _email;
  String? _password;
  String? _token;
  bool _emailIsError = false;
  bool _passwordIsError = false;
  bool _tokenIsError = false;
  bool _isObscure = true;
  bool login = true;

  bool waiting = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _tokenformKey = GlobalKey<FormState>();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _tokenFocusNode;

  OutlineInputBorder border(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide(
          color: color,
        ));
  }

  void showErrorSlide(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent,
        autoDismiss: false,
        slideDismissDirection: DismissDirection.horizontal);
  }

  Future<void> checkConnection() async {
    try {
      await http.post(
        Uri.parse(Service.url + "/checkStatus"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } on SocketException catch (e) {
      if (e.osError!.errorCode == 101) {
        showErrorSlide(
            "network is unreachable, please make sure you are connected to the internet");
      }
      if (e.osError!.errorCode == 111) {
        showErrorSlide("connection refused, couldn't reach the server");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkConnection();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _tokenFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _tokenFocusNode.dispose();
    super.dispose();
  }

  Widget _buildPassword() {
    return TextFormField(
        obscureText: _isObscure,
        focusNode: _passwordFocusNode,
        decoration: InputDecoration(
            icon: Icon(Icons.password_sharp),
            border: InputBorder.none,
            errorStyle: TextStyle(fontSize: 16.0),
            hintText: "mot de passe",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: _isObscure
                  ? Icon(
                      Icons.visibility_off,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.visibility,
                      color: kPrimaryColor,
                    ),
            )),
        onSaved: (String? value) {
          _password = value;
        },
        onChanged: (String? value) {
          if (value!.length >= 8) {
            setState(() {
              _passwordIsError = false;
            });
          }
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
          return null;
        }
      },
      onSaved: (String? value) {
        _email = value!.trim();
      },
    );
  }

  bool isIcon = true;
  Widget _buildToken() {
    Icon tokenIcon = Icon(Icons.refresh, size: 35);
    return TextFormField(
        focusNode: _tokenFocusNode,
        decoration: InputDecoration(
            icon: Icon(Icons.key_sharp),
            hintText: 'Token',
            border: InputBorder.none,
            suffixIcon: isIcon
                ? IconButton(
                    onPressed: () async {
                      setState(() {
                        waiting = true;
                        isIcon = false;
                      });
                      Map<String, String?> data = {
                        "email": _email,
                        "password": _password,
                      };
                      var result = await http.post(
                        Uri.parse(loginUrl),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(data),
                      );
                      if (result.statusCode == 200) {
                        showSimpleNotification(
                            Text("Sent!", style: TextStyle()),
                            duration: Duration(seconds: 3),
                            foreground: Colors.white,
                            background: Colors.greenAccent);
                      } else {
                        print(result.body);
                        showError("something went wrong!");
                      }
                      setState(() {
                        waiting = false;
                        isIcon = true;
                      });
                    },
                    icon: tokenIcon)
                : null),
        onSaved: (String? value) {
          _token = value;
        },
        onChanged: (String? value) {
          setState(() {
            _tokenIsError = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> checkToken() async {
      FocusManager.instance.primaryFocus?.unfocus();
      _tokenformKey.currentState!.save();
      if (!validateToken(_token!)) return;

      String? firebasetoken = await FirebaseModule.getFireBaseId();

      Map<String, String?> data = {
        "email": _email,
        "token": _token,
        "notifId": firebasetoken
      };
      setState(() {
        waiting = true;
      });
      try {
        var tokenResult = await http.post(
          Uri.parse(checkTokenURL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );
        setState(() {
          waiting = false;
        });
        if (tokenResult.statusCode == 200) {
          final user = userModuleFromJson(tokenResult.body);
          await UserPrefs.clear();
          await UserPrefs.save(user);
          //await notif.Notification().initState();
          await FirebaseMessaging.instance.subscribeToTopic("new");
          await UserPrefs.setIsLogedIn(true);
          await UserModule.getModules();
          showSimpleNotification(Text("welcome", style: TextStyle()),
              duration: Duration(seconds: 3),
              foreground: Colors.white,
              background: Colors.greenAccent);
          await Future.delayed(Duration(seconds: 2), () {
            Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => HomeScreen(0)),
                ModalRoute.withName('/homescreen'));
          });
        } else if (tokenResult.statusCode == 400) {
          showError("Votre code de confirmation de session est invalide");
          setState(() {
            _tokenIsError = true;
          });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) => _buildErrorPopupDialog(
                  context,
                  "internal server error",
                  "something went wrong in the server side please try again later"));
        }
      } on SocketException catch (e) {
        if (e.osError!.errorCode == 101) {
          showErrorSlide(
              "network is unreachable, please make sure you are connected to the internet");
        }
        if (e.osError!.errorCode == 111) {
          showErrorSlide("connection refused, couldn't reach the server");
        }
      }
    }

    Future<void> sendLogin() async {
      FocusManager.instance.primaryFocus?.unfocus();
      _formKey.currentState!.save();
      if (!validateEmail(_email!) || !validatePassword(_password!)) return;

      print(_email);
      print(_password);

      Map<String, String?> data = {
        "email": _email,
        "password": _password,
      };

      setState(() {
        waiting = true;
      });
      try {
        var result = await http.post(
          Uri.parse(loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );

        setState(() {
          waiting = false;
        });

        if (result.statusCode == 200) {
          if (login) {
            setState(() {
              login = false;
            });
          }
        } else if (result.statusCode == 401) {
          showError("Veuller verifier vos identifiants");
          _emailFocusNode.requestFocus();
          setState(() {
            _emailIsError = true;
          });
        } else if (result.statusCode == 402) {
          showError("Veuller verifier vos identifiants");
          _passwordFocusNode.requestFocus();
          setState(() {
            _passwordIsError = true;
          });
        } else {
          print(result.body);
          showDialog(
              context: context,
              builder: (BuildContext context) => _buildErrorPopupDialog(
                  context,
                  "internal server error",
                  "something went wrong in the server side please try again later"));
        }
      } on SocketException catch (e) {
        if (e.osError!.errorCode == 101) {
          showErrorSlide(
              "network is unreachable, please make sure you are connected to the internet");
        }
        if (e.osError!.errorCode == 111) {
          showErrorSlide("connection refused, couldn't reach the server");
        }
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Form getFormList() {
      if (login) {
        return Form(
            key: _formKey,
            child: Container(
              //height: height * 0.25,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.01),
                    Container(
                        height: height * 0.05,
                        child: (waiting)
                            ? SpinKitDualRing(size: 40, color: Colors.green)
                            : null),

                    //SizedBox(height: 40),
                    SizedBox(height: height * 0.05),
                    RoundedTextFieldContainer(
                        child: _buildEmail(), error: _emailIsError),
                    SizedBox(height: 20),
                    RoundedTextFieldContainer(
                        child: _buildPassword(), error: _passwordIsError),
                    //SizedBox(height: 40),
                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
            ));
      } else {
        return Form(
            key: _tokenformKey,
            child: Container(
              //height: height * 0.25,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: height * 0.05,
                        child: (waiting)
                            ? SpinKitDualRing(size: 40, color: Colors.green)
                            : null),
                    //SizedBox(height: 90),
                    SizedBox(height: height * 0.11),
                    RoundedTextFieldContainer(
                        child: _buildToken(), error: _tokenIsError),
                    //SizedBox(height: 40),
                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
            ));
      }
    }

    return Container(
        height: height * 0.5,
        child: Column(
          children: [
            getFormList(),
            SizedBox(height: 20),
            GestureDetector(
              child: PrimaryButton(
                func: (login) ? sendLogin : checkToken,
                buttonText: (login) ? 'Connexion' : 'Verify',
              ),
            ),
            SizedBox(height: /*10*/ height * 0.05),
            Container(
                decoration: BoxDecoration(
                  color: kTextFieldColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: (!login)
                    ? IconButton(
                        splashColor: Colors.red,
                        splashRadius: 30,
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            login = !login;
                          });
                        },
                        icon: Icon(Icons.arrow_back_ios_sharp))
                    : null),
          ],
        ));
  }

  Widget _buildErrorPopupDialog(
      BuildContext context, String title, String message) {
    return new AlertDialog(
        title: Text(title),
        backgroundColor: Colors.red,
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(message),
          ],
        ),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          )
        ]);
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      showError("Veuiller remplir les champs");
      _passwordFocusNode.requestFocus();
      setState(() {
        _passwordIsError = true;
      });
      return false;
    }
    if (password.length < 8) {
      _passwordFocusNode.requestFocus();
      showError("Mot de passe doit etre 8 characters ");
      setState(() {
        _passwordIsError = true;
      });
      return false;
    }
    return true;
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      _emailFocusNode.requestFocus();
      showError("Veuiller remplir les champs");
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

  bool validateToken(String token) {
    if (token.isEmpty) {
      _tokenFocusNode.requestFocus();
      setState(() {
        _tokenIsError = true;
      });
      return false;
    }
    setState(() {
      _tokenIsError = false;
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
