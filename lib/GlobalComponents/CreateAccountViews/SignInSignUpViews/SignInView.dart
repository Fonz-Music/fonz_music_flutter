import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/ApiFunctions/UserEndpoints/AuthApi.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardView.dart';

import '../../../main.dart';


final _signInKey = GlobalKey<FormState>();

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  String _email;
  String _password;
  String _errorMessage;
  bool errorOnPage = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInKey,
      child: Column(children: [
        ShowEmailInputSignIn(),
        ShowPasswordInputSignIn(),
        ShowForgotPasswordButton(),
        // OrAppleOrGoogle(),
        ShowSignInButton(),

      ]),
    );
  }

  Widget ShowEmailInputSignIn() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 50,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: Colors.white,
            shadowDarkColor: determineColorThemeTextInverse()
        ),
        child: TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          style: TextStyle(
            fontFamily: FONZFONTTWO,
            fontSize: HEADINGFIVE,
            color: DARKERGREY,
          ),
          decoration: InputDecoration(
            hintText: "email",
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          onChanged: (value) {
            setState(() {
              _email = value;
            });
//            print(_email);
          },
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _email = value.trim(),
        ),
      ),
    );
  }



  Widget ShowPasswordInputSignIn() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 50,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: Colors.white,
            shadowDarkColor: determineColorThemeTextInverse()
        ),
        child: TextFormField(
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          style: TextStyle(
            fontFamily: FONZFONTTWO,
            fontSize: HEADINGFIVE,
            color: DARKERGREY,
          ),
          decoration: InputDecoration(
            hintText: "password",
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          onChanged: (value) {
            setState(() {
              _password = value;
            });
            print(_password);
          },
          validator: (value) =>
          value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value.trim(),
        ),
      ),
    );
  }


  Widget ShowSignInButton() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      child: SizedBox(
        height: 40.0,
        width: width * 0.7,
        child: NeumorphicButton(
          // shape: new RoundedRectangleBorder(
          //   borderRadius: new BorderRadius.circular(10.0),
          // ),
          style: NeumorphicStyle(
            color: AMBER,
          ),
          child: Center(
            child: new Text(
              'sign in',
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFIVE,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () async {
            log("pressed sign in");
            final signInResp = await AuthApi.signInUser(_email, _password);
            if (signInResp["responseCode"] == 200) {
              // set hasAccount to true
              userAttributes.setHasAccount(true);
              // check if user has spotify

              // check if user has coasters
              updatePageCoasterDashboard = true;
              // pop modal

            }
            else {
              errorOnPage = true;
              _errorMessage = signInResp["body"];
              if (_errorMessage == "") {
                _errorMessage = "something went wrong :/";
              }
            }
          },
        ),
      ),
    );
  }

  Widget ShowForgotPasswordButton() {

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: new FlatButton(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child:
                Text(
                  "forgot password? ",
                  style: new TextStyle(
                      fontFamily: FONZFONTONE,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
          ),
          onPressed: () async {
            log("pressed reset password for email " + _email);
          //   resetPassword(
          //     _email,
          //     _signInKey,
          //   );
          //   toast.Toast.show("sent reset password email", context,
          //       duration: toast.Toast.LENGTH_LONG, gravity: toast.Toast.BOTTOM);
          },
        )
    );
  }


  Widget OrAppleOrGoogle() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'or',
                style: TextStyle(
                  fontFamily: FONZFONTTWO,
                  fontSize: HEADINGFIVE,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Spacer(),
              Neumorphic(
                style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.black,
                    shadowDarkColor: determineColorThemeTextInverse()

                ),
                child: MaterialButton(
                  child: Container(
                    height: 25,
                    width: 25,
                    child: Image(
                      image: AssetImage("assets/thirdParties/appleLogoWhite.png"),
                    ),
                  ),
                ),

              ),
              Neumorphic(
                style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.white,
                    shadowDarkColor: determineColorThemeTextInverse()

                ),
                child: MaterialButton(
                  child: Container(
                    height: 25,
                    width: 25,
                    child: Image(
                      image: AssetImage("assets/thirdParties/googleLogo.png"),
                    ),
                  ),
                ),

              ),

              Spacer()
            ],
          )
        ],
      ),
    );
  }

}
