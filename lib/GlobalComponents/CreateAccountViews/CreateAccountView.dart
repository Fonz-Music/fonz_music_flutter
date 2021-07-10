import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

import 'SignInSignUpViews/SignInView.dart';
import 'SignInSignUpViews/SignUpView.dart';

PageController _emailController = PageController(initialPage: 1);



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
    return Container(
        // height: height * .9,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//        height: height ,
        child: Center(
          child: Column(
//                    height: height * .5,
//            width: width * .75,
              children:[
                Spacer(),
            ToggleSignInSignOut(),
            Container(
              height: height * .75,
              // width: width * .75,
              child: PageView(
              controller: _emailController,
              scrollDirection: Axis.horizontal,
              children: [SignInView(), SignUpView()],

          ),

            ),
                Spacer(),
              ]
          )
        ));
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
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                color: determineColorThemeTextInverse(),
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
              log("setting staet");
            });
          }
        ),
        MaterialButton(
            child: Text(
              "sign up",
              style: new TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w300,
                  color: determineColorThemeTextInverse(),
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

                log("setting staet");
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
    if (_emailController.page == 0) {
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
    if (_emailController.page == 1) {
      return TextDecoration.underline;
    }
    else return TextDecoration.none;
  }

}
