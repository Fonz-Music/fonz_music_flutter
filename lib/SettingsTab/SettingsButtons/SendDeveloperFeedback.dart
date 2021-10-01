import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/main.dart';

class SendDeveloperFeedbackButton extends StatefulWidget {

  @override
  _SendDeveloperFeedbackButtonState createState() => _SendDeveloperFeedbackButtonState();
}

class _SendDeveloperFeedbackButtonState extends State<SendDeveloperFeedbackButton> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: NeumorphicButton(
        child: Container(
          width: width * 0.8,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Container(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.send_and_archive,

                    color: AMBER,
                  ),
                ),
              ),
              Text(
                "send developer feedback",
                style: TextStyle(
                  fontFamily: FONZFONTONE,
                  fontSize: HEADINGSIX,
                  color: determineColorThemeTextInverse(),
                ),
              ),
            ],
          ),
        ),
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.rect(),
            color: determineColorThemeBackground(),
            shadowDarkColor: determineLightShadowRoundButton(),
            shadowLightColor: determineLightShadowRoundButton()
        ),
        onPressed: () async {

          final Email email = Email(
            body: 'type your feedback or issue here: \n\n\n\n'
                'userId: ${userAttributes.getUserId()}\n'
                'hasAccount: ${userAttributes.getHasAccount().toString()}\n'
                'hasSpotify: ${userAttributes.getConnectedToSpotify().toString()}\n'
                'hasCoasters: ${userAttributes.getHasConnectedCoasters()}\n'
                'sessionId: ${userAttributes.getUserSessionId()}\n',
            subject: 'app user ${userAttributes.getUserDisplayName()} has issue',
            recipients: ['contact@fonzmusic.com'],
            isHTML: false,
          );

          await FlutterEmailSender.send(email);

        },


      ),
    );
  }
}
