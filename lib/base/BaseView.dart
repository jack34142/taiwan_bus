import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taiwan_bus/config/MyConfig.dart';
import 'package:taiwan_bus/generated/l10n.dart';
import 'package:taiwan_bus/ui/dialog/MessageDialog.dart';
import 'IPresenter.dart';
import 'IView.dart';

abstract class BaseView extends StatefulWidget {}

abstract class BaseViewState<P extends IPresenter, V extends BaseView>
    extends State<V> implements IView {
  int _loadingCount = 0;

  P _presenter;
  P get presenter => _presenter;

  P createPresenter();

  @override
  S get s => S.of(context);

  @override
  void initState() {
    super.initState();
    _presenter = createPresenter();
    if (_presenter != null) {
      _presenter.attachView(this);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterInit();
    });
  }

  void afterInit() {}

  @override
  void dispose() {
    super.dispose();
    _loadingCount = 0;
    hideLoading();
    if (_presenter != null) {
      _presenter.detachView();
      _presenter = null;
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
    String title = code > 0 ? s.notice : s.alert;
    if(!MyConfig.isDebug){
      switch(code){
        case -3:
          msg = s.server_error;
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
                  MyDialogButton(text: s.ok, onTap: (){
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
