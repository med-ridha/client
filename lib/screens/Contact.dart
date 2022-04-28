import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:juridoc/widgets/app_Bar_ui.dart';
import 'package:juridoc/theme.dart';

class Contact extends StatefulWidget {
  @override
  ContactState createState() => ContactState();
}

class ContactState extends State<Contact> with TickerProviderStateMixin {
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
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                child: Column(
                  children: [
                    AppBarUI(),
                    Container(
                      height: 680,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text1(),
                            adresse(context),
                            phone1(context),
                            phone2(context),
                            mail(context),
                            FB(),
                            TW(),
                            LN(),
                          ],
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

  Widget FB() {
    return Row(
      children: <Widget>[
        Container(
          height: 60,
          width: 150,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(color: kPrimaryColor),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {},
                  icon: Icon(
                    Icons.facebook_rounded,
                  ),
                  label: Text('Facebook'),
                ),
              ]),
        ),
      ],
    );
  }

  Widget TW() {
    return Row(
      children: <Widget>[
        Container(
          height: 60,
          width: 150,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(color: kPrimaryColor),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {},
                  icon: Icon(Icons.facebook_rounded),
                  label: Text(
                    'Twitter',
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  Widget LN() {
    return Row(
      children: <Widget>[
        Container(
          height: 60,
          width: 150,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(color: kPrimaryColor),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {},
                  icon: Icon(
                    Icons.facebook_rounded,
                  ),
                  label: Text(
                    'Linked In',
                  ),
                ),
              ]),
        ),
      ],
    );
  }
}

Widget adresse(BuildContext context) {
  return new Container(
    height: 140.0,
    margin: new EdgeInsets.all(10.0),
    decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        gradient: new LinearGradient(
            colors: [kPrimaryColor, kSecondaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp)),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Icon(
            Icons.location_on_outlined,
            color: Colors.white70,
          ),
        ),
        new Expanded(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 8.0,
            ),
            new Text(
              ' Immeuble Titanium Bureau N°4  - 1053 Les Berges du Lac 2',
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
            ),
            new Text(
              'Tunis',
              style: new TextStyle(fontSize: 18.0, color: Colors.white70),
            ),
          ],
        )),
      ],
    ),
  );
}

Widget phone1(BuildContext context) {
  return new Container(
    height: 75.0,
    margin: new EdgeInsets.all(10.0),
    decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        gradient: new LinearGradient(
            colors: [kPrimaryColor, kSecondaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp)),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Icon(
            Icons.phone,
            color: Colors.white70,
          ),
        ),
        new Expanded(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 8.0,
            ),
            new Text(
              '70 039 081',
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
            ),
            new Text(
              'Fix',
              style: new TextStyle(fontSize: 18.0, color: Colors.white70),
            ),
          ],
        )),
      ],
    ),
  );
}

Widget phone2(BuildContext context) {
  return new Container(
    height: 75.0,
    margin: new EdgeInsets.all(10.0),
    decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        gradient: new LinearGradient(
            colors: [kPrimaryColor, kSecondaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp)),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Icon(
            Icons.phone,
            color: Colors.white70,
          ),
        ),
        new Expanded(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 8.0,
            ),
            new Text(
              '99 218 191',
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
            ),
            new Text(
              'Mobile',
              style: new TextStyle(fontSize: 18.0, color: Colors.white70),
            ),
          ],
        )),
      ],
    ),
  );
}

Widget mail(BuildContext context) {
  return new Container(
    height: 75.0,
    margin: new EdgeInsets.all(10.0),
    decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        gradient: new LinearGradient(
            colors: [kPrimaryColor, kSecondaryColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp)),
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.only(left: 10.0, right: 10.0),
          child: new Icon(
            Icons.mail_outline,
            color: Colors.white70,
          ),
        ),
        new Expanded(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(
              height: 8.0,
            ),
            new Text(
              'contact@juridoc.tn',
              style: new TextStyle(
                  fontSize: 20.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
            ),
            new Text(
              'E-mail',
              style: new TextStyle(fontSize: 18.0, color: Colors.white70),
            ),
          ],
        )),
      ],
    ),
  );
}

Widget Text1() {
  return FadeInUp(
    delay: const Duration(milliseconds: 600),
    duration: const Duration(milliseconds: 600),
    child: Text(
      "CONTACTEZ NOUS",
      style: titleText3,
    ),
  );
}
