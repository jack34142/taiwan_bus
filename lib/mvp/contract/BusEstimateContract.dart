import 'package:dio/dio.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/base/IPresenter.dart';
import 'package:taiwan_bus/base/IView.dart';
import 'package:taiwan_bus/beans/BusEstimateBean.dart';
import 'package:taiwan_bus/beans/BusStopBean.dart';

abstract class IBusEstimateView implements IView {
  void getBusEstimateCallback(List<BusEstimateBean> busBusEstimates);
  void getBusStopsCallback(List<BusStopBean> stops);
}

abstract class IBusEstimatePresenter implements IPresenter {
  void getBusEstimate(Set<String> stopUids);
}

abstract class IBusEstimateModel implements IModel {
  void getBusEstimate(Set<String> stopUids, {void Function(Response response) onResponse});
  void getBusStops(Set<String> routes, {void Function(Response response) onResponse});
}