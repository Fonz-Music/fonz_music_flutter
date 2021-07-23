

import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

launchShop() async {
  var url = "https://www.fonzmusic.com/buy";
  if (await canLaunch(url))
  await launch(url);
  else
  // can't launch url, there is some error
  throw "Could not launch $url";
  log("pressed sign out");
}