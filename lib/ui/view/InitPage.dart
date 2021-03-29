import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taiwan_bus/base/BaseView.dart';
import 'package:taiwan_bus/beans/BusStationBean.dart';
import 'package:taiwan_bus/mvp/contract/InitContract.dart';
import 'package:taiwan_bus/mvp/presenter/InitPresenter.dart';
import 'package:taiwan_bus/ui/scaffold/CommonScaffold.dart';
import 'package:taiwan_bus/ui/view/BusEstimatePage.dart';

class InitPage extends BaseView{
  @override
  State<StatefulWidget> createState() => _InitPageViewState();
}

class _InitPageViewState extends BaseViewState<IInitPresenter, InitPage> implements IInitView {

  GoogleMapController _mapController;
  List<BusStationBean> _stations = [];

  @override
  IInitPresenter createPresenter() => InitPresenter();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        body: Stack(
          children: [
            FutureBuilder<CameraPosition>(
              future: presenter.initPosition(),
              builder: (context, snapshot) {
                if(snapshot.data != null){
                  return GoogleMap(
                    myLocationEnabled: true,
                    initialCameraPosition: snapshot.data,
                    markers: _stations.map((station){
                      int index = _stations.indexOf(station);
                      LatLng position = LatLng(station.stationPosition.positionLat, station.stationPosition.positionLon);
                      return Marker(
                        markerId: MarkerId(index.toString()),
                        position: position,
                        // infoWindow: InfoWindow(
                        //     title: station.stationName.zhTw,
                        //     snippet: station.stops.map((stop) => stop.stopName.zhTw).toList().join("<br/>")
                        // ),
                        onTap: (){
                          routePush(BusEstimatePage(station));
                        }
                      );
                    }).toSet().cast<Marker>(),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                  );
                }else{
                  return Center(
                    child: Text(s.positioning),
                  );
                }
              },
            ),

            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: (){
                presenter.getNearStops();
              },
              child: Text("getNearTaiwanBus")
            ),
          ],
        )
    );
  }

  // -------------------- mvp --------------------
  @override
  void getNearStopsCallback(List<BusStationBean> stations) {
    setState(() {
      _stations.clear();
      _stations.addAll(stations);
    });
  }
}