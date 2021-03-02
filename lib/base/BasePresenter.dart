import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:taiwan_bus/http/HttpBase.dart';
import 'IModel.dart';
import 'IPresenter.dart';
import 'IView.dart';

abstract class BasePresenter<V extends IView, M extends IModel>
    implements IPresenter {
  M _model;
  V _view;
  M get mvpModel => _model;
  V get mvpView => _view;

  @override
  void attachView(IView view) {
    this._view = view;
    this._model = createModel();
    _model.http = HttpBase((isLoading){
      if(isLoading)
        mvpView?.showLoading();
      else
        mvpView?.hideLoading();
    }, (e){
      String msg = e.toString();
      if(e is DioError){
        String msg = e.message;
        if (e.response != null){
          Map json;
          if(e.response.data is Map){
            json = e.response.data;
          }else{
            try{
              json = jsonDecode(e.response.data);
            }catch(e){
              json = {"msg": "error response not json"};
            }
          }
          if(json.containsKey("message")){
            msg = json["message"];
          }else if (json.containsKey("msg")){
            msg = json["msg"];
          }

          // if(e.response.statusCode == 401) {
          //   mvpView.showMsg(msg, code: -1).whenComplete((){
          //     SharedPreferences.getInstance().then((prefs) {
          //       prefs.remove(MyConfig.PREF_TOKEN);
          //       mvpView.routePushAndRemoveUntil(LoginPage());
          //     });
          //   });
          //   return;
          // }
        }
      }
      mvpView.showMsg(msg, code: -3);
    });
  }

  @override
  void detachView() {
    if (_view != null) {
      _view = null;
    }
    if (_model != null) {
      _model.dispose();
      _model = null;
    }
  }

  V get view {
    return _view;
  }

  M get model => _model;

  IModel createModel();
}
