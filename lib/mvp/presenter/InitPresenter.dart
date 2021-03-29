import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taiwan_bus/base/BasePresenter.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/beans/BusStationBean.dart';
import 'package:taiwan_bus/mvp/contract/InitContract.dart';
import 'package:taiwan_bus/mvp/model/InitModel.dart';
import 'package:taiwan_bus/utils/Log.dart';
import 'package:taiwan_bus/utils/MyUtil.dart';

class InitPresenter extends BasePresenter<IInitView, IInitModel> implements IInitPresenter {
  static const String _TAG = "InitPresenter";

  Position _myPosition;
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
      final MyUtil positionUtil = MyUtil();
      positionStream = Geolocator.getPositionStream().listen((position) {
        if(_myPosition == null){
          _myPosition = position;
          getNearStops();
        }else{
          var dis = positionUtil.calculateDistance(_myPosition.latitude, _myPosition.longitude, position.latitude, position.longitude);
          if(dis * 1000 > 15){
            Log.d("$_TAG => my position: $position, move path: $dis km");
            _myPosition = position;
            getNearStops();
          }
        }
      });
    }
  }

  @override
  Future<CameraPosition> initPosition() async {
    Completer<CameraPosition> completer = Completer();
    if(_myPosition == null){
      await _initPermission();
      await _isGpsOpen();
      print("getLastKnownPosition");
      _myPosition = await Geolocator.getLastKnownPosition();
      Log.d("$_TAG => last known position: $_myPosition");
      if(_myPosition != null)
        getNearStops();

      setPositionListener();
    }
    completer.complete(CameraPosition(
      target: LatLng(_myPosition.latitude, _myPosition.longitude),
      zoom: 14.4746,
    ));
    return completer.future;
  }

  @override
  void getNearStops() {
    model.getNearStops(_myPosition.latitude, _myPosition.longitude, onResponse: (response){
      List<BusStationBean> datas = (response.data as List).map((data) => BusStationBean.fromJson(data)).toList().cast<BusStationBean>();
      view.getNearStopsCallback(datas);
    });
  }
}