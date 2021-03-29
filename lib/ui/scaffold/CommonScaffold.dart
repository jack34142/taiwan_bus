import 'package:flutter/material.dart';
import 'package:taiwan_bus/config/MyColor.dart';

class CommonScaffold extends StatelessWidget {

  final Widget body;
  final String title;
  final Color appBarColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Widget> actions;

  CommonScaffold({@required this.body, this.title : "", this.actions,
    this.appBarColor : MyColor.PRIMARY, this.backgroundColor,
    this.foregroundColor : MyColor.DARK_THEME_TEXT});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: title != null ? AppBar(
          centerTitle: true,
          titleSpacing: 0,
          backgroundColor: appBarColor,
          elevation: 0,
          title: Text(title,
              style: TextStyle(
                  color: foregroundColor
              )
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined, color: foregroundColor),
              onPressed: (){
                Navigator.pop(context);
              }
          ),
          actions: actions,
        ) : null,
        body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: body
        )
    );
  }

}
