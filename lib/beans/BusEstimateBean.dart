/// PlateNumb : "KKA-1517"
/// StopUID : "THB296938"
/// StopID : "296938"
/// StopName : {"Zh_tw":"煉油廠","En":"Taoyuan Oil Refinery"}
/// RouteUID : "THB9069"
/// RouteID : "9069"
/// RouteName : {"Zh_tw":"9069","En":"9069"}
/// SubRouteUID : "THB906901"
/// SubRouteID : "906901"
/// SubRouteName : {"Zh_tw":"90690","En":"90690"}
/// Direction : 0
/// EstimateTime : 209
/// StopCountDown : 2
/// CurrentStop : "246357"
/// DestinationStop : "294069"
/// StopSequence : 14
/// StopStatus : 0
/// MessageType : 2
/// IsLastBus : false
/// DataTime : "2021-03-25T10:25:11+08:00"
/// SrcTransTime : "2021-03-25T10:27:06+08:00"
/// UpdateTime : "2021-03-25T10:27:07+08:00"

class BusEstimateBean {
  String _plateNumb;
  String _stopUID;
  String _stopID;
  StopName _stopName;
  String _routeUID;
  String _routeID;
  RouteName _routeName;
  String _subRouteUID;
  String _subRouteID;
  SubRouteName _subRouteName;
  int _direction;
  int _estimateTime;
  int _stopCountDown;
  String _currentStop;
  String _destinationStop;
  int _stopSequence;
  int _stopStatus;
  int _messageType;
  bool _isLastBus;
  String _dataTime;
  String _srcTransTime;
  String _updateTime;

  String get plateNumb => _plateNumb;
  String get stopUID => _stopUID;
  String get stopID => _stopID;
  StopName get stopName => _stopName;
  String get routeUID => _routeUID;
  String get routeID => _routeID;
  RouteName get routeName => _routeName;
  String get subRouteUID => _subRouteUID;
  String get subRouteID => _subRouteID;
  SubRouteName get subRouteName => _subRouteName;
  int get direction => _direction;
  int get estimateTime => _estimateTime;
  int get stopCountDown => _stopCountDown;
  String get currentStop => _currentStop;
  String get destinationStop => _destinationStop;
  int get stopSequence => _stopSequence;
  int get stopStatus => _stopStatus;
  int get messageType => _messageType;
  bool get isLastBus => _isLastBus;
  String get dataTime => _dataTime;
  String get srcTransTime => _srcTransTime;
  String get updateTime => _updateTime;

  BusEstimateBean({
    String plateNumb,
    String stopUID,
    String stopID,
    StopName stopName,
    String routeUID,
    String routeID,
    RouteName routeName,
    String subRouteUID,
    String subRouteID,
    SubRouteName subRouteName,
    int direction,
    int estimateTime,
    int stopCountDown,
    String currentStop,
    String destinationStop,
    int stopSequence,
    int stopStatus,
    int messageType,
    bool isLastBus,
    String dataTime,
    String srcTransTime,
    String updateTime}){
    _plateNumb = plateNumb;
    _stopUID = stopUID;
    _stopID = stopID;
    _stopName = stopName;
    _routeUID = routeUID;
    _routeID = routeID;
    _routeName = routeName;
    _subRouteUID = subRouteUID;
    _subRouteID = subRouteID;
    _subRouteName = subRouteName;
    _direction = direction;
    _estimateTime = estimateTime;
    _stopCountDown = stopCountDown;
    _currentStop = currentStop;
    _destinationStop = destinationStop;
    _stopSequence = stopSequence;
    _stopStatus = stopStatus;
    _messageType = messageType;
    _isLastBus = isLastBus;
    _dataTime = dataTime;
    _srcTransTime = srcTransTime;
    _updateTime = updateTime;
  }

  BusEstimateBean.fromJson(dynamic json) {
    _plateNumb = json["PlateNumb"];
    _stopUID = json["StopUID"];
    _stopID = json["StopID"];
    _stopName = json["StopName"] != null ? StopName.fromJson(json["StopName"]) : null;
    _routeUID = json["RouteUID"];
    _routeID = json["RouteID"];
    _routeName = json["RouteName"] != null ? RouteName.fromJson(json["RouteName"]) : null;
    _subRouteUID = json["SubRouteUID"];
    _subRouteID = json["SubRouteID"];
    _subRouteName = json["SubRouteName"] != null ? SubRouteName.fromJson(json["SubRouteName"]) : null;
    _direction = json["Direction"];
    _estimateTime = json["EstimateTime"];
    _stopCountDown = json["StopCountDown"];
    _currentStop = json["CurrentStop"];
    _destinationStop = json["DestinationStop"];
    _stopSequence = json["StopSequence"];
    _stopStatus = json["StopStatus"];
    _messageType = json["MessageType"];
    _isLastBus = json["IsLastBus"];
    _dataTime = json["DataTime"];
    _srcTransTime = json["SrcTransTime"];
    _updateTime = json["UpdateTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["PlateNumb"] = _plateNumb;
    map["StopUID"] = _stopUID;
    map["StopID"] = _stopID;
    if (_stopName != null) {
      map["StopName"] = _stopName.toJson();
    }
    map["RouteUID"] = _routeUID;
    map["RouteID"] = _routeID;
    if (_routeName != null) {
      map["RouteName"] = _routeName.toJson();
    }
    map["SubRouteUID"] = _subRouteUID;
    map["SubRouteID"] = _subRouteID;
    if (_subRouteName != null) {
      map["SubRouteName"] = _subRouteName.toJson();
    }
    map["Direction"] = _direction;
    map["EstimateTime"] = _estimateTime;
    map["StopCountDown"] = _stopCountDown;
    map["CurrentStop"] = _currentStop;
    map["DestinationStop"] = _destinationStop;
    map["StopSequence"] = _stopSequence;
    map["StopStatus"] = _stopStatus;
    map["MessageType"] = _messageType;
    map["IsLastBus"] = _isLastBus;
    map["DataTime"] = _dataTime;
    map["SrcTransTime"] = _srcTransTime;
    map["UpdateTime"] = _updateTime;
    return map;
  }

}

/// Zh_tw : "90690"
/// En : "90690"

class SubRouteName {
  String _zhTw;
  String _en;

  String get zhTw => _zhTw;
  String get en => _en;

  SubRouteName({
    String zhTw,
    String en}){
    _zhTw = zhTw;
    _en = en;
  }

  SubRouteName.fromJson(dynamic json) {
    _zhTw = json["Zh_tw"];
    _en = json["En"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Zh_tw"] = _zhTw;
    map["En"] = _en;
    return map;
  }

}

/// Zh_tw : "9069"
/// En : "9069"

class RouteName {
  String _zhTw;
  String _en;

  String get zhTw => _zhTw;
  String get en => _en;

  RouteName({
    String zhTw,
    String en}){
    _zhTw = zhTw;
    _en = en;
  }

  RouteName.fromJson(dynamic json) {
    _zhTw = json["Zh_tw"];
    _en = json["En"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Zh_tw"] = _zhTw;
    map["En"] = _en;
    return map;
  }

}

/// Zh_tw : "煉油廠"
/// En : "Taoyuan Oil Refinery"

class StopName {
  String _zhTw;
  String _en;

  String get zhTw => _zhTw;
  String get en => _en;

  StopName({
    String zhTw,
    String en}){
    _zhTw = zhTw;
    _en = en;
  }

  StopName.fromJson(dynamic json) {
    _zhTw = json["Zh_tw"];
    _en = json["En"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Zh_tw"] = _zhTw;
    map["En"] = _en;
    return map;
  }

}