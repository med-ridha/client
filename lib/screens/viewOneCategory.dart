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
  final String module;
  final String title;
  final List<String> listDocumentIds;
  ViewOneCategory(this.title, this.listDocumentIds, this.module);
  @override
  ViewOneCategoryState createState() =>
      ViewOneCategoryState(title, listDocumentIds, this.module);
}

class ViewOneCategoryState extends State<ViewOneCategory>
    with TickerProviderStateMixin {
  String title;
  String module;
  List<String> listDocumentIds;
  List<DocumentModule> listDocuments = [];
  @override
  void initState() {
    super.initState();
    DocumentModule.getListDocuments(listDocumentIds).then((result) {
      setState(() {
        listDocuments = result;
      });
    });
  }

  ViewOneCategoryState(this.title, this.listDocumentIds, this.module);

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
                          child: (title != "Conventions cadre et sectorielles")
                              ? SecondBarUi(title, false)
                              : SecondBarUi(title, false, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Column(
                          children: [
                            for (DocumentModule item in listDocuments)
                              buildDocumentWidget(context, item),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: (document.titleFr!.length > 120)
                                    ? Text(
                                        document.titleFr!.substring(
                                                0,
                                                (document.titleFr!.length / 2)
                                                    .floor()) +
                                            '...',
                                        style: TextStyle(fontSize: 18))
                                    : Text(document.titleFr ?? "",
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
                                                  ViewOneDocument(document,
                                                      title, module)));
                                    }),
                              ],
                            )
                          ],
                        ),
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
