import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taiwan_bus/beans/BusStationBean.dart';

class MyStopBean {
  final LatLng position;

  final List<Stops> _stops;
  List<Stops> get stops => _stops;

  MyStopBean(this._stops, {@required this.position});

  Map<String, Set<Stops>> getStopMap() {
    Map<String, Set<Stops>> datas = {};
    _stops.forEach((stop) {
      String stopName = stop.stopName.zhTw;
      if(datas.containsKey(stopName))
        datas[stopName].add(stop);
      else
        datas[stopName] = Set()..add(stop);
    });
    return datas;
  }

  String _address;
  Future<String> get address async {
    if(_address == null){
      final coordinates = new Coordinates(position.latitude, position.longitude);
      final addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      _address = addresses.first.addressLine.split(",")[0];
    }
    return _address;
  }
}