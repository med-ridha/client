import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:juridoc/widgets/sendButton.dart';

class ViewOneDocument extends StatefulWidget {
  DocumentModule document;
  ViewOneDocument(this.document);
  @override
  ViewOneDocumentState createState() => ViewOneDocumentState(document);
}

class ViewOneDocumentState extends State<ViewOneDocument>
    with TickerProviderStateMixin {
  DocumentModule document;
  ViewOneDocumentState(this.document);

  @override
  void initState() {
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
                  height: 60,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: SecondBarUi("", false, fontSize: 16),
                ),
                SizedBox(
                  height: 30,
                ),
                viewDocumentWidget(context, document),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget viewDocumentWidget(BuildContext context, DocumentModule document) {
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
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(document.titleFr ?? "",
                              style: TextStyle(fontSize: 18)),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child: Text(document.bodyFr ?? ""))
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
