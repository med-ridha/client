import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/module/service.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/RoundedTextFieldContainer.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:overlay_support/overlay_support.dart';

class Cart1 extends StatefulWidget {
  @override
  Cart1State createState() => Cart1State();
}

class Cart1State extends State<Cart1> with TickerProviderStateMixin {
  double montant = 0;
  List<String> modules = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String createAbonnURL = Service.url + 'users/createAbonn';

  late FocusNode _creditFNode;
  bool _creditIsError = false;
  String? _creditCard;

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

  String? selectedValue;
  List<String> items = [
    '1 Ans',
    '2 Ans',
    '3 Ans',
  ];

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppBarUI(),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        abonnemnt(context),
                        SizedBox(height: height * 0.02),
                        text1(context),
                        duree(context),
                        SizedBox(height: height * 0.02),
                        text2(context),
                        checkbox(context),
                        SizedBox(height: height * 0.02),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total: " + montant.toString(),
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
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget checkbox(BuildContext context) {
    return CheckboxGroup(
        labels: <String>[
          "Fiscal",
          "Social",
          "Investissement",
          "banque-Finances-Assurances",
          "Bibus",
          "Collectivites locales",
          "Veille Juridique",
        ],
        onSelected: (List<String> checked) {
          setState(() {
            montant = 0;
          });
          for (String item in checked) montant += 333;
          setState(() {
            print(montant);
            modules = checked;
          });
          print(checked.toString());
        });
  }

  Widget abonnemnt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Abonnement",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "Merci de préciser la durée de votre",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
              Text(
                "abonnement et le nombre de",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
              Text(
                "module acheter.",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget text1(BuildContext context) {
    return Text(
      "Duree d'abonnement",
      style: const TextStyle(
          fontSize: 21, fontWeight: FontWeight.normal, color: kSecondaryColor),
    );
  }

  Widget text2(BuildContext context) {
    return Text(
      "Choisir un ou plusieur",
      style: const TextStyle(
          fontSize: 21, fontWeight: FontWeight.normal, color: kSecondaryColor),
    );
  }

  Widget duree(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
      width: width,
      child: Center(
        child: DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.black,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Choisir votre durée',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
            buttonHeight: 50,
            buttonWidth: width,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: Colors.white,
            ),
            buttonElevation: 2,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        ),
      ),
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

  Widget button1(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () async {
          _formKey.currentState!.save();
          if (selectedValue == null) {
            showError("you need to choose une duree");
            return;
          }

          if (modules.length == 0) {
            showError("please select atleast one module!!");
            return;
          }

          if (!validateCreditCard(_creditCard!)) {
            return;
          }

          Map<String, String?> data = {
            "email": UserPrefs.getEmail(),
            "montant": montant.toString(),
            "modules": modules.toString(),
            "duree": selectedValue!.split(' ')[0]
          };
          var result = await http.post(Uri.parse(createAbonnURL),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(data));
          if (result.statusCode == 200) {
            showSimpleNotification(Text("abonnement success", style: TextStyle()),
                duration: Duration(seconds: 3),
                foreground: Colors.white,
                background: Colors.greenAccent);
            Map<String, dynamic> response = json.decode(result.body);
            UserPrefs.setListAbonn(response['message']);
          } else {
            showError("something went wrong!");
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
                      Text(
                        "Submit order",
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
