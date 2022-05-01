import 'package:animate_do/animate_do.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/screens/viewCategories.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/secondBarUI.dart';

class Search extends StatefulWidget {
  final String searchTerm;
  Search(this.searchTerm) : super();
  @override
  SearchState createState() => SearchState(searchTerm);
}

class SearchState extends State<Search> with TickerProviderStateMixin {
  List<dynamic> listModules = [];
  String searchTerm;

  bool waiting = true;
  SearchState(this.searchTerm);

  @override
  void initState() {
    super.initState();
    DocumentModule.search(searchTerm).then((value) {
      setState(() {
        listModules = value;
        print(listModules);
        waiting = false;
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
                          child: SecondBarUi("Search", false, fontSize: 24)),
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
                                children: [],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              (waiting)
                                  ? SpinKitDualRing(
                                      size: 35, color: Colors.green)
                                  : (listModules.length == 0)
                                      ? Container(
                                          child: Text("No result Found",
                                              style: TextStyle(fontSize: 24)))
                                      : Container(
                                          child: Column(
                                          children: [
                                            for (dynamic module in listModules)
                                              moduleWidget(
                                                  context,
                                                  module['name'],
                                                  module['count'].toString(),
                                                  module),
                                          ],
                                        )),
                              SizedBox(
                                height: 15,
                              ),
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
          DocumentModule.getCatSearch(module['listCategories'], searchTerm)
              .then((result) {
            print(result);
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
}
