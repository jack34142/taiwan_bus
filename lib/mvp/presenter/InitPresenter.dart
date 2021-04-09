import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taiwan_bus/base/BasePresenter.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/beans/BusStationBean.dart';
import 'package:taiwan_bus/beans/MyStopBean.dart';
import 'package:taiwan_bus/mvp/contract/InitContract.dart';
import 'package:taiwan_bus/mvp/model/InitModel.dart';
import 'package:taiwan_bus/utils/Log.dart';

class InitPresenter extends BasePresenter<IInitView, IInitModel> implements IInitPresenter {
  static const String _TAG = "InitPresenter";
  
  StreamSubscription<Position> positionStream;

  @override
  IModel createModel() => InitModel();

  @override
  void detachView() {
    super.detachView();
    positionStream?.cancel();
    positionStream = null;
  }

  @override
  Future<bool> _initPermission() async {
    return _checkPermission(await Geolocator.checkPermission());
  }

  Future<bool> _checkPermission(LocationPermission permission) async {
    Completer<bool> completer = Completer();
    switch(permission){
      case LocationPermission.deniedForever:
        await view.showMsg(view.s.open_gps_permission);
        continue denied;
      denied:
      case LocationPermission.denied:
        permission = await Geolocator.requestPermission();
        completer.complete(_checkPermission(permission));
        break;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        completer.complete(true);
        break;
    }
    return completer.future;
  }

  Future<bool> _isGpsOpen() async {
    Completer<bool> completer = Completer();
    if(await Geolocator.isLocationServiceEnabled()){
      completer.complete(true);
    }else{
      await view.showMsg(view.s.open_gps);
      completer.complete(_isGpsOpen());
    }
    return completer.future;
  }

  void setPositionListener(){
    print("setPositionListener");
    if(positionStream == null){
      positionStream = Geolocator.getPositionStream().listen((position) {
        view.updateMyPosition(LatLng(position.latitude, position.longitude));
      });
    }
  }

  @override
  Future<void> initPosition() async {
    await _initPermission();
    await _isGpsOpen();
    print("getLastKnownPosition");
    Position position = await Geolocator.getLastKnownPosition();
    Log.d("$_TAG => last known position: $position");
    if (position != null)
      view.updateMyPosition(LatLng(position.latitude, position.longitude));
  }

  @override
  void getNearStops(LatLng latlng) {
    model.getNearStops(latlng.latitude, latlng.longitude, onResponse: getStopResponse);
  }

  @override
  void getStopsByName(String name) {
    model.getStopsByName(name, onResponse: getStopResponse);
  }

  void getStopResponse(response){
    Map<LatLng, List<Stops>> stopMap = {};
    (response.data as List).forEach((json) {
      BusStationBean station = BusStationBean.fromJson(json);
      LatLng latLng = LatLng(station.stationPosition.positionLat, station.stationPosition.positionLon);
      if(stopMap.containsKey(latLng))
        stopMap[latLng].addAll(station.stops);
      else
        stopMap[latLng] = station.stops;
    });

    List<MyStopBean> stopList = [];
    stopMap.forEach((position, stops) {
      stopList.add(MyStopBean(stops, position: position));
    });
    view.getNearStopsCallback(stopList);
  }
}