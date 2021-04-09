import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:taiwan_bus/base/BaseView.dart';
import 'package:taiwan_bus/beans/MyStopBean.dart';
import 'package:taiwan_bus/config/MyColor.dart';
import 'package:taiwan_bus/config/MyConfig.dart';
import 'package:taiwan_bus/mvp/contract/InitContract.dart';
import 'package:taiwan_bus/mvp/presenter/InitPresenter.dart';
import 'package:taiwan_bus/ui/scaffold/CommonScaffold.dart';
import 'package:taiwan_bus/ui/view/BusEstimatePage.dart';
import 'package:taiwan_bus/utils/Log.dart';
import 'package:taiwan_bus/utils/MyUtil.dart';

class InitPage extends BaseView{
  @override
  State<StatefulWidget> createState() => _InitPageViewState();
}

class _InitPageViewState extends BaseViewState<IInitPresenter, InitPage> implements IInitView {
  static const String _TAG = "_InitPageViewState";

  Completer<CameraPosition> _initPosition = Completer();
  GoogleMapController _mapController;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  LatLng _myPosition;
  List<MyStopBean> _stops = [];
  Map<int, Marker> _markers = {};
  int _selectIndex;
  bool _showSearch = false;
  bool _showDetail = false;

  @override
  void initState() {
    super.initState();
    presenter.initPosition();
  }

  @override
  IInitPresenter createPresenter() => InitPresenter();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        body: SafeArea(child: Column(
          children: [
            Container(
              height: 38,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: MyColor.DIVIDER),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: Row(
                children: [
                  Expanded(child: _buildSearch()),
                  IconButton(icon: Icon(Icons.search), onPressed: _onSearchClick)
                ],
              )
            ),
            Expanded(child: Stack(
              alignment: Alignment.center,
              children: [
                _buildGoogleMap(),
                Positioned(
                    top: 12,
                    right: 12,
                    child: _buildMyPositionButton()
                ),
                Visibility(
                  visible: !_showDetail,
                  child: _buildSearchList()
                ),
                _showDetail ? _buildMarkDetail() : Container(),
              ],
            )),
          ],
        ))
    );
  }

  Widget _buildGoogleMap(){
    return FutureBuilder<CameraPosition>(
      future: _initPosition.future,
      builder: (context, snapshot) {
        if(snapshot.data != null){
          return GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            initialCameraPosition: snapshot.data,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            markers: Set<Marker>.from(_markers.values),
            onTap: (latLng){
              _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
              presenter.getNearStops(latLng);
            },
          );
        }else{
          return Center(
            child: Text(s.positioning),
          );
        }
      },
    );
  }

  Widget _buildSearchList(){
    return Align(
      alignment: Alignment.topCenter,
      child: _showSearch ? Container(
        height: 225,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(child: Container(
              color: Colors.white,
              child: ScrollablePositionedList.separated(
                initialScrollIndex: _selectIndex ?? 0,
                itemCount: _stops.length,
                itemBuilder: (context, index){
                  MyStopBean myStop = _stops[index];

                  return Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(myStop.getStopMap().keys.join(", "), style: TextStyle(
                              color: _selectIndex == index ? MyColor.PRIMARY : MyColor.TEXT
                            )),
                            FutureBuilder(
                              future: myStop.address,
                              builder: (context, res){
                                return Text(res.data ?? "", style: TextStyle(
                                    fontSize: 13,
                                    color: _selectIndex == index ? MyColor.PRIMARY : MyColor.HINT_TEXT
                                ));
                              }
                            )
                          ],
                        ),
                      ),
                      onTap: (){
                        _onStopSelect(index);
                      },
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(height: 0);
                },
              ),
            )),
            Material(
              color: MyColor.CONTAINER_BACKGROUND,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
              ),
              elevation: 3,
              child: InkWell(
                child: Container(
                  width: 50,
                  child: Icon(Icons.arrow_drop_up),
                ),
                onTap: (){
                  setState(() {
                    _showSearch = false;
                    _updateMarker(null);
                  });
                }
              ),
            )
          ],
        ),
      ) : Material(
        color: MyColor.CONTAINER_BACKGROUND,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)
        ),
        elevation: 3,
        child: InkWell(
            child: Container(
              width: 50,
              child: Icon(Icons.arrow_drop_down),
            ),
            onTap: (){
              setState(() {
                _showSearch = true;
              });
            }
        ),
      ),
    );
  }

  Widget _buildMyPositionButton(){
    return Material(
      color: const Color(0xccffffff),
      elevation: 4,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(7),
          child: Icon(Icons.my_location),
        ),
        onTap: (){
          _searchController.clear();
          _mapController.animateCamera(CameraUpdate.newLatLngZoom(_myPosition, MyConfig.DEFAULT_ZOOM));
          presenter.getNearStops(_myPosition);
        },
      ),
    );
  }

  Widget _buildSearch(){
    return TextField(
      focusNode: _searchFocusNode,
      controller: _searchController,
      decoration: new InputDecoration(
        isDense: true,
        hintText: s.search_stop,
        counterText: '',
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: InputBorder.none,
      ),
      onSubmitted: (value){
        _onSearchClick();
      },
    );
  }

  Widget _buildMarkDetail(){
    final stops = _stops[_selectIndex].getStopMap();
    List<String> keys = stops.keys.toList();

    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        padding: EdgeInsets.only(left: 30),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                color: MyColor.CONTAINER_BACKGROUND,
                elevation: 4,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Container(
                  height: 201,
                  width: 152,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: MyColor.PRIMARY,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            )
                        ),
                        child: Text(s.route_detail,
                          style: TextStyle(
                              fontSize: 17,
                              color: MyColor.DARK_THEME_TEXT
                          ),
                        ),
                      ),
                      Expanded(child: ListView.builder(
                          padding: EdgeInsets.only(left: 8, right: 8, top: 3.5),
                          itemCount: keys.length,
                          itemBuilder: (context, index){
                            String stopName = keys[index];
                            String routes = stops[stopName].map((stop) => stop.routeName.zhTw).toSet().join(", ");
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(stopName, style: TextStyle(
                                    fontWeight: FontWeight.bold
                                )),
                                Text(routes, style: TextStyle(
                                    fontSize: 15
                                ))
                              ],
                            );
                          }
                      )),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(MyColor.PRIMARY),
                                foregroundColor: MaterialStateProperty.all(MyColor.DARK_THEME_TEXT),
                                minimumSize: MaterialStateProperty.all(Size(0, 30)),
                                padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 10))
                            ),
                            onPressed: (){
                              routePush(BusEstimatePage(_stops[_selectIndex].stops));
                            },
                            child: Text(s.schedule)
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6),
                child: Material(
                  color: MyColor.HINT_TEXT,
                  shape: CircleBorder(),
                  elevation: 3,
                  child: InkWell(
                    customBorder: CircleBorder(),
                    child: Container(
                      padding: EdgeInsets.all(3),
                      child: Icon(Icons.close,
                        color: MyColor.DARK_THEME_TEXT,
                        size: 20,
                      ),
                    ),
                    onTap: _closeMarkDetail,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: _closeMarkDetail,
      onPanStart: _closeMarkDetail,
    );
  }


  // -------------------- view --------------------
  void _onSearchClick(){
    String name = _searchController.text.trim();
    if(name.isNotEmpty)
      presenter.getStopsByName(name);
  }

  void _closeMarkDetail([details]){
    setState(() {
      _showDetail = false;
      if(!_showSearch && _selectIndex != null){
        int index = _selectIndex;
        _selectIndex = null;
        _addMarker(index);
      }
    });
  }

  void _updateMarker(int index){
    setState(() {
      if(_selectIndex != null && _selectIndex != index){
        int old = _selectIndex;
        _selectIndex = null;
        _addMarker(old);
      }

      if(index != null){
        _selectIndex = index;
        _addMarker(_selectIndex);
      }
    });
  }

  void _onMarkerClick(int index) async {
    ScreenCoordinate screenCoordinate = await _mapController.getScreenCoordinate(_stops[index].position);
    LatLng moveTo  = await _mapController.getLatLng(ScreenCoordinate(x: screenCoordinate.x - 220, y: screenCoordinate.y - 40));
    await _mapController.animateCamera(CameraUpdate.newLatLng(moveTo));

    _showDetail = true;
    _updateMarker(index);
  }

  void _onStopSelect(int index) async {
    await _mapController.animateCamera(CameraUpdate.newLatLng(_stops[index].position));
    _updateMarker(index);
  }

  void _addMarker(int index){
    if(_markers.containsKey(index))
      _markers.remove(index);

    LatLng position = _stops[index].position;
    Marker marker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(index == _selectIndex ? BitmapDescriptor.hueOrange : BitmapDescriptor.hueRed),
        markerId: MarkerId(index.toString()),
        position: position,
        // infoWindow: InfoWindow(
        //     title: station.stationName.zhTw,
        //     snippet: station.stops.map((stop) => stop.stopName.zhTw).toList().join("<br/>")
        // ),
        onTap: () {
          _onMarkerClick(index);
        }
    );
    _markers[index] = marker;
  }

  // -------------------- mvp --------------------
  @override
  void getNearStopsCallback(List<MyStopBean> stopList) {
    _stops = stopList;
    setState(() {
      _searchFocusNode.unfocus();
      _markers.clear();

      _selectIndex = null;
      _stops.forEach((mStop) {
        int index = _stops.indexOf(mStop);
        _addMarker(index);
      });
    });
  }

  @override
  void updateMyPosition(LatLng position) {
    if(position == null)
      return;

    if(!_initPosition.isCompleted){
      final camera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: MyConfig.DEFAULT_ZOOM,
      );
      _initPosition.complete(camera);
    }else{
      final MyUtil myUtil = MyUtil();
      var dis = myUtil.calculateDistance(_myPosition.latitude, _myPosition.longitude, position.latitude, position.longitude);
      if(dis * 1000 < 15)
        return;
      Log.d("$_TAG => my position: $position, move path: $dis km");
    }

    _myPosition = position;
    presenter.getNearStops(_myPosition);
  }
}