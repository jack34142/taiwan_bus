import 'package:dio/dio.dart';
import 'package:taiwan_bus/base/BaseModel.dart';
import 'package:taiwan_bus/mvp/contract/BusPositionContract.dart';

class BusPositionModel extends BaseModel implements IBusPositionModel{
  @override
  void getBusPosition(String platNumb, {void Function(Response response) onResponse}) {
    http.getBusPosition(platNumb, onResponse: onResponse);
  }

}