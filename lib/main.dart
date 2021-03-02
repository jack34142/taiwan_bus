import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:taiwan_bus/ui/view/InitPage.dart';
import 'config/MyColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: MyColor.PRIMARY,
        hintColor: MyColor.HINT_TEXT,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.accent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              secondary: MyColor.DEFAULT_TEXT,  // enable text color
              onSurface: MyColor.DISABLE_TEXT   // disable text color
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
              color: MyColor.DEFAULT_TEXT,
              fontSize: 16
          ),
        ),
      ),
      home: InitPage(),
      builder: EasyLoading.init(),
    );
  }
}
