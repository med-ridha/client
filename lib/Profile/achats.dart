import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/widgets/secondBarUI.dart';

class Achats extends StatefulWidget {
  @override
  AchatsState createState() => AchatsState();
}

class AchatsState extends State<Achats> with TickerProviderStateMixin {
  List<dynamic> listAbonn = [];
  @override
  void initState() {
    super.initState();
    UserModule.getAbonns().then((result) => {
          setState(() {
            listAbonn = result;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
                            child: SecondBarUi("Mes Achats", false),
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
                "Historique de mes achats",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                "Vous trouverez ci-dessous votre",
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.normal),
              ),
              Text(
                "historique des achats.",
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.normal),
              ),
              Text(
                "Il vous suffit de consulter un achat",
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.normal),
              ),
              Text(
                "confirmé pour gérer l'affectation",
                style: const TextStyle(
                    fontSize: 11, fontWeight: FontWeight.normal),
              ),
              Text(
                "des abonnements.",
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
          child: (listAbonn.length > 0)
              ? DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('purchase ID'),
                    ),
                    DataColumn(
                      label: Text('Total TTC'),
                    ),
                    DataColumn(
                      label: Text('Méthode de paiement'),
                    ),
                    DataColumn(
                      label: Text("Date d'achat"),
                    ),
                  ],
                  rows: <DataRow>[
                    for (Map<String, dynamic> item in listAbonn)
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text(item['_id'])),
                          DataCell(Text(item['montant'].toString())),
                          DataCell(Text('Credit card')),
                          DataCell(Text(item['dateStart'].split("T")[0])),
                        ],
                      ),
                  ],
                )
              : Text("you don't have any purchases"),
        ),
      ),
    );
  }
}
