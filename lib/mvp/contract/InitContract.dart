import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/base/IPresenter.dart';
import 'package:taiwan_bus/base/IView.dart';
import 'package:taiwan_bus/beans/BusStationBean.dart';

abstract class IInitView implements IView {
  void getNearStopsCallback(List<BusStationBean> stations);
}

abstract class IInitPresenter implements IPresenter {
  Future<CameraPosition> initPosition();
  void getNearStops();
}

abstract class IInitModel implements IModel {
  void getNearStops(double latitude, double longitude, {void Function(Response response) onResponse});
}