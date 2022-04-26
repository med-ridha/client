import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/screens/viewOneCategory.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/widgets/secondBarUI.dart';
import 'package:juridoc/widgets/sendButton.dart';

class ViewCategories extends StatefulWidget {
  final String title;
  final List<Category> listCategory;
  ViewCategories(this.title, this.listCategory);
  @override
  ViewCategoriesState createState() => ViewCategoriesState(title, listCategory);
}

class ViewCategoriesState extends State<ViewCategories>
    with TickerProviderStateMixin {
  String title;
  List<Category> listCategory;
  ViewCategoriesState(this.title, this.listCategory);
  @override
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
                Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        for (Category item in listCategory)
                          (item.documentsIds!.length > 0)
                              ? buildCategoryWidget(context, item.name ?? "",
                                  item.documentsIds ?? [])
                              : Container(),
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

  Widget buildCategoryWidget(
      BuildContext context, String name, List<String> documentIds) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(documentIds.length.toString(),
                    style: TextStyle(fontSize: 18)),
                SizedBox(width: width * 0.02),
                SendButton(
                    icon: Icons.arrow_forward_ios_sharp,
                    func: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ViewOneCategory(name, documentIds)));
                    }),
              ],
            )
          ],
        ),
        SizedBox(height: height * 0.02)
      ],
    ));
  }
}
