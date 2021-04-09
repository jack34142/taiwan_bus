import 'package:dio/dio.dart';
import 'package:taiwan_bus/base/BaseModel.dart';
import 'package:taiwan_bus/mvp/contract/InitContract.dart';

class InitModel extends BaseModel implements IInitModel{

  @override
  void getNearStops(double latitude, double longitude, {int rangeRadius: 500,
      void Function(Response response) onResponse}) {
    http.getNearStops(latitude, longitude,
      rangeRadius: rangeRadius,
      onResponse: onResponse
    );
  }

  @override
  void getStopsByName(String name, {void Function(Response response) onResponse}) {
    http.getStopsByName(name, onResponse: onResponse);
  }

}