import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/screens/viewOneDocument.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/addButton.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/widgets/remove_button.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:juridoc/widgets/sendButton.dart';
import 'package:overlay_support/overlay_support.dart';

class Favoris extends StatefulWidget {
  List<String> listDocumentIds;
  String email;
  String name;
  Favoris(this.listDocumentIds, this.email, this.name);
  @override
  FavorisState createState() => FavorisState(listDocumentIds, email, name);
}

class FavorisState extends State<Favoris> with TickerProviderStateMixin {
  List<String> listDocumentIds;
  String email;
  String name;
  bool waiting = false;
  List<DocumentModule> listDocuments = [];
  FavorisState(this.listDocumentIds, this.email, this.name);
  @override
  void initState() {
    super.initState();
    waiting = true;
    DocumentModule.getListFavored(email).then((result) {
      setState(() {
        listDocumentIds = result;
        DocumentModule.getListDocuments(listDocumentIds).then((result) => {
              setState(() {
                listDocuments = result;
                waiting = false;
              })
            });
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
                        child: SecondBarUi(
                            (UserPrefs.getEmail() == email)
                                ? "Mes Favoris"
                                : name + " Favoris",
                            false),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: (listDocuments.length > 0)
                            ? <Widget>[
                                for (DocumentModule item in listDocuments)
                                  buildDocumentWidget(context, item),
                              ]
                            : [
                                Container(
                                  //height: 60,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: (waiting)
                                      ? SpinKitDualRing(
                                          size: 40, color: Colors.green)
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  (UserPrefs.getEmail() ==
                                                          email)
                                                      ? "Le dossier est vide, veuillez ajouter au moins un document"
                                                      : "Le dossier est vide",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                ),
                              ],
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                Column(
                                  children: [
                                    (UserPrefs.getEmail() == email)
                                        ? AddButton(
                                            color: Colors.red,
                                            icon: Icons.heart_broken_sharp,
                                            func: () async {
                                              bool result = await UserModule
                                                  .removeFromFavorite(
                                                      document.id ?? "");
                                              if (result) {
                                                showSimpleNotification(
                                                    Text(
                                                        "removed from Favorite",
                                                        style: TextStyle()),
                                                    duration:
                                                        Duration(seconds: 2),
                                                    foreground: Colors.white,
                                                    background:
                                                        Colors.greenAccent);
                                                setState(() {
                                                  listDocumentIds = UserPrefs
                                                      .getListFavorit();
                                                  DocumentModule
                                                          .getListDocuments(
                                                              listDocumentIds)
                                                      .then((result) => {
                                                            setState(() {
                                                              listDocuments =
                                                                  result;
                                                            })
                                                          });
                                                });
                                              } else {
                                                showError(
                                                    'something went wrong');
                                              }
                                            })
                                        : Container(),
                                    SizedBox(height: height * 0.02),
                                    SendButton(
                                        icon: Icons.arrow_forward_ios_sharp,
                                        func: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      ViewOneDocument(
                                                          document,
                                                          DocumentModule
                                                              .getCategorieName(
                                                                  document.moduleId ??
                                                                      '',
                                                                  document.categoryId ??
                                                                      ''),
                                                          DocumentModule
                                                              .getModuleName(
                                                                  document.moduleId ??
                                                                      ''))));
                                        }),
                                  ],
                                )
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

  void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent);
  }
}
