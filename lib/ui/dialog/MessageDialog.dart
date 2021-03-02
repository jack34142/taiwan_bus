import 'dart:async';
import 'package:flutter/material.dart';
import 'package:taiwan_bus/config/MyColor.dart';
import 'MyDialog.dart';
//import 'package:flutter_html/flutter_html.dart';

class MyDialogButton {
  final String text;
  final Color textColor;
  final Function() onTap;
  final int delay;

  MyDialogButton({@required this.text, @required this.onTap, this.textColor : MyColor.PRIMARY, this.delay: 0});
}

class MessageDialog extends StatefulWidget{
  final String title, msg;
  final List<MyDialogButton> buttons;
  final bool barrierDismissible;

  MessageDialog({
    this.title,
    this.msg,
    @required this.buttons,
    this.barrierDismissible : true
  });

  @override
  State<StatefulWidget> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {

  int _maxDelay = 0;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    widget.buttons.forEach((mButton) {
      if(mButton.delay > _maxDelay)
        _maxDelay = mButton.delay;
    });
    _countDown();
  }

  void _countDown(){
    if(_maxDelay > _count){
      Future.delayed(Duration(seconds: 1), (){
        if(mounted){
          setState(() {
            _count++;
          });
          _countDown();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      barrierDismissible: widget.barrierDismissible,
      padding: EdgeInsets.all(40),
      child: LayoutBuilder(builder: (context, constraint){
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: 11,
              ),
              child: widget.title != null ? Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 12),
                child: Text(widget.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ) : Container(),
            ),
            widget.msg != null ? ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: constraint.maxWidth * 0.20,
              ),
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 3, bottom: 12, left: 24, right: 24),
                  child: Text(widget.msg,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  )
//              Html(
//                data: msg,
//                customTextAlign: (tag){
//                  return TextAlign.center;
//                },
//                defaultTextStyle: TextStyle(fontSize: 16),
//              ),
              ),
            ) : Container(),
            _buildSeparator(),
            Row(
              children: _buildButtons(widget.buttons),
            )
          ],
        );
      }),
    );
  }

  Widget _buildSeparator(){
    return Divider(
      height: 0,
      thickness: 0.5,
      color: MyColor.DIVIDER,
    );
  }

  List<Widget> _buildButtons(List<MyDialogButton> buttons){
    return buttons.map((mButton){
      int index = buttons.indexOf(mButton);
      int delay = mButton.delay - _count;
      if (delay < 0)
        delay = 0;

      return Expanded(
          child: ButtonTheme(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              height: 0,
              padding: EdgeInsets.only(top: 11, bottom: 13),
              child: FlatButton(
                  shape: index < buttons.length-1 ? Border(
                      right: BorderSide(width: 0.5, color: MyColor.DIVIDER)
                  ) : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(mButton.text,
                        style: TextStyle(
                          color: delay == 0 ? mButton.textColor : MyColor.DISABLE_TEXT,
                          fontSize: 16
                        ),
                      ),
                      delay != 0 ? Container(
                        margin: EdgeInsets.only(left: 3),
                        child: Text("($delay)",
                          style: TextStyle(
                              color: MyColor.DISABLE_TEXT,
                              fontSize: 14
                          ),
                        ),
                      ) : Container()
                    ],
                  ),
                  onPressed: delay == 0 ? mButton.onTap : null
              )
          )
      );
    }).toList().cast<Widget>();
  }
}