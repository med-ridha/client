import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/screens/viewOneDocument.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:juridoc/widgets/sendButton.dart';

class ViewOneCategory extends StatefulWidget {
  final String title;
  final List<String> listDocumentIds;
  ViewOneCategory(this.title, this.listDocumentIds);
  @override
  ViewOneCategoryState createState() =>
      ViewOneCategoryState(title, listDocumentIds);
}

class ViewOneCategoryState extends State<ViewOneCategory>
    with TickerProviderStateMixin {
  String title;
  List<String> listDocumentIds;
  List<DocumentModule> listDocuments = [];
  @override
  void initState() {
    super.initState();
    DocumentModule.getModules(listDocumentIds).then((result) {
      setState(() {
        listDocuments = result;
      });
    });
  }

  ViewOneCategoryState(this.title, this.listDocumentIds);

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
                  height: 60,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: (title != "Banque-Finances-Assurances")
                      ? SecondBarUi(title, false)
                      : SecondBarUi(title, false, fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                for (DocumentModule item in listDocuments)
                  buildDocumentWidget(context, item),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget buildDocumentWidget(BuildContext context, DocumentModule document) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                                  document.titleFr!.substring(
                                          0,
                                          (document.titleFr!.length / 2)
                                              .floor()) +
                                      '...',
                                  style: TextStyle(fontSize: 18))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(width: width * 0.02),
                              SendButton(
                                  icon: Icons.arrow_forward_ios_sharp,
                                  func: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ViewOneDocument(document)));
                                  }),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: height * 0.02)
                    ],
                  )),
            ],
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }
}
