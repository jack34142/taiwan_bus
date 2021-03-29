import 'package:dio/dio.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/base/IPresenter.dart';
import 'package:taiwan_bus/base/IView.dart';
import 'package:taiwan_bus/beans/BusPositionBean.dart';

abstract class IBusPositionView implements IView {
  void getBusPositionCallback(List<BusPositionBean> positions);
}

abstract class IBusPositionPresenter implements IPresenter {
  void getBusPosition(String platNumb);
}

abstract class IBusPositionModel implements IModel {
  void getBusPosition(String platNumb, {void Function(Response response) onResponse});
}