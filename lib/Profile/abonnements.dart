import 'dart:collection';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/screens/Cart.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/widgets/secondBarUI.dart';

class Abonnements extends StatefulWidget {
  @override
  AbonnementsState createState() => AbonnementsState();
}

class AbonnementsState extends State<Abonnements>
    with TickerProviderStateMixin {
  List<dynamic> listAbonns = [];
  @override
  void initState() {
    super.initState();
    UserModule.getAbonns().then((result) {
      setState(() {
        listAbonns = result;
      });
    });
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
                decoration: BoxDecoration(
                    color: Colors.white70,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(100), blurRadius: 10.0),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  children: [
                    Container(
                      child: AppBarUI(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child:
                                SecondBarUi('Mes abonnements', false,fontSize:18, func: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Cart()));
                            }),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  abonnemnt(context),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  table(context),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                    )
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
          SvgPicture.asset(
            "SVG/cash.svg",
            height: 55,
            width: 55,
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Vous trouverez ci-dessous votre",
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.normal),
              ),
              Text(
                "historique des abonnements payants.",
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget table(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: (listAbonns.length > 0)
              ? DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('Module'),
                    ),
                    DataColumn(
                      label: Text('Du'),
                    ),
                    DataColumn(
                      label: Text('Au'),
                    ),
                  ],
                  rows: <DataRow>[
                    for (Map<String, dynamic> item in listAbonns)
                      for (String it in item['modules'])
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text(it)),
                            DataCell(Text(item['dateStart'].split("T")[0])),
                            DataCell(Text(item['dateFinish'].split("T")[0])),
                          ],
                        ),
                  ],
                )
              : Text("you don't have any"),
        ),
      ),
    );
  }
}
