import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/screens/search_result.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/widgets/secondary_button.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:juridoc/theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class AdvancedSearch extends StatefulWidget {
  @override
  AdvancedSearchState createState() => AdvancedSearchState();
}

class AdvancedSearchState extends State<AdvancedSearch>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String motCle = "";
  bool motCleIsError = false;
  bool exacte = false;

  String? module;
  String? category = "Sélectionner un module";

  List<String> listModules = [];

  List<String> listCategories = ["Sélectionner un module"];

  DateTime? apresLe;
  DateTime? avantLe;

  @override
  void initState() {
    super.initState();
    ModuleModule.getListModules().then(((value) {
      List<String> list = [];
      for (ModuleModule mod in value) {
        if (mod.numDoc!.toInt() > 0) {
          list.add(mod.name ?? '');
        }
      }
      setState(() {
        listModules = list;
      });
    }));
  }

  Widget _buildMotCle() {
    return TextFormField(
        initialValue: motCle,
        decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Mot Cle',
            border: InputBorder.none),
        onSaved: (String? value) {
          motCle = value ?? '';
        },
        onChanged: (String? value) {
          setState(() {
            motCleIsError = false;
          });
        });
  }

  Widget buildModules(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: DropdownButton<String>(
        alignment: Alignment.center,
        value: module,
        icon: null,
        elevation: 16,
        style: const TextStyle(color: kPrimaryColor, fontSize: 15),
        underline: Container(
            height: 2, color: kSecondaryColor //Colors.deepPurpleAccent,
            ),
        onChanged: (String? newValue) {
          List<Category> list = ModuleModule.getCategories(
              newValue ?? '', ModuleModule.listModules);
          List<String> listCategorie = [];
          for (Category cat in list) {
            listCategorie.add(cat.name ?? "");
          }
          setState(() {
            listCategories = ["Sélectionner une categorie"];
            listCategories.addAll(listCategorie);
            category = "Sélectionner une categorie";
            module = newValue!;
          });
        },
        items: listModules.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildCategory(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: DropdownButton<String>(
        alignment: Alignment.center,
        value: category,
        icon: null,
        elevation: 16,
        style: const TextStyle(color: kPrimaryColor, fontSize: 12),
        underline: Container(
          height: 2,
          color: kSecondaryColor, // Colors.deepPurpleAccent,
        ),
        onChanged: (listCategories.length > 0)
            ? (String? newValue) {
                setState(() {
                  category = newValue!;
                });
              }
            : null,
        items: listCategories.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExacte() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
            value: this.exacte,
            onChanged: (bool? value) {
              setState(() {
                this.exacte = value!;
              });
            }),
        Text("Recherche l'expression exacte",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      header(context),
                                      RoundedTextFieldContainer(
                                          child: _buildMotCle(),
                                          error: motCleIsError),
                                      SizedBox(height: height * 0.01),
                                      _buildExacte(),
                                      SizedBox(height: height * 0.02),
                                      buildDivider(),
                                      SizedBox(height: height * 0.02),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text("MODULE: ",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                buildModules(context),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text("CATEGORIE: ",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                buildCategory(context),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: height * 0.02),
                                      buildDivider(),
                                      SizedBox(height: height * 0.02),
                                      Text("DATE DE PUBLICATION",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: height * 0.02),
                                      Row(
                                        //mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text("APRES LE: ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(width: width * 0.1),
                                          ElevatedButton(
                                            onPressed: () =>
                                                selectApresLe(context),
                                            child: Text(
                                                (apresLe != null)
                                                    ? apresLe
                                                        .toString()
                                                        .split(" ")[0]
                                                    : "Choisir une date",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        //mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text("AVANT LE: ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(width: width * 0.1),
                                          ElevatedButton(
                                            onPressed: () =>
                                                selectAvantLe(context),
                                            child: Text(
                                                (avantLe != null)
                                                    ? avantLe
                                                        .toString()
                                                        .split(" ")[0]
                                                    : "Choisir une date",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: height * 0.02),
                                      buildDivider(),
                                      SizedBox(height: height * 0.02),
                                      button1(context),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.02),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  motCle = "";
                                  exacte = false;
                                  module = null;
                                  listCategories = ["Sélectionner un module"];
                                  category = "Sélectionner un module";
                                  apresLe = null;
                                  avantLe = null;
                                });
                              },
                              child: SecondaryButton(
                                  buttonText: 'Reset',
                                  icon: Icon(Icons.refresh_sharp))),
                        ],
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

  Widget header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            "SVG/search.svg",
            height: 55,
            width: 55,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                " RECHERCHE AVANCÉE",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget button1(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _formKey.currentState!.save();
          if (motCle.length < 3) {
            showError("Au moins 3 lettres sont requises");
            return;
          }
          String query = '?search=$motCle';
          if (exacte) query += '&exacte=$exacte';
          if (module != null) query += '&module=$module';
          if (category != "Sélectionner un module" &&
              category != "Sélectionner une categorie") query += '&category=$category';
          if (apresLe != null) query += '&apresLe=$apresLe';
          if (avantLe != null) query += '&avantLe=$avantLe';
          query += '&email=' + (UserPrefs.getEmail() ?? '');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => Search(query),
              ));
        },
        child: Container(
            alignment: Alignment.center,
            height: 60,
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: kPrimaryColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(100), blurRadius: 10.0),
                ]),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Rechercher",
                        style: const TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent);
  }

  Divider buildDivider() {
    return Divider(
      color: kSecondaryColor, // Color(Colors.purple.value),
      height: 2,
    );
  }

  Future<void> selectApresLe(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: apresLe ?? DateTime.now(),
        firstDate: DateTime(1970, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != apresLe) {
      setState(() {
        apresLe = picked;
      });
    }
  }

  Future<void> selectAvantLe(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: avantLe ?? DateTime.now(),
        firstDate: DateTime(1970, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != avantLe) {
      setState(() {
        avantLe = picked;
      });
    }
  }
}
