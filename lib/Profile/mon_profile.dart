import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/primary_button.dart';
import 'package:juridoc/widgets/roundedTextContainer.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:juridoc/widgets/secondary_button.dart';
import 'package:overlay_support/overlay_support.dart';

class MonProfile extends StatefulWidget {
  @override
  MonProfileState createState() => MonProfileState();
}

class MonProfileState extends State<MonProfile> {
  String? _email;
  String? _name;
  String? _surname;
  String? _phoneNumber;

  String? _nomStructure;
  String? _phoneStructure;
  String? _adressStructure;
  String? _numFiscal;

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
    _email = UserPrefs.getEmail() ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildName() {
    return TextFormField(
      initialValue: _name,
      decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Prénom',
          border: InputBorder.none),
      onSaved: (String? value) {
        _name = value;
      },
      onFieldSubmitted: (String? value) {},
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      initialValue: _email,
      decoration: InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Email',
          border: InputBorder.none),
    );
  }

  Widget _buildSurname() {
    return TextFormField(
      initialValue: _surname,
      readOnly: true,
      decoration: InputDecoration(
          icon: Icon(Icons.people),
          hintText: 'Nom de famille',
          border: InputBorder.none),
    );
  }

  Widget buildText(String name, String? value) {
    return Container(
        child: Column(
      children: [
        Text(name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100)),
        Text(value ?? "",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
      ],
    ));
  }

  Widget _buildNomStructure() {
    return TextFormField(
      readOnly: true,
      initialValue: _nomStructure,
      decoration: InputDecoration(
          icon: Icon(Icons.other_houses),
          border: InputBorder.none,
          hintText: 'Nom de votre structure'),
    );
  }

  Widget _buildPhoneStructure() {
    return TextFormField(
      initialValue: _phoneStructure,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
          icon: Icon(Icons.contact_phone),
          border: InputBorder.none,
          hintText: 'Téléphone de votre structure'),
    );
  }

  Widget _buildAdressStructure() {
    return TextFormField(
      initialValue: _adressStructure,
      decoration: InputDecoration(
          icon: Icon(Icons.navigation),
          border: InputBorder.none,
          hintText: 'Adresse de votre structure'),
    );
  }

  Widget _buildNumFiscal() {
    return TextFormField(
      initialValue: _numFiscal,
      decoration: InputDecoration(
          icon: Icon(Icons.onetwothree),
          border: InputBorder.none,
          hintText: 'Numéro d identification fiscale'),
      onSaved: (String? value) {
        _numFiscal = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double safePadding = MediaQuery.of(context).padding.top;

    return GestureDetector(
      onTap: () {},
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
                                child: SecondBarUi("Mon profile", false)),
                            Form(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        //  crossAxisAlignment:
                                        //      CrossAxisAlignment.start,
                                        //  mainAxisAlignment:
                                        //      MainAxisAlignment.start,
                                        children: [
                                          title(context, 'SVG/id.svg',
                                              "Donnees personnelles", 0.045),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: buildText(
                                                "Email Address", _email),
                                          ),
                                          SizedBox(height: 10),
                                          buildDivider(),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: buildText("Nom", _name),
                                          ),
                                          SizedBox(height: 10),
                                          buildDivider(),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: buildText(
                                                "Nom famille", _surname),
                                          ),
                                          SizedBox(height: 10),
                                          buildDivider(),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: buildText("Numero telephone",
                                                _phoneNumber),
                                          ),
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
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          title(
                                              context,
                                              'SVG/case.svg',
                                              "Donnees professionnelles",
                                              0.035),
                                          buildText(
                                              "Nom structure", _nomStructure),
                                          SizedBox(height: 10),
                                          buildDivider(),
                                          SizedBox(height: 10),
                                          buildText(
                                              "Numero telephone structure",
                                              _phoneStructure),
                                          SizedBox(height: 10),
                                          buildDivider(),
                                          SizedBox(height: 10),
                                          buildText(
                                              "Address structure", _adressStructure),
                                          SizedBox(height: 10),
                                          buildDivider(),
                                          SizedBox(height: 10),
                                          buildText(
                                              "Numero Fiscal", _numFiscal),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
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

  Divider buildDivider() {
    return Divider(
      color: kSecondaryColor,// Color(Colors.purple.value),
      height: 2,
    );
  }
}
