import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taiwan_bus/generated/l10n.dart';

abstract class IView {
  void routePush(Widget page, {String routeName});
  void routePushAndRemoveUntil(Widget page, {String routeName});
  void showToast(String msg, {ToastGravity gravity});
  void showLoading();
  void hideLoading();
  Future<dynamic> showMsg(String msg, {int code: 1});
  S get s;
}
