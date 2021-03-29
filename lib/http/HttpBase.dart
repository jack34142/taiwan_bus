import 'package:dio/dio.dart';
import 'package:taiwan_bus/config/MyConfig.dart';
import 'HttpUtil.dart';

enum RepairType{
  PROCESSED,
  RETURNED,
  SCRAPPED,
  REPAIRED,
  RENEWED
}

class HttpBase extends HttpUtil {
  static const String _TAG = "HttpClient";

  final void Function(bool isLoading) _loadingController;
  final void Function(dynamic e) _onError;
  List<Dio> _queue = [];

//  factory HttpClient() => _getInstance();
//   static HttpBase _instance;
//   static HttpBase get instance => _getInstance();
//
//   HttpBase._();
//
//   static _getInstance() {
//     if (_instance == null) {
//       _instance = new HttpBase._();
//     }
//     return _instance;
//   }

  HttpBase(this._loadingController, this._onError);

  @override
  String getBaseUrl() {
    return MyConfig.BASE_API;
  }
  
  void mRequest(Method method, String path,
      {Map<String, dynamic> params,
        Map<String, dynamic> headers,
        ContentType contentType: ContentType.URLENCODE,
        onResponse(Response response),
        onError(DioError e),
        onComplete()}){

    Dio dio = request(method, path,
      params: params,
      headers: headers,
      contentType: contentType,
      onResponse: onResponse,
      onError: (e){
        if(e is DioError && onError != null)
          onError(e);
        else
          _onError(e);
      },
      onComplete: (dio){
        _queue.remove(dio);
        _loadingController(false);
        if(onComplete != null)
          onComplete();
      }
    );
    _queue.add(dio);
    _loadingController(true);
  }

  void clear(){
    _queue.forEach((dio) {
      dio.close(force: true);
    });
  }

/**
以座標(latitude,longitude)為中心,
搜索半徑 rangeRadius 以內的站牌, 並取得經過的公車
p.s. rangeRadius 不能超過 1000
*/
  void getNearStops(double latitude, double longitude, {int rangeRadius: 500,
      void Function(Response response) onResponse, Function(Exception e) onError, Function() onComplete}){

    Map<String, dynamic> params = new Map();
    params["\$select"] = "StationPosition, Stops";
    params["\$spatialFilter"] = "nearby(StationPosition, $latitude, $longitude, $rangeRadius)";
    params["\$format="] = "JSON";

    return mRequest(Method.GET, "Station/InterCity", params: params,
        headers: MyConfig.ptxHeader,
        onResponse: onResponse, onError: onError, onComplete: onComplete);
  }

/**
查詢通過指定 stopUid 的公車預估時間
*/
  void getBusEstimate(Set<String> stopUids,
      {void Function(Response response) onResponse, Function(Exception e) onError, Function() onComplete}){

    Map<String, dynamic> params = new Map();
    params["\$select"] = "PlateNumb, SubRouteUID, SubRouteID, SubRouteName, StopID, StopName, CurrentStop, DestinationStop";
    params["\$filter"] = "StopUID in (${stopUids.map((stopUid) => "'$stopUid'").toList().join(",")}) and (StopStatus eq 0 or StopStatus eq 1)";
    params["\$orderby"] = "EstimateTime desc";
    params["\$format="] = "JSON";

    return mRequest(Method.GET, "EstimatedTimeOfArrival/InterCity", params: params,
        headers: MyConfig.ptxHeader,
        onResponse: onResponse, onError: onError, onComplete: onComplete);
  }

/**
查詢通過指定 platNumb(車牌) 的公車抵達各站點預估時間
*/
  void getBusPosition(String platNumb,
      {void Function(Response response) onResponse, Function(Exception e) onError, Function() onComplete}){

    Map<String, dynamic> params = new Map();
    params["\$select"] = "StopID, StopName, SubRouteUID";
    params["\$filter"] = "PlateNumb eq '$platNumb'";
    params["\$orderby"] = "StopSequence";
    params["\$format="] = "JSON";

    return mRequest(Method.GET, "EstimatedTimeOfArrival/InterCity", params: params,
        headers: MyConfig.ptxHeader,
        onResponse: onResponse, onError: onError, onComplete: onComplete);
  }

/**
取得指定 subRouteUID 所經過站牌
*/
  void getBusStops(Set<String> routes,
      {void Function(Response response) onResponse, Function(Exception e) onError, Function() onComplete}){

    Map<String, dynamic> params = new Map();
    params["\$select"] = "SubRouteUID, Operators, Stops";
    params["\$filter"] = "SubRouteUID in (${routes.map((subRouteUid) => "'$subRouteUid'").toList().join(",")})";
    params["\$format="] = "JSON";

    return mRequest(Method.GET, "StopOfRoute/InterCity", params: params,
        headers: MyConfig.ptxHeader,
        onResponse: onResponse, onError: onError, onComplete: onComplete);
  }
}
