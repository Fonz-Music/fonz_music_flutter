import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardFields/PauseCoasterField.dart';

class PauseCoasterButton extends StatefulWidget {

  PauseCoasterButton({Key key, this.coasterActive, this.notifyParent, this.coasterUid, this.coasterName}) : super(key: key);
  bool coasterActive;
  final Function() notifyParent;
  final coasterUid;
  final coasterName;

  @override
  _PauseCoasterButtonState createState() => _PauseCoasterButtonState();
}

class _PauseCoasterButtonState extends State<PauseCoasterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        child: Row(
          children: [
            Text(
                '${(widget.coasterActive)
                    ? "pause"
                    : "unpause"}',
//                                          'pause',
                style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight:
                    FontWeight.w300,
                    color: determineColorThemeTextInverse())),
            Spacer(),
            Container(

              child: Image(
                image: AssetImage(
                    getPauseIcon()),
                width: 20,
              ),
            ),
          ],
        ),
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (popupContext) {
                return PauseCoasterField( coasterUid: widget.coasterUid, popupContext: popupContext, active: widget.coasterActive, coasterName: widget.coasterName,  notifyParent: widget.notifyParent);
              }
          );
          // widget.notifyParent();
        },
      )
    );
  }
}
