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
      onGenerateTitle: (context) => S.of(context).app_name,
      theme: ThemeData(
        primaryColor: MyColor.PRIMARY,
        hintColor: MyColor.HINT_TEXT,
        // backgroundColor: MyColor.CONTAINER_BACKGROUND_COLOR,
        // dialogBackgroundColor: MyColor.CONTAINER_BACKGROUND_COLOR,
        // scaffoldBackgroundColor: MyColor.SCAFFOLD_BACKGROUND_COLOR,
        iconTheme: IconThemeData(
          color: MyColor.TEXT
        ),
        shadowColor: MyColor.SHADOW,
        dividerColor: MyColor.DIVIDER,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: MaterialStateProperty.all(Color(0x11010101)),
                foregroundColor: MaterialStateProperty.all(MyColor.TEXT),
                minimumSize: MaterialStateProperty.all(Size(65, 40)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15)),
                // backgroundColor: MaterialStateProperty.all(MyColor.PRIMARY_COLOR),
                // shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(50))
                // )),
                textStyle: MaterialStateProperty.all(TextStyle(
                    fontSize: 16
                ))
            )
        ),
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
