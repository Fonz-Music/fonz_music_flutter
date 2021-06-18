import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

// darkness vs lightness

bool darkMode;

// const Color THEMECOLOR = const Color(0xFFFFFF);

// Determines if the color should be white or black
determineColorThemeBackground() {
  if (darkMode) return const Color(0xFF2C2C2E);
  else return const Color(0xFFE5E5EA);
}
// Determines if the color should be white or black
determineColorThemeText() {
  if (darkMode) return const Color(0xFFE5E5EA);
  else return const Color(0xFF2C2C2E);
}

getCoasterIcon() {
  if (darkMode) return "assets/darkGreyIcons/coasterIconDarkGrey.png";
  else return "assets/lightGreyIcons/coasterIconLightGrey.png";
}

getFonzLogoIcon() {
  if (darkMode) return "assets/darkGreyIcons/fonzLogoDarkGreyF.png";
  else return "assets/lightGreyIcons/fonzLogoLightGreyF.png";
}
getQueueIcon() {
  if (darkMode) return "assets/darkGreyIcons/queueIconDarkGrey.png";
  else return "assets/lightGreyIcons/queueIconLightGrey.png";
}
getEditIcon() {
  if (darkMode) return "assets/darkGreyIcons/editIconDarkGrey.png";
  else return "assets/lightGreyIcons/editIconLightGrey.png";
}
getDisableIcon() {
  if (darkMode) return "assets/darkGreyIcons/disableIconDarkGrey.png";
  else return "assets/lightGreyIcons/disableIconLightGrey.png";
}
getPauseIcon() {
  if (darkMode) return "assets/darkGreyIcons/pauseIconDarkGrey.png";
  else return "assets/lightGreyIcons/pauseIconLightGrey.png";
}
getRockOnIcon() {
  if (darkMode) return "assets/darkGreyIcons/rockOnIconDarkGrey.png";
  else return "assets/lightGreyIcons/rockOnIconLightGrey.png";
}
getSpotifyIcon() {
  // return "assets/fonzIcons/SpotifyBlack.png";
  if (darkMode) return "assets/darkGreyIcons/spotifyIconDarkGrey.png";
  else return "assets/lightGreyIcons/spotifyIconLightGrey.png";
}

// -------------------Colors-------------------------------------

const Color AMBER =
const Color(0xFFff9425); //light orange

const Color DARKAMBER =
const Color(0xFFffca92); //darker orange

const Color LILAC =
const Color(0xFFC894A6); //lilac

const Color DARKLILAC =
const Color(0xFFd9c4dc); //darker lilac

const Color SPOTIFYGREEN =
const Color(0xFF55b519); //green

const Color AMAZONCOLOR =
const Color(0xFF122470); //blue

const Color DARKERGREY =
const Color(0xFF292929); //darker grey

const Color LIGHTERGREY =
const Color(0xFFB9B9B9); // lighter grey

//const Color(0xFF55b519); //green
//const Color(0xFFf0a555); //light orange
//const Color(0xFFFF7300); //dark orange
//const Color(0xFFeb4132); //red
//const Color(0xFF172470); //navy
//const Color(0xFF55b519); //green
//const Color(0xFFFFD555); //yellow


// ---------------------------Fonts---------------------------------------

const HEADINGONE = 56.0;
const HEADINGTWO = 40.0;
const HEADINGTHREE = 24.0;
const HEADINGFOUR = 24.0;
const HEADINGFIVE = 18.0;

const FONZFONTONE = 'MuseoSans-100';
const FONZFONTTWO = 'MuseoSans-300';
const FONZFONTTHREE = 'MuseoSans-500';
const FONZFONTFOUR = 'MuseoSans-700';

// ---------------------------Swipe Speed---------------------------------------

const SWIPESPEED = 650;
const ERRORPAGELENGTH = 2500;
const SUCCESSPAGELENGTH = 1500;
const TIMEBEFORELAUNCHINGNFC = 750;

