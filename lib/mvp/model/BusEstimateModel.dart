import 'package:dio/src/response.dart';
import 'package:taiwan_bus/base/BaseModel.dart';
import 'package:taiwan_bus/mvp/contract/BusEstimateContract.dart';

class BusEstimateModel extends BaseModel implements IBusEstimateModel{
  @override
  void getBusEstimate(Set<String> stopUids, {void Function(Response response) onResponse}) {
    http.getBusEstimate(stopUids, onResponse: onResponse);
  }

  @override
  void getBusStops(Set<String> routes, {void Function(Response response) onResponse}) {
    http.getBusStops(routes, onResponse: onResponse);
  }
}