import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taiwan_bus/config/MyConfig.dart';
import 'package:taiwan_bus/ui/dialog/MessageDialog.dart';
import 'IPresenter.dart';
import 'IView.dart';

abstract class BaseView extends StatefulWidget {}

abstract class BaseViewState<P extends IPresenter, V extends BaseView>
    extends State<V> implements IView {
  P presenter;
  int _loadingCount = 0;

  @override
  void initState() {
    super.initState();
    presenter = createPresenter();
    if (presenter != null) {
      presenter.attachView(this);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterInit();
    });
  }

  void afterInit() {}

  P createPresenter();

  P getPresenter() {
    return presenter;
  }

  @override
  void dispose() {
    super.dispose();
    _loadingCount = 0;
    hideLoading();
    if (presenter != null) {
      presenter.detachView();
      presenter = null;
    }
  }

  @override
  Future routePush(Widget page, {String routeName}) {
    return Navigator.push(context, MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(name: routeName)
    ));
  }

  @override
  void routePushAndRemoveUntil(Widget page, {String routeName}) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (_) => page,
        settings:  RouteSettings(name: routeName)
    ), (route) => route == null,);
  }

  @override
  void showToast(String msg, {ToastGravity gravity: ToastGravity.BOTTOM}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }

  @override
  void showLoading() {
    _loadingCount++;
    EasyLoading.show(
        maskType: EasyLoadingMaskType.black
    );
  }

  @override
  void hideLoading() {
    if(_loadingCount > 0)
      _loadingCount--;
    if(_loadingCount == 0)
      EasyLoading.dismiss();
  }

  @override
  Future<dynamic> showMsg(String msg, {int code = 1}) {
    String title = code < 0 ? "警告" : "提示";
    if(!MyConfig.isDebug){
      switch(code){
        case -3:
          msg = "服务器存取发生问题";
          break;
      }
    }

    if(msg != null){
      return showDialog(
          context: context,
          builder: (context) =>
              MessageDialog(
                barrierDismissible: false,
                title: title,
                msg: msg,
                buttons: [
                  MyDialogButton(text: "确认", onTap: (){
                    Navigator.of(context).pop();
                  })
                ],
              )
      );
    }else {
      return null;
    }
  }
}
