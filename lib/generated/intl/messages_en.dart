// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(m, s) => "${m}分${s}秒";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "alert" : MessageLookupByLibrary.simpleMessage("警告"),
    "app_name" : MessageLookupByLibrary.simpleMessage("臺灣公車"),
    "coming_soon" : MessageLookupByLibrary.simpleMessage("即將到站"),
    "get_off" : MessageLookupByLibrary.simpleMessage("可下車"),
    "get_on" : MessageLookupByLibrary.simpleMessage("可上車"),
    "get_on_and_off" : MessageLookupByLibrary.simpleMessage("可上下車"),
    "loop" : MessageLookupByLibrary.simpleMessage("迴圈"),
    "minute_second" : m0,
    "next_end" : MessageLookupByLibrary.simpleMessage("下一站終點站"),
    "no_departure" : MessageLookupByLibrary.simpleMessage("尚未發車"),
    "notice" : MessageLookupByLibrary.simpleMessage("提示"),
    "ok" : MessageLookupByLibrary.simpleMessage("確認"),
    "open_gps" : MessageLookupByLibrary.simpleMessage("請開啟位置服務"),
    "open_gps_permission" : MessageLookupByLibrary.simpleMessage("請允許應用程式使用定位權限"),
    "outbound" : MessageLookupByLibrary.simpleMessage("去程"),
    "positioning" : MessageLookupByLibrary.simpleMessage("定位中..."),
    "return_trip" : MessageLookupByLibrary.simpleMessage("返程"),
    "route_change" : MessageLookupByLibrary.simpleMessage("路線變更"),
    "route_detail" : MessageLookupByLibrary.simpleMessage("路線資訊"),
    "schedule" : MessageLookupByLibrary.simpleMessage("時刻表"),
    "search_stop" : MessageLookupByLibrary.simpleMessage("搜尋站點"),
    "selected_stop" : MessageLookupByLibrary.simpleMessage("選擇站點"),
    "server_error" : MessageLookupByLibrary.simpleMessage("伺服器連接失敗")
  };
}
