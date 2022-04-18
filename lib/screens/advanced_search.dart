import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import '../theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class AdvancedSearch extends StatefulWidget {
  @override
  AdvancedSearchState createState() => AdvancedSearchState();
}

class AdvancedSearchState extends State<AdvancedSearch>
    with TickerProviderStateMixin {
  final apresle = TextEditingController();

  void start1() {
    apresle.dispose();
    super.dispose();
  }

  void start2() {
    apresle.dispose();
    super.dispose();
  }

  final avantle = TextEditingController();
  bool exacte = false;

  void end1() {
    avantle.dispose();
    super.dispose();
  }

  void end2() {
    avantle.dispose();
    super.dispose();
  }

  String? selectedValue;
  List<String> items = [
    'Accord',
    'Arrêté',
    'Avis de change',
    'Avis',
    'Cahiers des charges',
    'Charte',
    'Circulaire',
    'Code',
    'Communiqué',
    'Constitution',
    'Convention de Non Double Imposition',
    'Convention internationale',
    'Conventions',
    'Conventions bilatérales',
    'Conventions cadre et sectorielles',
    'Décision',
    "Décision de la commission d'agrément",
    'Décret Gouvernomental',
    'Décret Présidentiel',
    'Décret-loi',
    'Douane',
    'Guide',
    'Loi',
    'Loi de Finance',
    'Loi organique',
    'Norme',
    'Note Commune',
    'Note Interne',
    'Prise de Position',
    'Règlement',
    'Traité',
  ];
  String? selectedValue1;
  List<String> items1 = [
    'Tous les documents',
    'Documents en vigueur',
    'Documents abrogés',
  ];
  String? selectedValue2;
  List<String> items2 = [
    "Fiscal",
    "Fiscal >> Codes",
    "Fiscal >> Lois de finances",
    "Fiscal >> Lois",
    "Fiscal >> Décrets",
    "Fiscal >> Arrêtés",
    "Fiscal >> Notes communes",
    "Fiscal >> Prise de positions",
    "Fiscal >> Notes internes",
    "Fiscal >> Jurisprudence",
    "Fiscal >> Système comptable",
    "Fiscal >> Conventions de non double imposition",
    "Fiscal >> Circulaires",
    "Fiscal >> Douane",
    "Social",
    "Social >> Codes",
    "Social >> Lois",
    "Social >> Décrets",
    "Social >> Arrêtés",
    "Social >> Circulaires",
    "Social >> Notes internes",
    "Social >> Jurisprudence",
    "Social >> Notes communes fiscales",
    "Social >> Conventions cadre et sectorielles",
    "Social >> Conventions bilatérales",
    "Social >> Convention internationale",
    "Investissement",
    "Investissement >> Codes",
    "Investissement >> Décrets",
    "Investissement >> Arrêtés",
    "Investissement >> Notes communes",
    "Investissement >> Notes internes",
    "Investissement >> Circulaires",
    "Investissement >> Cahiers des charges",
    "Investissement >> Douane",
    "Banque - Finances - Assurances",
    "Banque - Finances - Assurances >> Codes",
    "Banque - Finances - Assurances >> Lois",
    "Banque - Finances - Assurances >> Décrets",
    "Banque - Finances - Assurances >> Arrêtés",
    "Banque - Finances - Assurances >> Notes communes",
    "Banque - Finances - Assurances >> Jurisprudence",
    "Banque - Finances - Assurances >> Circulaires",
    "Banque - Finances - Assurances >> Notes bancaires",
    "Banque - Finances - Assurances >> Décision",
    "Banque - Finances - Assurances >> Conventions cadre et sectorielles",
    "Banque - Finances - Assurances >> Marché Financier",
    "Banque - Finances - Assurances >> Microfinance",
    "BIBUS",
    "BIBUS >> Constitution",
    "BIBUS >> Codes",
    "Collectivités locales",
    "Collectivités locales >> Codes",
    "Collectivités locales >> Lois",
    "Collectivités locales >> Décrets",
    "Collectivités locales >> Arrêtés",
    "Collectivités locales >> Circulaires",
    "Collectivités locales >> Notes communes",
    "Collectivités locales >> Notes internes",
    "Collectivités locales >> Jurisprudence",
    "Collectivités locales >> Prise de positions",
    "Collectivités locales >> Cahiers des charges",
    "Veille Juridique",
  ];
  String? selectedValue3;
  List<String> items3 = [
    'Association',
    "Blanchiment d'argent",
    'Change',
    'Collectivités locales',
    'Commerce extérieur',
    'Conventions collectives',
    'Droit bancaire',
    'Droit commercial',
    'Droit de l’investissement',
    'Droit de la concurrence',
    'Droit de la santé',
    'Droit des assurances',
    'Droit des sociétés',
    'Mme.',
    'Droit des transports',
    'Droit du Capital Investissement',
    'Droit du travail',
    'Droit financier',
    'Droit fiscal',
    'Droit immobilier',
    'Droit pénal',
    'Mme.',
    'Droit social',
    'Mme.',
    'Entreprises publiques',
    'Financement',
    'Industries culturelles',
    'Justice',
    'Marchés financiers',
    'Microfinance',
    'Sécurité sociale',
    'Tourisme',
    'Veille Juridique',
  ];

  TextEditingController numero = TextEditingController();
  TextEditingController annee = TextEditingController();
  TextEditingController motcle = TextEditingController();
  @override
  void initState() {
    numero.text = ""; //innitail value of text field
    annee.text = "";
    motcle.text = "";
    super.initState();
  }

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
              children: [
                AppBarUI(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: width ,
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
                        Text2(context),
                        Text1(context),
                        checkbox(context),
                        Text3(context),
                        Text9(context),
                        duree(context),
                        Text10(context),
                        widgetnumero(context),
                        Text4(context),
                        widgetannee(context),
                        Text5(context),
                        duree1(context),
                        Text6(context),
                        duree2(context),
                        Text7(context),
                        duree3(context),
                        Text8(context),
                        rang(context),
                        SizedBox(
                          height: 10,
                        ),
                        button1(context),
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

  Widget abonnemnt(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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

  Widget Text1(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
              controller: motcle,
              decoration: InputDecoration(
                labelText: "Recherchez par mot clé:",
                focusedBorder: myfocusborder(),
              )),
        ],
      ),
    );
  }

  Widget duree(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
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
                    'Accord',
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
            dropdownWidth: width,
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

  Widget Text2(BuildContext context) {
    return Text(
      "Mots clés:",
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),
    );
  }

  Widget Text3(BuildContext context) {
    return Text(
      "Référence du texte:",
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),
    );
  }

  Widget Text9(BuildContext context) {
    return Text(
      "Nature de texte:",
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: kBlackColor),
    );
  }

  Widget Text10(BuildContext context) {
    return Text(
      "Numéro:",
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: kBlackColor),
    );
  }

  Widget duree1(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
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
                    'Tous les documents',
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
            items: items1
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
            value: selectedValue1,
            onChanged: (value) {
              setState(() {
                selectedValue1 = value as String;
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
            dropdownWidth: width,
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

  Widget duree2(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
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
                    'Tous les catégories',
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
            items: items2
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
            value: selectedValue2,
            onChanged: (value) {
              setState(() {
                selectedValue2 = value as String;
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
            dropdownWidth: width,
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

  Widget duree3(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
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
                    'Tous les secteurs',
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
            items: items3
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
            value: selectedValue3,
            onChanged: (value) {
              setState(() {
                selectedValue3 = value as String;
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
            dropdownWidth: width,
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

  Widget widgetnumero(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
              controller: numero,
              decoration: InputDecoration(
                labelText: "Numéro:",
                focusedBorder: myfocusborder(),
              )),
        ],
      ),
    );
  }

  Widget Text4(BuildContext context) {
    return Text(
      "Année",
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.normal, color: kBlackColor),
    );
  }

  Widget widgetannee(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
              controller: annee,
              decoration: InputDecoration(
                labelText: "AAAA",
                focusedBorder: myfocusborder(),
              )),
        ],
      ),
    );
  }

  Widget Text5(BuildContext context) {
    return Text(
      "États du document:",
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),
    );
  }

  Widget Text6(BuildContext context) {
    return Text(
      "Catégories:",
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),
    );
  }

  Widget Text7(BuildContext context) {
    return Text(
      "Secteurs d'activité:",
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),
    );
  }

  Widget Text8(BuildContext context) {
    return Text(
      "Date de publication:",
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: kSecondaryColor),
    );
  }

  Widget checkbox(BuildContext context) {
    return CheckboxGroup(
        labels: <String>["Rechercher l'expression exacte"],
        onSelected: (List<String> checked) => exacte = !exacte);
  }

  Widget rang(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Container(
          width: 5,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Après le:"),
            GestureDetector(
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                apresle.text = date.toString().substring(0, 10);
              },
              child: AbsorbPointer(
                absorbing: true,
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: apresle,
                  decoration: InputDecoration(
                      suffixIcon:
                          Icon(Icons.calendar_today, color: Colors.blue)),
                ),
              ),
            )
          ],
        )),
        Container(
          width: 5,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Avant le:"),
            GestureDetector(
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                avantle.text = date.toString().substring(0, 10);
              },
              child: AbsorbPointer(
                absorbing: true,
                child: TextFormField(
                  controller: avantle,
                  decoration: InputDecoration(
                      suffixIcon:
                          Icon(Icons.calendar_today, color: Colors.blue)),
                ),
              ),
            )
          ],
        )),
        Container(
          width: 5,
        ),
      ],
    ));
  }

  Widget button1(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
        onTap: () {
          print(annee.text);
          print(motcle.text);
          print(numero.text);
          print(apresle.text);
          print(avantle.text);
          print(exacte);
          print(selectedValue);
          print(selectedValue1);
          print(selectedValue2);
          print(selectedValue3);
          //api call
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

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }
}
