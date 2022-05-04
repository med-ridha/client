import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/screens/viewCategories.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/secondBarUI.dart';

class Modules extends StatefulWidget {
  @override
  ModulesState createState() => ModulesState();
}

class ModulesState extends State<Modules> with TickerProviderStateMixin {
  List<dynamic> listModules = [];

  String selectedValue = UserPrefs.getLatestDuration().toString();
  List<String> items = ['1', '7', '10', '15', '30'];

  @override
  void initState() {
    super.initState();
    ModuleModule.getModulesLatest().then((value) {
      setState(() {
        listModules = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  children: [
                    AppBarUI(),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 60,
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: SecondBarUi("Les derniers parutions", false,
                              fontSize: 16)),
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
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("les",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(width: 15),
                                  duree(context),
                                  SizedBox(width: 15),
                                  Text("derniers jour",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              (listModules.length == 0)
                                  ? Container(
                                      child: Column(
                                      children: [
                                        Text("Aucun nouveau document ajoute",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(height: height * 0.02)
                                      ],
                                    ))
                                  : Container(
                                      child: Column(children: [
                                      for (dynamic module in listModules)
                                        moduleWidget(context, module['name'],
                                            module['count'].toString(), module),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ]))
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
      ),
    ]);
  }

  Widget moduleWidget(
      BuildContext context, String name, String count, dynamic module) {
    return GestureDetector(
        onTap: () {
          ModuleModule.getCategoriesLatest(module['listCategories'])
              .then((result) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ViewCategories(name, result),
                ));
          });
        },
        child: Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
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
                      Image.asset(
                        "images/$name.png",
                        height: 60,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        count,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            )));
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
                    "15",
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
                          fontSize: 20,
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
                UserPrefs.setLatestDuration(int.parse(value));
                ModuleModule.getModulesLatest().then((result) {
                  setState(() {
                    listModules = result;
                  });
                });
              });
            },
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey,
            buttonHeight: 50,
            buttonWidth: 80,
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
            dropdownMaxHeight: 500,
            dropdownWidth: 100,
            dropdownPadding: const EdgeInsets.only(left: 14),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-10, 0),
          ),
        ),
      ),
    );
  }
}
