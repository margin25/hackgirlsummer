import 'package:flutter/material.dart';
import 'home/home.dart';
import 'info.dart';
import 'profile.dart';

//constants
const String page1 = "Info";
const String page2 = "Home";
const String page3 = "Profile";

class MyAppLoader extends StatefulWidget {
  MyAppLoader({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAppLoaderState createState() => _MyAppLoaderState();
}

class _MyAppLoaderState extends State<MyAppLoader> {
  List<Widget> _pages;
  Widget _page1;
  Widget _page2;
  Widget _page3;

  int _currentIndex;
  Widget _currentPage;

  @override
  void initState() {
    super.initState();

    _page1 = Info();
    _page2 = Home();
    _page3 = Profile();

    _pages = [_page1, _page2, _page3];

    _currentIndex = 1;
    _currentPage = _page2;
  }

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => changeTab(index),
          currentIndex: _currentIndex,
          selectedItemColor: Colors.red[400],
          items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconData(59535, fontFamily: 'MaterialIcons')),
                title: Text(page1),
              ),
              BottomNavigationBarItem(
                 icon: Icon(Icons.home),
                title: Text(page2),
              ),
              BottomNavigationBarItem(
                icon: Icon(IconData(59558, fontFamily: 'MaterialIcons')),
                title: Text(page3),
              ),
            ],
      )
    );
  }
}