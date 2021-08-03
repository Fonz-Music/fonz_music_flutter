import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/ApiFunctions/GetVersionApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/CoreUserAttributes.dart';
import 'package:fonz_music_flutter/MainTabs/HostTab.dart';
import 'package:fonz_music_flutter/MainTabs/SearchTab.dart';
import 'package:fonz_music_flutter/MainTabs/SettingsPage.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'MustUpdateApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await FlutterCrashlytics().initialize();
  // this enables crashlytics
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // runApp(MyApp());

  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  var version = packageInfo.version;

  // log("part 1 is " + partsOfVersion[0] + "part 2 is " + partsOfVersion[1] + "part 3 is " + partsOfVersion[2]);

  log("version " + version.runtimeType.toString());
  var platform;
  if (Platform.isIOS) {
    platform = "iOS";
  }
  else {
    platform = "Android";
  }

  var versionResponse = await GetVersionApi.sendVersion(platform);

  if (versionResponse == "NO_INTERNET") {
    log("thre is no wifi");
  }
  else {
    determineWhichVerion(version, versionResponse);
  }


  // runApp(FonzMusicApp());
}

determineWhichVerion(var version, var versionResponse) {
  var partsOfCurrentAppVersion = version.split(".");
  var partsOfMinAppVersion = versionResponse.split(".");

  if (Platform.isIOS) {
    var firstCurrentNumber = int.parse(partsOfCurrentAppVersion[0]);
    var secondCurrentNumber = int.parse(partsOfCurrentAppVersion[1]);

    var firstMinNumber = int.parse(partsOfMinAppVersion[0]);
    var secondMinNumber = int.parse(partsOfMinAppVersion[1]);

    var currentNumber = (firstCurrentNumber * 100) + secondCurrentNumber;
    var minNumber = (firstMinNumber * 100) + secondMinNumber;

    log("currentNumber = " + currentNumber.toString() + " , minNumber = " + minNumber.toString());

    if (currentNumber >= minNumber) {
      log("greater ");
      runApp(FonzMusicApp());
    }
    else {
      log("less than");
      // runApp(FonzMusicApp());
      runApp(MustUpdateApp());
    }
  }
  else {
    var firstCurrentNumber = int.parse(partsOfCurrentAppVersion[0]);
    var secondCurrentNumber = int.parse(partsOfCurrentAppVersion[1]);
    var thirdCurrentNumber = int.parse(partsOfCurrentAppVersion[2]);

    var firstMinNumber = int.parse(partsOfMinAppVersion[0]);
    var secondMinNumber = int.parse(partsOfMinAppVersion[1]);
    var thirdMinNumber = int.parse(partsOfMinAppVersion[2]);

    var currentNumber = (firstCurrentNumber * 10000) + (secondCurrentNumber * 100) + thirdCurrentNumber;
    var minNumber = (firstMinNumber * 10000) + (secondMinNumber * 100) + thirdMinNumber;

    log("currentNumber = " + currentNumber.toString() + " , minNumber = " + minNumber.toString());

    if (currentNumber >= minNumber) {
      log("greater ");
      runApp(FonzMusicApp());
    }
    else {
      log("less than");
      // runApp(FonzMusicApp());
      runApp(MustUpdateApp());
    }
  }

}

class FonzMusicApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

int currentTab = 1;
CoreUserAttributes userAttributes = CoreUserAttributes();


class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  // TabController _tabController = TabController(
  //   length: 3,
  //   initialIndex: 0,
  // );

  SharedPreferences localPreferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      localPreferences = prefs;
      userAttributes.setAttributes();
      setState(() {

      } );
    });
  }

  refresh() async {
    await userAttributes.setAttributes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    darkMode = brightnessValue == Brightness.dark;

    List<Widget> _children = [
      HostTab(),
      SearchTab(currentTab: currentTab, notifyParent: refresh),
      SettingsPage(notifyParent: refresh,)
    ];



    return
       DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: _children[currentTab], // new
          // body: ,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTab,
            selectedItemColor: AMBER,
            unselectedItemColor: determineColorThemeTextInverse(),
            backgroundColor: determineColorThemeBackground(),
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
      currentTab = index;
    });
  }
}
