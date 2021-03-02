import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {

  final Widget body;

  CommonScaffold({@required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: body
        ),
      )
    );
  }

}