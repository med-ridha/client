import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/service.dart';
import 'package:juridoc/screens/home.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/passwordIcon.dart';
import 'package:juridoc/widgets/primary_button.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:juridoc/widgets/secondary_button.dart';
import 'package:overlay_support/overlay_support.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String updateURL = Service.url + 'updateUser';

  String? _name;
  bool _nameIsError = false;
  late FocusNode _nameFocusNode;
  String? _surname;
  bool _surnameIsError = false;
  late FocusNode _surnameFocusNode;
  String? _phoneNumber;
  bool _phoneNumberIsError = false;
  late FocusNode _phoneNumberFocusNode;

  String? _nomStructure;
  bool _nomSIsError = false;
  late FocusNode _nomSFocusNode;
  String? _phoneStructure;
  bool _phoneSIsError = false;
  late FocusNode _phoneSFocusNode;
  String? _adressStructure;
  bool _adressSIsError = false;
  late FocusNode _adressSFocusNode;
  String? _numFiscal;
  bool _numFIsError = false;
  late FocusNode _numFFocusNode;

  String? _password;
  bool _passwordIsError = false;
  late FocusNode _passwordFNode;

  String? _newPassword;
  bool _newPasswordIsError = false;
  late FocusNode _newPasswordFNode;

  String? _confirmPassword;
  bool _confirmPIsError = false;
  late FocusNode _confirmPFNode;

  bool waiting = false;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _name = UserPrefs.getName() ?? '';
    _surname = UserPrefs.getSurname() ?? '';
    _phoneNumber = UserPrefs.getPhoneNumber() ?? '';
    _nomStructure = UserPrefs.getNomStructure() ?? '';
    _phoneStructure = UserPrefs.getPhoneStructure() ?? '';
    _adressStructure = UserPrefs.getAdressStructure() ?? '';
    _numFiscal = UserPrefs.getNumFiscal() ?? '';
    _nameFocusNode = FocusNode();
    _surnameFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _nomSFocusNode = FocusNode();
    _phoneSFocusNode = FocusNode();
    _adressSFocusNode = FocusNode();
    _numFFocusNode = FocusNode();
    _passwordFNode = FocusNode();
    _newPasswordFNode = FocusNode();
    _confirmPFNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _surnameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _nomSFocusNode.dispose();
    _phoneSFocusNode.dispose();
    _adressSFocusNode.dispose();
    _numFFocusNode.dispose();
    _passwordFNode.dispose();
    _newPasswordFNode.dispose();
    _confirmPFNode.dispose();
    super.dispose();
  }

  Widget _buildName() {
    return TextFormField(
        focusNode: _nameFocusNode,
        initialValue: _name,
        decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Prénom',
            border: InputBorder.none),
        onSaved: (String? value) {
          _name = value;
        },
        onFieldSubmitted: (String? value) {
          _surnameFocusNode.requestFocus();
        },
        onChanged: (String? value) {
          setState(() {
            _nameIsError = false;
          });
        });
  }

  Widget _buildSurname() {
    return TextFormField(
        focusNode: _surnameFocusNode,
        initialValue: _surname,
        decoration: InputDecoration(
            icon: Icon(Icons.people),
            hintText: 'Nom de famille',
            border: InputBorder.none),
        onSaved: (String? value) {
          _surname = value;
        },
        onFieldSubmitted: (String? value) {
          _phoneNumberFocusNode.requestFocus();
        },
        onChanged: (String? value) {
          setState(() {
            _surnameIsError = false;
          });
        });
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
        focusNode: _phoneNumberFocusNode,
        keyboardType: TextInputType.phone,
        initialValue: _phoneNumber,
        decoration: InputDecoration(
            icon: Icon(Icons.phone),
            hintText: 'Numéro de téléphone',
            border: InputBorder.none),
        onSaved: (String? value) {
          _phoneNumber = value;
        },
        onChanged: (String? value) {
          bool com = false;
          List<String> args = value!.split('');
          for (int i = 0; i < args.length; i++) {
            try {
              double.parse(args[i]);
              com = true;
            } catch (error) {
              com = false;
            }
          }
          if (value.length < 8) com = false;
          if (com) {
            setState(() {
              _phoneNumberIsError = false;
            });
          }
        });
  }

  Widget _buildNomStructure() {
    return TextFormField(
        focusNode: _nomSFocusNode,
        initialValue: _nomStructure,
        decoration: InputDecoration(
            icon: Icon(Icons.other_houses),
            border: InputBorder.none,
            hintText: 'Nom de votre structure'),
        onSaved: (String? value) {
          _nomStructure = value;
        },
        onFieldSubmitted: (String? value) {
          _phoneSFocusNode.requestFocus();
        },
        onChanged: (String? value) {
          setState(() {
            _nomSIsError = false;
          });
        });
  }

  Widget _buildPhoneStructure() {
    return TextFormField(
        focusNode: _phoneSFocusNode,
        initialValue: _phoneStructure,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            icon: Icon(Icons.contact_phone),
            border: InputBorder.none,
            hintText: 'Téléphone de votre structure'),
        onSaved: (String? value) {
          _phoneStructure = value;
        },
        onFieldSubmitted: (String? value) {
          _adressSFocusNode.requestFocus();
        },
        onChanged: (String? value) {
          bool com = false;
          List<String> args = value!.split('');
          for (int i = 0; i < args.length; i++) {
            try {
              double.parse(args[i]);
              com = true;
            } catch (error) {
              com = false;
            }
          }
          if (value.length < 8) com = false;
          if (com) {
            setState(() {
              _phoneSIsError = false;
            });
          }
        });
  }

  Widget _buildAdressStructure() {
    return TextFormField(
        focusNode: _adressSFocusNode,
        initialValue: _adressStructure,
        decoration: InputDecoration(
            icon: Icon(Icons.navigation),
            border: InputBorder.none,
            hintText: 'Adresse de votre structure'),
        onSaved: (String? value) {
          _adressStructure = value;
        },
        onFieldSubmitted: (String? value) {
          _numFFocusNode.requestFocus();
        },
        onChanged: (String? value) {
          setState(() {
            _adressSIsError = false;
          });
        });
  }

  Widget _buildNumFiscal() {
    return TextFormField(
        focusNode: _numFFocusNode,
        initialValue: _numFiscal,
        decoration: InputDecoration(
            icon: Icon(Icons.onetwothree),
            border: InputBorder.none,
            hintText: 'Numéro d identification fiscale'),
        onSaved: (String? value) {
          _numFiscal = value;
        },
        onChanged: (String? value) {
          setState(() {
            _numFIsError = false;
          });
        });
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: _isObscure,
      focusNode: _passwordFNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: Icon(Icons.password_sharp),
        hintText: "mot de passe",
      ),
      onChanged: (String? value) {
        if (value!.length >= 8) {
          setState(() {
            _passwordIsError = false;
          });
        }
        _password = value;
      },
      onFieldSubmitted: (String? value) {
        _newPasswordFNode.requestFocus();
      },
      onSaved: (String? value) {
        _password = value;
      },
    );
  }

  Widget _buildNewPassword() {
    return TextFormField(
      obscureText: _isObscure,
      focusNode: _newPasswordFNode,
      decoration: InputDecoration(
        border: InputBorder.none,
        icon: Icon(Icons.password_sharp),
        hintText: "nouveau mot de passe",
      ),
      onChanged: (String? value) {
        if (value!.length >= 8) {
          setState(() {
            _newPasswordIsError = false;
          });
        }
        _newPassword = value;
      },
      onFieldSubmitted: (String? value) {
        _confirmPFNode.requestFocus();
      },
      onSaved: (String? value) {
        _newPassword = value;
      },
    );
  }

  Widget _buildConfirmPassword() {
    return TextFormField(
      focusNode: _confirmPFNode,
      obscureText: _isObscure,
      decoration: InputDecoration(
        icon: Icon(Icons.password_sharp),
        hintText: "confirmer mot de passe",
        border: InputBorder.none,
      ),
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

  void update() async {
    _formKey.currentState!.save();

    if (!validateName(_name!) ||
        !validateSurname(_surname!) ||
        !validatePhoneNumber(_phoneNumber!)) return;

    if (!validateNomS(_nomStructure!) ||
        !validatePhoneNumber(_phoneStructure!) ||
        !validateAdressS(_adressStructure!) ||
        !validateNumF(_numFiscal!)) return;

    if (!validatePassword(_password!) ||
        !validateNewPassword(_newPassword!) ||
        !validateConfirmP(_confirmPassword!, _newPassword)) return;

    setState(() {
      waiting = true;
    });

    Map<String, String?> data = {
      "email": UserPrefs.getEmail(),
      "name": _name!.trim(),
      "surname": _surname!.trim(),
      "phoneNumber": _phoneNumber!.trim(),
      "nomStructure": _nomStructure!.trim(),
      "password": _password!,
      "newPassword": _newPassword!,
      "phoneStructure": _phoneStructure!.trim(),
      "numFiscal": _numFiscal!.trim(),
      "adressStructure": _adressStructure!.trim(),
    };

    //api call
    var result = await http.post(
      Uri.parse(updateURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    setState(() {
      waiting = false;
    });

    if (result.statusCode == 200) {
      final user = userModuleFromJson(result.body);
      await UserPrefs.save(user);
      showSimpleNotification(Text("Information updated ", style: TextStyle()),
          duration: Duration(seconds: 1),
          foreground: Colors.white,
          background: Colors.greenAccent);
      setState(() {
        _formKey.currentState!.reset();
      });

      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => HomeScreen(2)),
            ModalRoute.withName('/homescreen'));
      });
    } else if (result.statusCode == 401) {
      showError("Wrong password");
    } else {
      print(result.body);
      showDialog(
          context: context,
          builder: (BuildContext context) => _buildErrorPopupDialog(
              context,
              "internal server error",
              "something went wrong in the server side please try again later"));
    }
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double safePadding = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Stack(key: UniqueKey(), fit: StackFit.expand, children: [
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
                            child: Column(children: [
                              Container(
                                  height: 60,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: SecondBarUi("Profile", false)),
                              Container(
                                  height: height * 0.05,
                                  child: (waiting)
                                      ? SpinKitDualRing(
                                          size: 40, color: Colors.green)
                                      : null),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  title(
                                                      context,
                                                      'SVG/door-lock.svg',
                                                      "Mot de passe",
                                                      0.045),
                                                  SizedBox(width: width * 0.38),
                                                  PasswordIcon(() {
                                                    setState(() {
                                                      _isObscure = !_isObscure;
                                                    });
                                                  }),
                                                ],
                                              ),
                                              SizedBox(height: height * 0.01),
                                              RoundedTextFieldContainer(
                                                  child: _buildPassword(),
                                                  error: _passwordIsError),
                                              SizedBox(height: 15),
                                              RoundedTextFieldContainer(
                                                  child: _buildNewPassword(),
                                                  error: _newPasswordIsError),
                                              SizedBox(height: 15),
                                              RoundedTextFieldContainer(
                                                  child:
                                                      _buildConfirmPassword(),
                                                  error: _confirmPIsError),
                                              SizedBox(height: height * 0.02),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              title(
                                                  context,
                                                  'SVG/id.svg',
                                                  "Donnees personnelles",
                                                  0.045),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              RoundedTextFieldContainer(
                                                  child: _buildName(),
                                                  error: _nameIsError),
                                              SizedBox(height: 15),
                                              RoundedTextFieldContainer(
                                                  child: _buildSurname(),
                                                  error: _surnameIsError),
                                              SizedBox(height: 15),
                                              RoundedTextFieldContainer(
                                                  child: _buildPhoneNumber(),
                                                  error: _phoneNumberIsError),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              title(
                                                  context,
                                                  'SVG/case.svg',
                                                  "Donnees professionnelles",
                                                  0.035),
                                              RoundedTextFieldContainer(
                                                  child: _buildNomStructure(),
                                                  error: _nomSIsError),
                                              SizedBox(height: 15),
                                              RoundedTextFieldContainer(
                                                  child: _buildPhoneStructure(),
                                                  error: _phoneSIsError),
                                              SizedBox(height: 15),
                                              RoundedTextFieldContainer(
                                                  child:
                                                      _buildAdressStructure(),
                                                  error: _adressSIsError),
                                              SizedBox(height: 15),
                                              RoundedTextFieldContainer(
                                                  child: _buildNumFiscal(),
                                                  error: _numFIsError),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        width: width * 0.8,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: PrimaryButton(
                                                func: update,
                                                buttonText: 'Enregistrer',
                                              ),
                                            ),
                                            SizedBox(height: 20),
                                            GestureDetector(
                                              onTap: () {},
                                              child: SecondaryButton(
                                                  func: () {
                                                    _formKey.currentState!
                                                        .reset();
                                                  },
                                                  buttonText: 'Cancel',
                                                  icon: Icon(
                                                      Icons.refresh_sharp)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget title(
      BuildContext context, String image, String text, double boxWidth) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(
            image,
            height: height * 0.05,
            width: width * 0.05,
          ),
          SizedBox(
            width: width * boxWidth,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
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

  bool validateSurname(String surname) {
    if (surname.isEmpty) {
      _surnameFocusNode.requestFocus();
      setState(() {
        _surnameIsError = true;
      });
      return false;
    }
    setState(() {
      _surnameIsError = false;
    });
    return true;
  }

  bool validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      _phoneNumberFocusNode.requestFocus();
      setState(() {
        _phoneNumberIsError = true;
      });
      return false;
    }
    List<String> args = phoneNumber.split('');
    for (int i = 0; i < args.length; i++) {
      try {
        double.parse(args[i]);
      } catch (error) {
        setState(() {
          _phoneNumberIsError = true;
        });
        showError("phone number must contains only numbers");
        return false;
      }
    }
    if (phoneNumber.length != 8) {
      setState(() {
        _phoneNumberIsError = true;
      });
      showError("phone number must be 8 numbers");
      return false;
    }
    setState(() {
      _phoneNumberIsError = false;
    });

    return true;
  }

  bool validateNomS(String nomS) {
    if (nomS.isEmpty) {
      _nomSFocusNode.requestFocus();
      setState(() {
        _nomSIsError = true;
      });
      return false;
    }
    setState(() {
      _nomSIsError = false;
    });

    return true;
  }

  bool validateAdressS(String adressS) {
    if (adressS.isEmpty) {
      _adressSFocusNode.requestFocus();
      setState(() {
        _adressSIsError = true;
      });
      return false;
    }
    setState(() {
      _adressSIsError = false;
    });

    return true;
  }

  bool validateNumF(String numF) {
    if (numF.isEmpty) {
      _numFFocusNode.requestFocus();
      setState(() {
        _numFIsError = true;
      });
      return false;
    }
    setState(() {
      _numFIsError = false;
    });

    return true;
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      _passwordFNode.requestFocus();
      showError("Password is required");
      setState(() {
        _passwordIsError = true;
      });
      return false;
    }
    if (password.length < 8) {
      _passwordFNode.requestFocus();
      showError("password should be atleast 8 characters long");
      setState(() {
        _passwordIsError = true;
      });
      return false;
    }
    setState(() {
      _passwordIsError = false;
    });
    return true;
  }

  bool validateNewPassword(String newPassword) {
    if (newPassword.length >= 1 && newPassword.length < 8) {
      _newPasswordFNode.requestFocus();
      showError("Password should be atleast 8 characters long");
      setState(() {
        _newPasswordIsError = true;
      });
      return false;
    }
    setState(() {
      _newPasswordIsError = false;
    });
    return true;
  }

  bool validateConfirmP(String password, confirmPassword) {
    if (password.length >= 1 && password != confirmPassword) {
      _confirmPFNode.requestFocus();
      showError("Passwords doesn't match");
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
