import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/Profile/abonnements.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/module/service.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:overlay_support/overlay_support.dart';

class CartCheckOut extends StatefulWidget {
  final List<String> modules;
  final int duree;
  final double montant;
  CartCheckOut(this.modules, this.duree, this.montant);
  @override
  CartCheckOutState createState() => CartCheckOutState(modules, duree, montant);
}

class CartCheckOutState extends State<CartCheckOut>
    with TickerProviderStateMixin {
  List<String> modules;
  int duree;
  double montant;
  CartCheckOutState(this.modules, this.duree, this.montant);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String createAbonnURL = Service.url + 'users/createAbonn';

  late FocusNode _creditFNode;
  bool _creditIsError = false;
  String? _creditCard;

  bool done = false;

  @override
  void initState() {
    _creditFNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _creditFNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double safePadding = MediaQuery.of(context).padding.top;
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
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppBarUI(),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 60,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: SecondBarUi("Abonnement", false)),
                    ),
                    SizedBox(
                      height: 30,
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              abonnemnt(context),
                              SizedBox(height: height * 0.02),
                              text1(context),
                              //duree(context),
                              SizedBox(height: height * 0.02),
                              text2(context),
                              SizedBox(height: height * 0.02),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Total: " + montant.toString() + " TND",
                                        style: TextStyle(
                                          fontSize: 24,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Form(
                                  key: _formKey,
                                  child: RoundedTextFieldContainer(
                                      child: buildCreditCard(),
                                      error: _creditIsError)),
                              SizedBox(height: height * 0.02),
                              button1(context),
                              SizedBox(height: height * 0.01),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }

  Widget abonnemnt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "CONFIRMER LA COMMANDE.",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget text1(BuildContext context) {
    return Text(
      "Duree d'abonnement: $duree ans",
      style: const TextStyle(
          fontSize: 21, fontWeight: FontWeight.normal, color: kSecondaryColor),
    );
  }

  Widget text2(BuildContext context) {
    return Column(
      children: [
        Text(
          "Modules choisis",
          style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.normal,
              color: kSecondaryColor),
        ),
        SizedBox(height: 10),
        for (String module in modules)
          Text(module,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))
      ],
    );
  }

  Widget buildCreditCard() {
    return TextFormField(
      focusNode: _creditFNode,
      initialValue: _creditCard,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        icon: Icon(Icons.credit_card),
        border: InputBorder.none,
        iconColor: Colors.purple,
        errorStyle: TextStyle(fontSize: 16.0),
        hintText: 'Credit Card',
      ),
      onChanged: (String? value) {
        if (value!.length == 16) {
          setState(() {
            _creditIsError = false;
          });
          return null;
        }
      },
      onSaved: (String? value) {
        _creditCard = value;
      },
    );
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
              child: Text("Annuler"),
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

  Widget button1(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () async {
          FocusScope.of(context).requestFocus(new FocusNode());
          if (!done) {
            _formKey.currentState!.save();

            if (modules.length == 0) {
              showError("please select atleast one module!!");
              return;
            }

            if (!validateCreditCard(_creditCard!)) {
              return;
            }
            showAlertDialog(context, "Are you sure? amount: $montant TND",
                () async {
              Map<String, String?> data = {
                "email": UserPrefs.getEmail(),
                "montant": montant.toString(),
                "modules": modules.toString(),
                "duree": duree.toString()
              };
              var result = await http.post(Uri.parse(createAbonnURL),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(data));
              if (result.statusCode == 200) {
                setState(() {
                  done = true;
                });
                Map<String, dynamic> response = json.decode(result.body);
                List<String> listAbonn =
                    List<String>.from(response['message'].map((x) => x));
                UserPrefs.setListAbonn(listAbonn);
                await UserModule.getModules();
                await Future.delayed(Duration(seconds: 2), () {
                  showSimpleNotification(
                      Text("abonnement success", style: TextStyle()),
                      duration: Duration(seconds: 3),
                      foreground: Colors.white,
                      background: Colors.greenAccent);
                  setState(() {
                    done = false;
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Abonnements()));
                });
              } else {
                showError("something went wrong!");
              }
            });
          }
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
                      (!done)
                          ? Text(
                              "Submit order",
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          : SpinKitDualRing(size: 35, color: Colors.green),
                    ],
                  ),
                ],
              ),
            )));
  }

  bool validateCreditCard(String creditCard) {
    if (creditCard.isEmpty) {
      _creditFNode.requestFocus();
      setState(() {
        _creditIsError = true;
      });
      return false;
    }
    List<String> args = creditCard.split('');
    for (int i = 0; i < args.length; i++) {
      try {
        double.parse(args[i]);
      } catch (error) {
        setState(() {
          _creditIsError = true;
        });
        showError("credit card must contains only numbers");
        return false;
      }
    }
    if (creditCard.length != 16) {
      showError("credit card should be 16 numbers long");
      setState(() {
        _creditIsError = true;
      });
      _creditFNode.requestFocus();
      return false;
    }
    setState(() {
      _creditIsError = false;
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
