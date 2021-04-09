import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/base/IPresenter.dart';
import 'package:taiwan_bus/base/IView.dart';
import 'package:taiwan_bus/beans/MyStopBean.dart';

abstract class IInitView implements IView {
  void getNearStopsCallback(List<MyStopBean> stopList);
  void updateMyPosition(LatLng position);
}

abstract class IInitPresenter implements IPresenter {
  Future<void> initPosition();
  void getNearStops(LatLng latlng);
  void getStopsByName(String name);
}

abstract class IInitModel implements IModel {
  void getNearStops(double latitude, double longitude, {void Function(Response response) onResponse});
  void getStopsByName(String name, {void Function(Response response) onResponse});
}