import 'package:animate_do/animate_do.dart';
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
              body: SingleChildScrollView(
                child: Column(
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
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    getText(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    getText1(),
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
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    juridoc(),
                                    juridoc1(),
                                    text(),
                                    juridoc2(),
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
            )
          ]),
        ),
    );
  }

  Widget juridoc() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Juridoc.tn',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Widget juridoc1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Juridoc est la plateforme indispensable s’adressant aux : DAF, DRH, Experts-Comptables, commissaires aux comptes, Responsables juridiques, Avocats, ...',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 17,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
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

  Widget juridoc2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'JURIDOC vous donne l accès à une documentation exhaustive et continuellement à jour',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 17,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          height: 200,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              moduleWidget(
                context,
                "Fiscal",
                "images/Fiscal.png",
                ModuleModule.getNum("Fiscal", listModules).toString(),
              ),
              moduleWidget(
                context,
                "Social",
                "images/Social.png",
                ModuleModule.getNum("Social", listModules).toString(),
              ),
              moduleWidget(
                context,
                "Investissement",
                "images/Investissement.png",
                ModuleModule.getNum("Investissement", listModules).toString(),
              ),
              moduleWidget(
                context,
                "Banque-Finances-Assurances",
                "images/Banque-Finances-Assurances.png",
                ModuleModule.getNum("Banque-Finances-Assurances", listModules)
                    .toString(),
              ),
              moduleWidget(
                context,
                "BIBUS",
                "images/BIBUS.png",
                ModuleModule.getNum("BIBUS", listModules).toString(),
              ),
              moduleWidget(
                context,
                "Collectivités locales",
                "images/Collectivites locales.png",
                ModuleModule.getNum("Collectivites locales", listModules)
                    .toString(),
              ),
              moduleWidget(
                context,
                "Veille Juridique",
                "images/Veille Juridique.png",
                ModuleModule.getNum("Veille Juridique", listModules).toString(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(18.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          onChanged: (String? value) {
                            searchTerm = value ?? '';
                          },
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Recherchez par mot clé',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
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
                          //showSearch(context: context, delegate: Search(widget.list));
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

  Widget moduleWidget(
      BuildContext context, String name, String image, String count) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

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
            height: height,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "$count Documents",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Image.asset(
                    image,
                    height: double.infinity,
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
