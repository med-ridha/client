import 'dart:convert';
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
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String verifyEmailURL = Service.url+'verifyEmail'; // real
  String createUserURL = Service.url+'createUser'; // real

  int etap = 0;
  final GlobalKey<FormState> _etap0FormKey = GlobalKey<FormState>();
  String? _name;
  bool _nameIsError = false;
  late FocusNode _nameFocusNode;
  String? _surname;
  bool _surnameIsError = false;
  late FocusNode _surnameFocusNode;
  String? _phoneNumber;
  bool _phoneNumberIsError = false;
  late FocusNode _phoneNumberFocusNode;

  final GlobalKey<FormState> _etap1FormKey = GlobalKey<FormState>();
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

  final GlobalKey<FormState> _etap2FormKey = GlobalKey<FormState>();
  String? _email;
  bool _emailIsError = false;
  late FocusNode _emailFNode;
  String? _password;
  bool _passwordIsError = false;
  late FocusNode _passwordFNode;
  String? _confirmPassword;
  bool _confirmPIsError = false;
  late FocusNode _confirmPFNode;
  bool _termsandconditions = false;
  bool _termsIsError = false;

  final GlobalKey<FormState> _etap3FormKey = GlobalKey<FormState>();
  String? _token;
  bool _tokenIsError = false;
  late FocusNode _tokenFocusNode;
  bool waiting = false;
  bool _isObscure = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _surnameFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _nomSFocusNode = FocusNode();
    _phoneSFocusNode = FocusNode();
    _adressSFocusNode = FocusNode();
    _numFFocusNode = FocusNode();
    _emailFNode = FocusNode();
    _passwordFNode = FocusNode();
    _confirmPFNode = FocusNode();
    _tokenFocusNode = FocusNode();
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
    _emailFNode.dispose();
    _passwordFNode.dispose();
    _confirmPFNode.dispose();
    _tokenFocusNode.dispose();
    super.dispose();
  }

  void etap0() {
    _etap0FormKey.currentState!.save();
    if (!validateName(_name!) ||
        !validateSurname(_surname!) ||
        !validatePhoneNumber(_phoneNumber!)) return;
    setState(() {
      etap = 1;
    });
  }

  void etap1() {
    _etap1FormKey.currentState!.save();
    if (!validateNomS(_nomStructure!) ||
        !validatePhoneNumber(_phoneStructure!) ||
        !validateAdressS(_adressStructure!) ||
        !validateNumF(_numFiscal!)) return;
    setState(() {
      etap = 2;
    });
  }

  Future<void> verifyEmail() async {
    Map<String, String?> data = {
      "email": _email!.trim(),
    };

    //api call
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
    if (result.statusCode == 200) {
      setState(() {
        etap = 3;
      });
      return;
    } else if (result.statusCode == 401) {
      showError("email already in use");
      return;
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

  Future<void> etap2() async {
    _etap2FormKey.currentState!.save();
    if (!validateEmail(_email!) ||
        !validatePassword(_password!) ||
        !validateConfirmP(_confirmPassword!, _password) ||
        !validateTerms()) return;
    setState(() {
      waiting = true;
    });
    await verifyEmail();
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

  Widget _buildEmail() {
    return TextFormField(
      focusNode: _emailFNode,
      initialValue: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(Icons.email),
        border: InputBorder.none,
        iconColor: Colors.purple,
        errorStyle: TextStyle(fontSize: 16.0),
        hintText: 'Email',
      ),
      onFieldSubmitted: (String? value) {
        _passwordFNode.requestFocus();
      },
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
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      obscureText: _isObscure,
      focusNode: _passwordFNode,
      decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.password_sharp),
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
      onChanged: (String? value) {
        if (value!.length >= 8) {
          setState(() {
            _passwordIsError = false;
          });
        }
        _password = value;
      },
      onFieldSubmitted: (String? value) {
        _confirmPFNode.requestFocus();
      },
      onSaved: (String? value) {
        _password = value;
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

  Widget _buildTermsAndConditions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
            value: this._termsandconditions,
            onChanged: (bool? value) {
              setState(() {
                this._termsandconditions = value!;
                if (value = true) {
                  _termsIsError = false;
                }
              });
            }),
        Text("J'accepte les termes et conditions",
            style: TextStyle(
              color: _termsIsError ? Colors.red : Colors.black,
            )),
      ],
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
                        isIcon = false;
                      });
                      Map<String, String?> data = {
                        "email": _email!.trim(),
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
                        print(result.body);
                        showError("something went wrong!");
                      }
                      setState(() {
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
    double height = MediaQuery.of(context).size.height;
    Form getForm() {
      switch (etap) {
        case 0:
          return Form(
              key: _etap0FormKey,
              child: Container(
                height: height * 0.40,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedTextFieldContainer(
                          child: _buildName(), error: _nameIsError),
                      SizedBox(height: 15),
                      RoundedTextFieldContainer(
                          child: _buildSurname(), error: _surnameIsError),
                      SizedBox(height: 15),
                      RoundedTextFieldContainer(
                          child: _buildPhoneNumber(),
                          error: _phoneNumberIsError),
                    ],
                  ),
                ),
              ));
        case 1:
          return Form(
              key: _etap1FormKey,
              child: Container(
                height: height * 0.40,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedTextFieldContainer(
                          child: _buildNomStructure(), error: _nomSIsError),
                      SizedBox(height: 15),
                      RoundedTextFieldContainer(
                          child: _buildPhoneStructure(), error: _phoneSIsError),
                      SizedBox(height: 15),
                      RoundedTextFieldContainer(
                          child: _buildAdressStructure(),
                          error: _adressSIsError),
                      SizedBox(height: 15),
                      RoundedTextFieldContainer(
                          child: _buildNumFiscal(), error: _numFIsError),
                    ],
                  ),
                ),
              ));

        case 2:
          return Form(
              key: _etap2FormKey,
              child: Container(
                height: height * 0.40,
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
                      SizedBox(height: height * 0.0435),
                      RoundedTextFieldContainer(
                          child: _buildEmail(), error: _emailIsError),
                      SizedBox(height: 15),
                      RoundedTextFieldContainer(
                          child: _buildPassword(), error: _passwordIsError),
                      SizedBox(height: 15),
                      RoundedTextFieldContainer(
                          child: _buildConfirmPassword(),
                          error: _confirmPIsError),
                      SizedBox(height: 25),
                      _buildTermsAndConditions(),
                    ],
                  ),
                ),
              ));

        case 3:
          return Form(
              key: _etap3FormKey,
              child: Container(
                height: height * 0.40,
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
                      SizedBox(height: height * 0.0435),
                      RoundedTextFieldContainer(
                          child: _buildToken(), error: _tokenIsError),
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

    Future<void> createUser() async {
      String? firebasetoken = await FirebaseModule.getFireBaseId();
      Map<String, String?> data = {
        "notifId": firebasetoken,
        "token": _token!.trim(),
        "name": _name!.trim(),
        "surname": _surname!.trim(),
        "phoneNumber": _phoneNumber!.trim(),
        "email": _email!.trim(),
        "nomStructure": _nomStructure!.trim(),
        "password": _password!.trim(),
        "phoneStructure": _phoneStructure!.trim(),
        "numFiscal": _numFiscal!.trim(),
        "adressStructure": _adressStructure!.trim(),
      };
      var result = await http.post(
        Uri.parse(createUserURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      setState(() {
        waiting = false;
      });
      if (result.statusCode == 200) {
        print(result.body);
        setState(() {
          waiting = true;
        });
        final user = userModuleFromJson(result.body);
        await UserPrefs.clear();
        await UserPrefs.save(user);
        await UserPrefs.setIsLogedIn(true);
        setState(() {
          waiting = false;
        });
        showSimpleNotification(
            Text("Account created success", style: TextStyle()),
            duration: Duration(seconds: 2),
            foreground: Colors.white,
            background: Colors.greenAccent);
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeScreen(0)),
              ModalRoute.withName('/homescreen'));
        });
      } else if (result.statusCode == 401) {
        showError("Invalid token");
      } else {
        showError("something went wrong");
      }
    }

    Future<void> etap3() async {
      _etap3FormKey.currentState!.save();
      if (!validateToken(_token!)) return;
      setState(() {
        waiting = true;
      });
      await createUser();
    }

    int n = etap + 1;
    return WillPopScope(
    onWillPop: () async {return (etap == 0)?true:false;},
      child: Container(
          child: Column(
        children: [
          getForm(),
          GestureDetector(
            child: PrimaryButton(
              func: (etap == 0)
                  ? etap0
                  : (etap == 1)
                      ? etap1
                      : (etap == 2)
                          ? etap2
                          : etap3,
              buttonText: (etap <= 2) ? 'Suivant ($n / 4) ' : 'Submit',
            ),
          ),
          SizedBox(height: /*10*/ height * 0.04),
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
      )),
    );
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

  bool validateEmail(String email) {
    if (email.isEmpty) {
      _emailFNode.requestFocus();
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
      _emailFNode.requestFocus();
      return false;
    }
    setState(() {
      _emailIsError = false;
    });
    return true;
  }

  bool validatePassword(String password) {
    if (password.isEmpty) {
      _passwordFNode.requestFocus();
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

  bool validateTerms() {
    if (!_termsandconditions) {
      showError("vous dois accepter les terms et conditions");
      setState(() {
        _termsIsError = true;
      });
      return false;
    }
    setState(() {
      _termsIsError = false;
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
