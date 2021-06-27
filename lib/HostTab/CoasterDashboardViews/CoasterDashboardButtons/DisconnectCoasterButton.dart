import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardFields/DisconnectCoasterField.dart';

class DisconnectCoasterButton extends StatefulWidget {

  DisconnectCoasterButton({Key key, this.notifyParent, this.coasterUid, this.coasterName}) : super(key: key);
  final Function() notifyParent;
  final coasterUid;
  final coasterName;

  @override
  _DisconnectCoasterButtonState createState() => _DisconnectCoasterButtonState();
}

class _DisconnectCoasterButtonState extends State<DisconnectCoasterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Row(
          children: [
            Text('disconnect',
                style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight:
                    FontWeight.w300,
                    color: determineColorThemeTextInverse())),
            Spacer(),
            Container(
              // padding: const EdgeInsets
              //     .fromLTRB(
              //     20, 0, 20, 0),
              child: Image(
                image: AssetImage(
                    getDisableIcon()),
                width: 20,
              ),
            ),

          ],
        ),
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (popupContext) {
                return DisconnectCoasterField( coasterUid: widget.coasterUid, popupContext: popupContext, coasterName: widget.coasterName,  notifyParent: widget.notifyParent);
              }
          );
          // widget.notifyParent();
        },
      ),
    );
  }
}
