import 'package:taiwan_bus/base/BasePresenter.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/beans/BusPositionBean.dart';
import 'package:taiwan_bus/mvp/contract/BusPositionContract.dart';
import 'package:taiwan_bus/mvp/model/BusPositionModel.dart';

class BusPositionPresenter extends BasePresenter<IBusPositionView, IBusPositionModel> implements IBusPositionPresenter {
  @override
  IModel createModel() => BusPositionModel();

  @override
  void getBusPosition(String platNumb) {
    if(platNumb == "-1")
      return;

    model.getBusPosition(platNumb, onResponse: (response){
      List<BusPositionBean> positions = (response.data as List)
          .map((json) => BusPositionBean.fromJson(json)).toList().cast<BusPositionBean>();
      view.getBusPositionCallback(positions);
    });
  }
}