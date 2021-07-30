import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

import 'SignInSignUpViews/SignInView.dart';
import 'SignInSignUpViews/SignUpView.dart';

PageController _emailController = PageController(initialPage: 1);
bool onSignUp = true;



class CreateAccountView extends StatefulWidget {
  @override
  _CreateAccountViewState createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;
    return Stack(
      children: [
        Container(
          color: DARKERGREY,
        ),
        Opacity(
          child: Column(
            children: [

              Image(
                image: AssetImage("assets/fonzIcons/peoplePartyingBackdrop.jpg"),
                // width: width,
                // height: height * 0.95,
                fit: BoxFit.fitHeight,

              ),
              // Spacer(),
            ],
          ),
          opacity: 0.4,
        ),
        Container(
            // height: height * .9,
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
//        height: height ,
            child: Center(
              child: Column(
//                    height: height * .5,
//            width: width * .75,
                  children:[
                    // Spacer(),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 80,
                  width: 40,
                  child: Image(
                    image: AssetImage("assets/fonzIcons/fonzLogoGradiant.png"),
                  ),
                ),
                ToggleSignInSignOut(),
                Container(
                  height: height * .72,
                  // width: width * .72,
                  child: PageView(
                  controller: _emailController,
                  scrollDirection: Axis.horizontal,
                  children: [SignInView(), SignUpView()],

              ),

                ),
                    Spacer(),
                  ]
              )
            )),
      ],
    );
  }

  Widget ToggleSignInSignOut() {
    return Row(
      children: [
        Spacer(),
        MaterialButton(
          child: Text(
            "sign in",
            style: new TextStyle(
                fontFamily: FONZFONTONE,
                fontSize: 16.0,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                decoration: determineIfSignInButtonHasUnderline(),
                decorationColor: AMBER
            ),
            textAlign: TextAlign.center,
          ),
          onPressed: () {
            // _emailController.animateToPage(0,
            //     duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            _emailController.jumpToPage(0);
            setState(() {
              onSignUp = false;
            });
          }
        ),
        MaterialButton(
            child: Text(
              "sign up",
              style: new TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  decoration: determineIfSignUpButtonHasUnderline(),
                  decorationColor: AMBER
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              // _emailController.animateToPage(1,
              //     duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              _emailController.jumpToPage(1);
              setState(() {
                onSignUp = true;
              });
            }
        ),
        Spacer(),
      ],
    );
  }

  // determineIfSignInButtonHasUnderline() {
  //   if (_emailController == 0) {
  //     return AMBER;
  //   }
  //   else return Colors.transparent;
  // }
  determineIfSignInButtonHasUnderline() {
    if (!onSignUp) {
      return TextDecoration.underline;
    }
    else return TextDecoration.none;
  }


  // determineIfSignUpButtonHasUnderline() {
  //   if (_emailController == 1) {
  //     return AMBER;
  //   }
  //   else return Colors.transparent;
  // }
  determineIfSignUpButtonHasUnderline() {
    if (onSignUp) {
      return TextDecoration.underline;
    }
    else return TextDecoration.none;
  }



}
