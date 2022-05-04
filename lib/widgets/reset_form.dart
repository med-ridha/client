import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:juridoc/module/FireBaseModule.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/module/service.dart';
import 'package:juridoc/screens/home.dart';
import 'package:juridoc/screens/welcome/login.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/widgets/primary_button.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:http/http.dart' as http;

class ResetForm extends StatefulWidget {
  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> with TickerProviderStateMixin {
  String verifyEmailURL = Service.url+'checkEmail'; 
  String checkTokenURL = Service.url+'checkToken'; 
  String newPasswordURL = Service.url+'newPassword'; 

  int etap = 0;
  String? _email;
  String? _password;
  String? _confirmPassword;
  String? _token;
  bool _emailIsError = false;
  bool _passwordIsError = false;
  bool _confirmPIsError = false;
  bool _tokenIsError = false;
  bool _isObscure = true;
  bool login = true;

  bool waiting = false;

  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _tokenFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPFNode;

  late FocusNode _tokenFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPFNode = FocusNode();
    _tokenFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPFNode.dispose();
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

  Widget _buildConfirmPassword() {
    return TextFormField(
      focusNode: _confirmPFNode,
      obscureText: _isObscure,
      decoration: InputDecoration(
          icon: Icon(Icons.password_sharp),
          hintText: "confirmer mot de passe",
          border: InputBorder.none,
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
      onChanged: (String? value) {
        _confirmPassword = value;
        if (_confirmPassword == _password) {
          setState(() {
            _confirmPIsError = false;
          });
        }
      },
      onSaved: (String? value) {
        _confirmPassword = value;
      },
    );
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
                      };
                      var result = await http.post(
                        Uri.parse(verifyEmailURL),
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
          _token = value!.trim();
        },
        onChanged: (String? value) {
          setState(() {
            _tokenIsError = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> sendEmail() async {
      FocusManager.instance.primaryFocus?.unfocus();

      _emailFormKey.currentState!.save();

      if (!validateEmail(_email!)) return;

      Map<String, String?> data = {
        "email": _email,
      };

      setState(() {
        waiting = true;
      });

      var result = await http.post(
        Uri.parse(verifyEmailURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      setState(() {
        waiting = false;
      });

      if (result.statusCode == 401) {
        showError("Email inexistant");
        setState(() {
          _emailIsError = true;
        });
      } else if (result.statusCode == 200) {
        setState(() {
          etap = 1;
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) => _buildErrorPopupDialog(
                context,
                "internal server error",
                "something went wrong in the server side please try again later"));
      }
    }

    Future<void> checkToken() async {
      FocusManager.instance.primaryFocus?.unfocus();

      _tokenFormKey.currentState!.save();

      if (!validateToken(_token!)) return;

      Map<String, String?> data = {
        "email": _email,
        "token": _token,
      };

      setState(() {
        waiting = true;
      });

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
        setState(() {
          etap = 2;
        });
      } else if (tokenResult.statusCode == 400) {
        showError("Votre code de confirmation est invalide");
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
    }

    Future<void> newPassword() async {
      FocusManager.instance.primaryFocus?.unfocus();
      _passwordFormKey.currentState!.save();
      if (!validatePassword(_password!) ||
          !validateConfirmP(_confirmPassword!, _password)) return;

      Map<String, String?> data = {"email": _email, "newPassword": _password};

      setState(() {
        waiting = true;
      });

      var tokenResult = await http.post(
        Uri.parse(newPasswordURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      setState(() {
        waiting = false;
      });

      if (tokenResult.statusCode == 200) {
        showSimpleNotification(Text("Password updated!"),
            background: Colors.green);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => LogInScreen()),
              ModalRoute.withName('/loginscreen'));
        });
      } else if (tokenResult.statusCode == 400) {
        showError("invalid token");
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
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Form getForm() {
      switch (etap) {
        case 0:
          return Form(
              key: _emailFormKey,
              child: Container(
                height: height * 0.30,
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
                      SizedBox(height: height * 0.05),
                      RoundedTextFieldContainer(
                          child: _buildEmail(), error: _emailIsError),
                    ],
                  ),
                ),
              ));
        case 1:
          return Form(
              key: _tokenFormKey,
              child: Container(
                height: height * 0.30,
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
                      SizedBox(height: height * 0.05),
                      RoundedTextFieldContainer(
                          child: _buildToken(), error: _tokenIsError),
                    ],
                  ),
                ),
              ));

        case 2:
          return Form(
              key: _passwordFormKey,
              child: Container(
                height: height * 0.30,
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
                      SizedBox(height: height * 0.05),
                      RoundedTextFieldContainer(
                          child: _buildPassword(), error: _passwordIsError),
                      SizedBox(height: 15),
                      RoundedTextFieldContainer(
                          child: _buildConfirmPassword(),
                          error: _confirmPIsError),
                      SizedBox(height: 25),
                    ],
                  ),
                ),
              ));

        default:
          setState(() {
            etap = 0;
          });
          return Form(child: Column());
      }
    }

    int n = etap + 1;
    return Container(
        height: height * 0.5,
        child: Column(
          children: [
            getForm(),
            SizedBox(height: 20),
            GestureDetector(
              child: PrimaryButton(
                func: (etap == 0)
                    ? sendEmail
                    : (etap == 1)
                        ? checkToken
                        : (etap == 2)
                            ? newPassword
                            : null,
                buttonText: (etap == 0) ? 'Valider email':
                            (etap == 1) ? 'Valider token':
                            'Réinitialiser' 


                //(etap <= 1) ? 'Suivant ($n / 3)' : 'Submit',
              ),
            ),
            SizedBox(height: /*10*/ height * 0.03),
            Container(
                decoration: BoxDecoration(
                  color: kTextFieldColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: (etap > 0)
                    ? IconButton(
                        splashColor: Colors.red,
                        splashRadius: 30,
                        iconSize: 30,
                        onPressed: () {
                          setState(() {
                            etap--;
                          });
                        },
                        icon: Icon(Icons.arrow_back_ios_sharp))
                    : SizedBox(height: height * 0.0435)),
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
      _passwordFocusNode.requestFocus();
      setState(() {
        _passwordIsError = true;
      });
      return false;
    }
    if (password.length < 8) {
      _passwordFocusNode.requestFocus();
      showError("password should be atleast 8 characters long");
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

  bool validateConfirmP(String password, confirmPassword) {
    if (password.isEmpty) {
      _confirmPFNode.requestFocus();
      setState(() {
        _confirmPIsError = true;
      });
      return false;
    }
    if (password != confirmPassword) {
      _confirmPFNode.requestFocus();
      showError("password doesn't match");
      setState(() {
        _confirmPIsError = true;
      });
      return false;
    }
    setState(() {
      _confirmPIsError = false;
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
