import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:juridoc/screens/advanced_search.dart';
import 'package:juridoc/screens/profile.dart';
import 'package:juridoc/screens/Home_content.dart';

class HomeScreen extends StatefulWidget {
  int startPage = 0;
  HomeScreen(this.startPage) : super();
  @override
  HomeScreenState createState() => HomeScreenState(startPage);
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int startPage = 0;
  HomeScreenState(this.startPage);
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  void initState() {
    super.initState();
    setState(() {
      _currentPage = startPage;
      _pageController.initialPage = _currentPage;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: PageView(
          controller: _pageController,
          children: [
            HomeContent(),
            AdvancedSearch(),
            ProfileScreen(),
          ],
          onPageChanged: (index) {
            setState(() => _currentPage = index);
          },
        ),
        bottomNavigationBar: BottomBar(
          selectedIndex: _currentPage,
          onTap: (int index) {
            _pageController.animateToPage(index,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 750));
            setState(() => _currentPage = index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
              icon: Icon(Icons.home),
              title: Text('Acceuil'),
              activeColor: Colors.blue,
            ),
            BottomBarItem(
              icon: Icon(Icons.search),
              title: Text('recherche'),
              activeColor: Colors.red,
              darkActiveColor: Colors.red.shade400, // Optional
            ),
            BottomBarItem(
              icon: Icon(Icons.person),
              title: Text('profile'),
              activeColor: Colors.greenAccent.shade700,
              darkActiveColor: Colors.greenAccent.shade400, // Optional
            ),
          ],
        ),
      ),
    ]);
  }
}
