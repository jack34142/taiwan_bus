// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `臺灣公車`
  String get app_name {
    return Intl.message(
      '臺灣公車',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `提示`
  String get notice {
    return Intl.message(
      '提示',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `警告`
  String get alert {
    return Intl.message(
      '警告',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `確認`
  String get ok {
    return Intl.message(
      '確認',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `伺服器連接失敗`
  String get server_error {
    return Intl.message(
      '伺服器連接失敗',
      name: 'server_error',
      desc: '',
      args: [],
    );
  }

  /// `請允許應用程式使用定位權限`
  String get open_gps_permission {
    return Intl.message(
      '請允許應用程式使用定位權限',
      name: 'open_gps_permission',
      desc: '',
      args: [],
    );
  }

  /// `請開啟位置服務`
  String get open_gps {
    return Intl.message(
      '請開啟位置服務',
      name: 'open_gps',
      desc: '',
      args: [],
    );
  }

  /// `定位中...`
  String get positioning {
    return Intl.message(
      '定位中...',
      name: 'positioning',
      desc: '',
      args: [],
    );
  }

  /// `{m}分{s}秒`
  String minute_second(Object m, Object s) {
    return Intl.message(
      '$m分$s秒',
      name: 'minute_second',
      desc: '',
      args: [m, s],
    );
  }

  /// `尚未發車`
  String get no_departure {
    return Intl.message(
      '尚未發車',
      name: 'no_departure',
      desc: '',
      args: [],
    );
  }

  /// `即將到站`
  String get coming_soon {
    return Intl.message(
      '即將到站',
      name: 'coming_soon',
      desc: '',
      args: [],
    );
  }

  /// `路線變更`
  String get route_change {
    return Intl.message(
      '路線變更',
      name: 'route_change',
      desc: '',
      args: [],
    );
  }

  /// `選擇站點`
  String get selected_stop {
    return Intl.message(
      '選擇站點',
      name: 'selected_stop',
      desc: '',
      args: [],
    );
  }

  /// `可上車`
  String get get_on {
    return Intl.message(
      '可上車',
      name: 'get_on',
      desc: '',
      args: [],
    );
  }

  /// `可下車`
  String get get_off {
    return Intl.message(
      '可下車',
      name: 'get_off',
      desc: '',
      args: [],
    );
  }

  /// `可上下車`
  String get get_on_and_off {
    return Intl.message(
      '可上下車',
      name: 'get_on_and_off',
      desc: '',
      args: [],
    );
  }

  /// `去程`
  String get outbound {
    return Intl.message(
      '去程',
      name: 'outbound',
      desc: '',
      args: [],
    );
  }

  /// `返程`
  String get return_trip {
    return Intl.message(
      '返程',
      name: 'return_trip',
      desc: '',
      args: [],
    );
  }

  /// `迴圈`
  String get loop {
    return Intl.message(
      '迴圈',
      name: 'loop',
      desc: '',
      args: [],
    );
  }

  /// `下一站終點站`
  String get next_end {
    return Intl.message(
      '下一站終點站',
      name: 'next_end',
      desc: '',
      args: [],
    );
  }

  /// `搜尋站點`
  String get search_stop {
    return Intl.message(
      '搜尋站點',
      name: 'search_stop',
      desc: '',
      args: [],
    );
  }

  /// `路線資訊`
  String get route_detail {
    return Intl.message(
      '路線資訊',
      name: 'route_detail',
      desc: '',
      args: [],
    );
  }

  /// `時刻表`
  String get schedule {
    return Intl.message(
      '時刻表',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}