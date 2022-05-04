import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:juridoc/module/DocumentModule.dart';
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/module/UserModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:juridoc/widgets/sendButton.dart';
import 'package:overlay_support/overlay_support.dart';

class ViewOneDocument extends StatefulWidget {
  DocumentModule document;
  String category;
  String module;
  ViewOneDocument(this.document, this.category, this.module);
  @override
  ViewOneDocumentState createState() =>
      ViewOneDocumentState(document, category, module);
}

class ViewOneDocumentState extends State<ViewOneDocument>
    with TickerProviderStateMixin {
  DocumentModule document;
  String category;
  String module;
  bool isFavorite = false;
  bool waiting = false;
  bool isFrench = true;
  List<String> listModules = [];
  ViewOneDocumentState(this.document, this.category, this.module);

  void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent);
  }

  @override
  void initState() {
    super.initState();
    waiting = true;
    
    UserModule.getModules().then((result) async => {
          await Future.delayed(Duration(milliseconds: 250), () {
            setState(() {
              isFavorite = UserPrefs.getListFavorit().contains(document.id);
              listModules = result;
              waiting = false;
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    double safePadding = MediaQuery.of(context).padding.top;
    return RefreshIndicator(
      onRefresh: () async {
        waiting = true;
        setState(() {
          isFavorite = UserPrefs.getListFavorit().contains(document.id);
        });

        UserModule.getModules().then((result) async => {
              await Future.delayed(Duration(milliseconds: 250), () {
                setState(() {
                  listModules = result;
                  waiting = false;
                });
              })
            });
      },
      child: Stack(fit: StackFit.expand, children: [
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
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
                          child: SecondBarUi("", false,
                              fontSize: 16,
                              lang: (listModules.contains(module)),
                              langIcon: Icons.language_sharp, langFunc: () {
                            setState(() {
                              isFrench = !isFrench;
                            });
                          },
                              like: (listModules.contains(module)),
                              func: (!isFavorite)
                                  ? () async {
                                      showAlertDialog(
                                          context, "ajoute au favoris?",
                                          () async {
                                        bool result =
                                            await UserModule.addToFavorite(
                                                document.id ?? "");
                                        if (result) {
                                          showSimpleNotification(
                                              Text(
                                                  "Le document a ete ajoue aux favoris",
                                                  style: TextStyle()),
                                              duration: Duration(seconds: 2),
                                              foreground: Colors.white,
                                              background: Colors.greenAccent);
                                          setState(() {
                                            isFavorite =
                                                UserPrefs.getListFavorit()
                                                    .contains(document.id);
                                          });
                                        } else {
                                          showError('something went wrong');
                                        }
                                      });
                                    }
                                  : () async {
                                      showAlertDialog(
                                          context, "supprimer du favoris?",
                                          () async {
                                        bool result =
                                            await UserModule.removeFromFavorite(
                                                document.id ?? "");
                                        if (result) {
                                          showSimpleNotification(
                                              Text("removed from Favorite",
                                                  style: TextStyle()),
                                              duration: Duration(seconds: 2),
                                              foreground: Colors.white,
                                              background: Colors.greenAccent);
                                          setState(() {
                                            isFavorite =
                                                UserPrefs.getListFavorit()
                                                    .contains(document.id);
                                          });
                                        } else {
                                          showError('something went wrong');
                                        }
                                      });
                                    },
                              likeIcon: (isFavorite)
                                  ? Icons.heart_broken_sharp
                                  : Icons.favorite_sharp),
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
                            viewDetails(context, document),
                            (listModules.contains(module))
                                ? viewTitle(context, document)
                                : Container(),
                            (listModules.contains(module))
                                ? viewDocumentWidget(context, document)
                                : Container(),
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
      ]),
    );
  }

  Widget viewDetails(BuildContext context, DocumentModule document) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: (waiting)
                ? [
                    Container(
                        height: height * 0.1,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: SpinKitDualRing(size: 40, color: Colors.green))
                  ]
                : [
                    Container(
                        width: width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: (listModules.contains(module))
                              ? <Widget>[
                                  SizedBox(height: height * 0.02),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Reference: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                      Expanded(
                                          child: Text(document.ref ?? "",
                                              style: TextStyle(fontSize: 18))),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Publie le: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                      Text(document.dateP!.split("T")[0],
                                          style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Module: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                      Text(module,
                                          style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Categorie: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16)),
                                      Text(category,
                                          style: TextStyle(fontSize: 18)),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.04),
                                ]
                              : <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Text(
                                            "pay wall",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.redAccent,
                                                fontSize: 20),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        "you need to by a subscription to view this",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        )),
                                                  ],
                                                ),
                                                Text("document",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                        )),
                  ],
          ),
          SizedBox(height: height * 0.02),
        ],
      ),
    );
  }

  Widget viewTitle(BuildContext context, DocumentModule document) {
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
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        Directionality(
                            textDirection: (isFrench)
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                            child: Text(
                                (isFrench)
                                    ? document.titleFr ?? ""
                                    : document.titleAr ?? "",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900))),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  )),
            ],
          ),
          SizedBox(height: height * 0.04),
        ],
      ),
    );
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
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Directionality(
                              textDirection: (isFrench)
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                              child: Text((isFrench)
                                  ? document.bodyFr ?? ""
                                  : document.bodyAr ?? ""),
                            ))
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

  showAlertDialog(BuildContext context, String text, Future<void> func()) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text(text),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
                return;
              },
            ),
            TextButton(
              child: Text("Continue"),
              onPressed: () {
                func();
                Navigator.of(context).pop();
                return;
              },
            ),
          ],
        );
      },
    );
  }
}
