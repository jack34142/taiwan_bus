import 'dart:async';
import 'package:taiwan_bus/base/BasePresenter.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/beans/BusEstimateBean.dart';
import 'package:taiwan_bus/beans/BusStopBean.dart';
import 'package:taiwan_bus/mvp/contract/BusEstimateContract.dart';
import 'package:taiwan_bus/mvp/model/BusEstimateModel.dart';

class BusEstimatePresenter extends BasePresenter<IBusEstimateView, IBusEstimateModel> implements IBusEstimatePresenter {

  Set<String> _routes = Set();

  @override
  IModel createModel() => BusEstimateModel();

  @override
  void getBusEstimate(Set<String> stopUids) {
    model.getBusEstimate(stopUids, onResponse: (response){
      Set<String> set = Set();
      List<BusEstimateBean> busBusEstimates = [];

      (response.data as List).forEach((json) {
        BusEstimateBean estimateBean = BusEstimateBean.fromJson(json);
        if(estimateBean.estimateTime == null)
          busBusEstimates.add(estimateBean);
        else
          busBusEstimates.insert(0, estimateBean);

        if(!_routes.contains(estimateBean.subRouteUID))
          set.add(estimateBean.subRouteUID);
      });
      if(set.isNotEmpty)
        getBusStops(set);

      view.getBusEstimateCallback(busBusEstimates);
    });
  }

  @override
  void getBusStops(Set<String> routes) {
    model.getBusStops(routes, onResponse: (response){
      _routes.addAll(routes);
      List<BusStopBean> stops = (response.data as List)
          .map((json) => BusStopBean.fromJson(json)).toList().cast<BusStopBean>();
      view.getBusStopsCallback(stops);
    });
  }

}