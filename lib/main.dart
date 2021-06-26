import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/MainTabs/SearchTab.dart';
import 'package:fonz_music_flutter/MainTabs/SettingsPage.dart';

import 'GlobalComponents/FrontEnd/FrontEndConstants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 1;

  // TabController _tabController = TabController(
  //   length: 3,
  //   initialIndex: 0,
  // );

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    darkMode = brightnessValue == Brightness.dark;

    List<Widget> _children = [
      HostTab(),
      SearchTab(currentTab: _currentIndex, notifyParent: refresh),
      SettingsPage()
    ];



    return
       DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _children[_currentIndex], // new
          // body: ,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: AMBER,
            onTap: onTabTapped,// this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                label: 'host',
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.search),
                label: 'search',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'settings',
              )
            ],
          ),
        ),
            );

  }

  // updates the currentIndex
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
