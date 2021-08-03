import 'dart:math';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';

// darkness vs lightness

bool darkMode;


// const Color THEMECOLOR = const Color(0xFFFFFF);

// Determines if the color should be white or black
determineColorThemeBackground() {
  if (darkMode) return const Color(0xFF404040);
  else return const Color(0xFFFFFFFF);
}
// Determines if the color should be white or black
determineColorThemeText() {
  if (darkMode) return const Color(0xFF474747);
  else return const Color(0xFFFFFFFF);
}
determineColorThemeTextInverse() {
  if (darkMode) return const Color(0xFFFFFFFF);
  else return const Color(0xFF474747);
}

// Determines if the color should be white or black
determineLightShadowRoundButton() {
  if (darkMode) return DARKERGREY;
  else return LIGHTERGREY;
}

// ----------------------------- Coaster Icon -----------------------------------
getCoasterIcon() {
  if (darkMode) return "assets/lightGreyIcons/coasterIconLightGrey.png";
  else return "assets/darkGreyIcons/coasterIconDarkGrey.png";
}
getCoasterIconLight() {
  return "assets/lightGreyIcons/coasterIconLightGrey.png";

}
getCoasterIconDark() {
 return "assets/darkGreyIcons/coasterIconDarkGrey.png";
}
// ----------------------------- Fonz Icon -----------------------------------
getFonzLogoIcon() {
  if (darkMode) return "assets/darkGreyIcons/fonzLogoDarkGreyF.png";
  else return "assets/lightGreyIcons/fonzLogoLightGreyF.png";
}
// ----------------------------- Queue Icon -----------------------------------
getQueueIcon() {
  if (darkMode) return "assets/darkGreyIcons/queueIconDarkGrey.png";
  else return "assets/lightGreyIcons/queueIconLightGrey.png";
}
// ----------------------------- Edit Icon -----------------------------------
getEditIcon() {
  if (darkMode) return "assets/lightGreyIcons/editIconLightGrey.png";
  else return "assets/darkGreyIcons/editIconDarkGrey.png";
}
getEditIconInverse() {
  if (darkMode) return "assets/darkGreyIcons/editIconDarkGrey.png";
  else return "assets/lightGreyIcons/editIconLightGrey.png";
}
getEditIconLight() {
 return "assets/lightGreyIcons/editIconLightGrey.png";
}
getEditIconDark() {
  return "assets/darkGreyIcons/editIconDarkGrey.png";
}
// ----------------------------- Disable Icon -----------------------------------
getDisableIcon() {
  if (darkMode) return "assets/lightGreyIcons/disableIconLightGrey.png";
  else return "assets/darkGreyIcons/disableIconDarkGrey.png";
}
// ----------------------------- Pause Icon -----------------------------------
getPauseIcon() {
  if (darkMode) return "assets/lightGreyIcons/pauseIconLightGrey.png";
  else return "assets/darkGreyIcons/pauseIconDarkGrey.png";
}
// ----------------------------- Spotify Icon -----------------------------------
getSpotifyIcon() {
  // return "assets/fonzIcons/SpotifyBlack.png";
  if (darkMode) return "assets/darkGreyIcons/spotifyIconDarkGrey.png";
  else return "assets/lightGreyIcons/spotifyIconLightGrey.png";
}
getSpotifyIconLight() {
  return "assets/lightGreyIcons/spotifyIconLightGrey.png";
}

getSpotifyIconAmber() {
  return "assets/fonzIcons/spotifyIconAmber.png";
}
getSpotifyIconWhite() {
  return "assets/fonzIcons/spotifyIconWhite.png";
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

const Color SUCCESSGREEN =
const Color(0xFF55b519); //green

const Color AMAZONCOLOR =
const Color(0xFF122470); //blue

const Color DARKERGREY =
const Color(0xFF292929); //darker grey

const Color LIGHTERGREY =
const Color(0xFFB9B9B9); // lighter grey

const Color SPOTIFYGREEN =
const Color(0xFF1DB954);

Color SHADOWGREY = DARKERGREY.withOpacity(0.5);

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
const HEADINGSIX = 14.0;
const HEADINGSEVEN = 10.0;

const FONZFONTONE = 'MuseoSans-100';
const FONZFONTTWO = 'MuseoSans-300';
const FONZFONTTHREE = 'MuseoSans-500';
const FONZFONTFOUR = 'MuseoSans-700';

// ---------------------------Corner Radius-------------------------------------

const CORNERRADIUSBUTTON = 3.0;

// ---------------------------Component Sizes-----------------------------------

const COMPONENTWIDTH = 0.95;

// ---------------------------Swipe Speed---------------------------------------

const SWIPESPEED = 650;
const ERRORPAGELENGTH = 2500;
const SUCCESSPAGELENGTH = 1500;
const TIMEBEFORELAUNCHINGNFC = 750;

