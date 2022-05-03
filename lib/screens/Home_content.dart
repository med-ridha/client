import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juridoc/module/ModuleModule.dart';
import 'package:juridoc/module/UserPrefs.dart';
import 'package:juridoc/screens/search_result.dart';
import 'package:juridoc/screens/viewCategories.dart';
import 'package:juridoc/theme.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:overlay_support/overlay_support.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent>
    with TickerProviderStateMixin {
  List<ModuleModule> listModules = [];

  String searchTerm = "";

  @override
  void initState() {
    super.initState();
    ModuleModule.getListModules().then((result) {
      setState(() {
        listModules = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () async {
        ModuleModule.getListModules().then((result) {
          setState(() {
            listModules = result;
          });
        });
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
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
            body:
                // SingleChildScrollView(
                //   child:
                Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white60,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                getSearchBarUI(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                juridoc1(),
                                text(),
                                moduleWidget(context),
                                SizedBox(height: 15)
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
          // )
        ]),
      ),
    );
  }

  Widget juridoc1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  'Juridoc est la plateforme indispensable s’adressant aux : DAF, DRH, Experts-Comptables, commissaires aux comptes, Responsables juridiques, Avocats, ...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    letterSpacing: 0.27,
                    color: DesignCourseAppTheme.darkerText,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget text() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Restez à jour !',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(18.0)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, bottom: 5),
                        child: TextFormField(
                          onChanged: (String? value) {
                            searchTerm = value ?? '';
                          },
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (String? value) {
                            if (value != null) {
                              if (value.length > 3) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => Search(
                                          "?search=$searchTerm&email=" +
                                              (UserPrefs.getEmail() ?? "")),
                                    ));
                              } else {
                                showError("atleast 3 letters are requried!");
                              }
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Recherchez par mot clé',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                            ),
                            helperStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w200,
                              fontSize: 14,
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: IconButton(
                        onPressed: () {
                          if (searchTerm.length > 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Search(
                                      "?search=$searchTerm&email=" +
                                          (UserPrefs.getEmail() ?? "")),
                                ));
                          } else {
                            showError("atleast 3 letters are requried!");
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getText() {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 600),
      child: Text(
        "DOCUMENTS JURIDIQUES À PORTÉE DE MAIN",
        style: TextStyle(
            color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget getText1() {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 600),
      child: Text(
        "Votre plateforme de documentations juridiques",
        style: TextStyle(
            color: kSecondaryColor, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget moduleWidget(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CarouselSlider(
                items: [
                  moduleWidget2(
                    context,
                    "Fiscal",
                    "Fiscal",
                    ModuleModule.getNum("Fiscal", listModules).toString(),
                  ),
                  moduleWidget2(
                    context,
                    "Social",
                    "Social",
                    ModuleModule.getNum("Social", listModules).toString(),
                  ),
                  moduleWidget2(
                    context,
                    "Investissement",
                    "Investissement",
                    ModuleModule.getNum("Investissement", listModules)
                        .toString(),
                  ),
                  moduleWidget2(
                    context,
                    "Banque-Finances-Assurances",
                    "Banque-Finances-Assurances",
                    ModuleModule.getNum(
                            "Banque-Finances-Assurances", listModules)
                        .toString(),
                  ),
                  moduleWidget2(
                    context,
                    "BIBUS",
                    "BIBUS",
                    ModuleModule.getNum("BIBUS", listModules).toString(),
                  ),
                  moduleWidget2(
                    context,
                    "Collectivités locales",
                    "Collectivites locales",
                    ModuleModule.getNum("Collectivites locales", listModules)
                        .toString(),
                  ),
                  moduleWidget2(
                    context,
                    "Veille Juridique",
                    "Veille Juridique",
                    ModuleModule.getNum("Veille Juridique", listModules)
                        .toString(),
                  ),
                ],
                options: CarouselOptions(
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                ))
          ],
        ));
  }

  Widget moduleWidget2(
      BuildContext context, String name, String image, String count) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ViewCategories(
                    name, ModuleModule.getCategories(name, listModules)),
              ));
        },
        child: Container(
            height: 150,
            width: 300,
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
                        "images/$image.png",
                        height: 90,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Text(
                          name.split("-").join(" "),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        count,
                        style: const TextStyle(
                            fontSize: 19, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  void showError(String error) {
    showSimpleNotification(Text(error, style: TextStyle()),
        duration: Duration(seconds: 3),
        foreground: Colors.white,
        background: Colors.redAccent);
  }
}
