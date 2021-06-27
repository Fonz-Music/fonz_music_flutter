import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardFields/RenameCoasterField.dart';
import 'package:fonz_music_flutter/HostTab/CoasterDashboardViews/CoasterDashboardView.dart';

class RenameCoasterButton extends StatefulWidget {

  RenameCoasterButton({Key key, this.notifyParent, this.coasterUid, this.coasterName}) : super(key: key);
  final Function() notifyParent;
  final coasterUid;
  final coasterName;

  @override
  _RenameCoasterButtonState createState() => _RenameCoasterButtonState();
}

class _RenameCoasterButtonState extends State<RenameCoasterButton> {



  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 40,
      child: TextButton(
        child: Row(
          children: [
            Text('rename',
                style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight:
                    FontWeight.w300,
                    color: determineColorThemeTextInverse())),
            Spacer(),
            Container(

              child: Image(
                image: AssetImage(
                    getEditIcon()),
                width: 20,
              ),
            ),

          ],
        ),
      onPressed: () async {

          await showDialog(
          context: context,
          builder: (popupContext) {
            return RenameCoasterField(coasterUid: widget.coasterUid, popupContext: popupContext, coasterName: widget.coasterName,);
          }
          );
        widget.notifyParent();
      },
      ),
    );
  }
}
