import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';


final _signInKey = GlobalKey<FormState>();

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  String _email;
  String _password;
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInKey,
      child: Column(children: [
        ShowEmailInputSignIn(),
        ShowPasswordInputSignIn(),
        ShowPrimarySignInButton(),
        ShowForgotPasswordButton()
      ]),
    );
  }

  Widget ShowEmailInputSignIn() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, height * .05, 20.0, 0.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: InputDecoration(
            hintText: "email",
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onChanged: (value) {

            // _email = value;
            // notifyParent();

            setState(() {
              _email = value;
            });
//            print(_email);
          },
        ),
      ),
    );
  }

  Widget ShowPasswordInputSignIn() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          decoration: InputDecoration(
            hintText: "password",
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          validator: (value) =>
          value.isEmpty ? 'Password can\'t be empty' : null,
          onChanged: (value) {
            setState(() {
              _password = value;
            });
//            print(_email);
          },
        ),
      ),
    );
  }

  Widget ShowPrimarySignInButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new FlatButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          color: AMBER,
          child: new Text(
            'sign in',
            style: new TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: () async {
            log("pressed sign in");
            // signInUser(
            //   _email,
            //   _password,
            //   _signInKey,
            // );
          },
        ),
      ),
    );
  }

  Widget ShowForgotPasswordButton() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: new FlatButton(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child:
                Text(
                  "forgot password? ",
                  style: new TextStyle(
                      fontFamily: FONZFONTONE,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey),
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




}
