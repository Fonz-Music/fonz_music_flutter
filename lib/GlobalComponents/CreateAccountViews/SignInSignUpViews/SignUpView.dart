import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';

final _signUpKey = GlobalKey<FormState>();

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {


  String _email;
  String _password;
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpKey,
      child: Column(
        children: [
          ShowEmailInputSignUp(),
          ShowPasswordInputSignUp(),
          ShowPrimarySignUpButton(),
        ],
      ),
    );
  }

  Widget ShowEmailInputSignUp() {
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

  Widget ShowPasswordInputSignUp() {
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

  Widget ShowPrimarySignUpButton() {
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
            'sign up',
            style: new TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          onPressed: () async {
//            log("email input" + _email);
//            log("pass input" + _password);
//             await signUpUser(_email, _password, _signUpKey);
          },
        ),
      ),
    );
  }

}
