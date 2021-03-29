import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taiwan_bus/generated/l10n.dart';
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
              secondary: MyColor.TEXT,  // enable text color
              onSurface: MyColor.DISABLE_TEXT   // disable text color
          ),
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
              color: MyColor.TEXT,
              fontSize: 16
          ),
        ),
      ),
      home: InitPage(),
      builder: EasyLoading.init(),
      // -------------------- i18n --------------------
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      // 讲en设置为第一项,没有适配语言时,英语为首选项
      supportedLocales: S.delegate.supportedLocales,
      // 插件目前不完善手动处理简繁体
//      localeResolutionCallback: (locale, supportLocales) {
//        // 中文 简繁体处理
//        if (locale?.languageCode == 'zh') {
//          if (locale?.scriptCode == 'Hant') {
//            return const Locale('zh', 'HK'); //繁体
//          } else {
//            return const Locale('zh', 'CN'); //简体
//          }
//        }
//        return null;
//      }
    );
  }
}
