import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:juridoc/widgets/primary_button.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class EditProfile extends StatefulWidget {
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _surname;
  String? _nomStructure;
  String? _phoneStructure;
  String? _adressStructure;
  String? _numFiscal;

  @override
  void initState() {
    super.initState();
    _name = UserPrefs.getName() ?? '';
    _surname = UserPrefs.getSurname() ?? '';
    _email = UserPrefs.getEmail() ?? '';
    _phoneNumber = UserPrefs.getPhoneNumber() ?? '';
    _nomStructure = UserPrefs.getNomStructure() ?? '';
    _phoneStructure = UserPrefs.getPhoneStructure() ?? '';
    _adressStructure = UserPrefs.getAdressStructure() ?? '';
    _numFiscal = UserPrefs.getNumFiscal() ?? '';
    print(_numFiscal);
  }

  Widget _buildEmail(String? email) {
    return TextFormField(
      initialValue: email,
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Email is Required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null;
      },
      onSaved: (String? value) {
        _email = value;
      },
    );
  }

  Widget _buildSurname(String? surname) {
    return TextFormField(
      initialValue: surname,
      decoration: InputDecoration(labelText: 'Nom de famille'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nom de famille is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        if (value == null) return;
        _surname = value;
      },
    );
  }

  Widget _buildPhoneNumber(String? phoneNumber) {
    return TextFormField(
      initialValue: phoneNumber,
      decoration: InputDecoration(labelText: 'Numéro de téléphone'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'phone number is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        if (value == null) return;
        _phoneNumber = value;
      },
    );
  }

  Widget _buildNomStructure(String? nomStructure) {
    return TextFormField(
      initialValue: nomStructure,
      decoration: InputDecoration(labelText: 'Nom de votre structure'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Nom de votre structure is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        if (value == null) return;
        _nomStructure = value;
      },
    );
  }

  Widget _buildAdressStructure(String? adressStructure) {
    return TextFormField(
      initialValue: adressStructure,
      decoration: InputDecoration(labelText: 'Adresse de votre structure'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Adresse de votre structure is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        if (value == null) return;
        _adressStructure = value;
      },
    );
  }

  Widget _buildPhoneStructure(String? phoneStructure) {
    return TextFormField(
      initialValue: phoneStructure,
      decoration: InputDecoration(labelText: 'Téléphone de votre structure'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Téléphone de votre structure is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        if (value == null) return;
        _phoneStructure = value;
      },
    );
  }

  Widget _buildNumFiscal(String? numFiscal) {
    return TextFormField(
      initialValue: numFiscal,
      decoration: InputDecoration(
          labelText:
              'Numéro d identification fiscale: (Exp: 1234567/Y/Z/T/000) '),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Numéro d identification fiscale is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        if (value == null) return;
        _numFiscal = value;
      },
    );
  }

  Widget _buildName(String? name) {
    return TextFormField(
      initialValue: name,
      decoration: InputDecoration(labelText: 'Prénom'),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(key: UniqueKey(), fit: StackFit.expand, children: [
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
                Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            abonnemnt(context),
                            _buildName(_name),
                            SizedBox(height: 20),
                            _buildSurname(_surname),
                            SizedBox(height: 20),
                            _buildPhoneNumber(_phoneNumber),
                            SizedBox(height: 20),
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
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            abonnemnt(context),
                            _buildNomStructure(_phoneStructure),
                            SizedBox(height: 20),
                            _buildPhoneStructure(_phoneStructure),
                            SizedBox(height: 20),
                            _buildAdressStructure(_adressStructure),
                            SizedBox(height: 20),
                            _buildNumFiscal(_numFiscal),
                            SizedBox(height: 20),
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
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             abonnemnt(context),
                             _buildEmail(_email),
                             SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        _formKey.currentState!.save();

                        print(_name);
                        print(_email);
                        print(_phoneNumber);
                        print(_surname);
                        // Map<String, String?> data = {
                        //   "email": _email,
                        // };

                        // final Future<SharedPreferences> _prefs =
                        //     SharedPreferences.getInstance();
                        // final SharedPreferences prefs = await _prefs;

                        // await prefs.setString("name", _name!);
                        // await prefs.setString("surname", _surname!);
                        // await prefs.setString("phoneNumber", _phoneNumber!);
                        // await prefs.setString("email", _email!);
                        // await prefs.setString("nomStructure", _nomStructure!);
                        // await prefs.setString("password", _password!);
                        // await prefs.setString("phoneStructure", _phoneStructure!);
                        // await prefs.setString("numFiscal", _numFiscal!);
                        // await prefs.setString("codeVoucher", _codeVoucher!);
                        // await prefs.setString("adressStructure", _adressStructure!);
                        // await prefs.setBool("newsletter", _newsletter);

                        // //api call
                        // if (_termsandconditions) {
                        //   var result = await http.post(
                        //     Uri.parse('http://10.0.2.2:42069/verifyEmail'),
                        //     headers: <String, String>{
                        //       'Content-Type': 'application/json; charset=UTF-8',
                        //     },
                        //     body: jsonEncode(data),
                        //   );
                        //   if (result.statusCode == 200) {
                        //     showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) =>
                        //             _buildSuccessPopupDialog(
                        //               context,
                        //               "one more step",
                        //               "you must verify your email before using our services",
                        //             ));
                        //   } else if (result.statusCode == 401) {
                        //     print(result.body);
                        //     showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) =>
                        //             _buildErrorPopupDialog(
                        //                 context, "email", "email already existes"));
                        //   } else {
                        //     print(result.body);
                        //     showDialog(
                        //         context: context,
                        //         builder: (BuildContext context) => _buildErrorPopupDialog(
                        //             context,
                        //             "internal server error",
                        //             "something went wrong in the server side please try again later"));
                        //   }
                        // } else {
                        //   showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) => _buildErrorPopupDialog(
                        //           context,
                        //           "required",
                        //           "terms and conditions are required to complete the creation of your account"));

                        //   print("terms not accepted!");
                        // }
                      },
                      child: PrimaryButton(
                        buttonText: 'créer un compte',
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget abonnemnt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SvgPicture.asset(
            "SVG/id.svg",
            height: 55,
            width: 55,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Données personnelles",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }
}
