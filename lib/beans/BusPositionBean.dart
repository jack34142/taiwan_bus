/// StopID : "296938"
/// StopName : {"Zh_tw":"煉油廠","En":"Taoyuan Oil Refinery"}
/// SubRouteUID : "THB906901"
/// Direction : 0
/// EstimateTime : 669
/// StopCountDown : 6
/// StopSequence : 14
/// StopStatus : 0
/// MessageType : 2
/// IsLastBus : false
/// DataTime : "2021-03-29T10:36:50+08:00"
/// SrcTransTime : "2021-03-29T10:38:57+08:00"
/// UpdateTime : "2021-03-29T10:38:59+08:00"

class BusPositionBean {
  String _stopID;
  StopName _stopName;
  String _subRouteUID;
  int _direction;
  int _estimateTime;
  int _stopCountDown;
  int _stopSequence;
  int _stopStatus;
  int _messageType;
  bool _isLastBus;
  String _dataTime;
  String _srcTransTime;
  String _updateTime;

  String get stopID => _stopID;
  StopName get stopName => _stopName;
  String get subRouteUID => _subRouteUID;
  int get direction => _direction;
  int get estimateTime => _estimateTime;
  int get stopCountDown => _stopCountDown;
  int get stopSequence => _stopSequence;
  int get stopStatus => _stopStatus;
  int get messageType => _messageType;
  bool get isLastBus => _isLastBus;
  String get dataTime => _dataTime;
  String get srcTransTime => _srcTransTime;
  String get updateTime => _updateTime;

  BusPositionBean({
    String stopID,
    StopName stopName,
    String subRouteUID,
    int direction,
    int estimateTime,
    int stopCountDown,
    int stopSequence,
    int stopStatus,
    int messageType,
    bool isLastBus,
    String dataTime,
    String srcTransTime,
    String updateTime}){
    _stopID = stopID;
    _stopName = stopName;
    _subRouteUID = subRouteUID;
    _direction = direction;
    _estimateTime = estimateTime;
    _stopCountDown = stopCountDown;
    _stopSequence = stopSequence;
    _stopStatus = stopStatus;
    _messageType = messageType;
    _isLastBus = isLastBus;
    _dataTime = dataTime;
    _srcTransTime = srcTransTime;
    _updateTime = updateTime;
  }

  BusPositionBean.fromJson(dynamic json) {
    _stopID = json["StopID"];
    _stopName = json["StopName"] != null ? StopName.fromJson(json["StopName"]) : null;
    _subRouteUID = json["SubRouteUID"];
    _direction = json["Direction"];
    _estimateTime = json["EstimateTime"];
    _stopCountDown = json["StopCountDown"];
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
    map["StopID"] = _stopID;
    if (_stopName != null) {
      map["StopName"] = _stopName.toJson();
    }
    map["SubRouteUID"] = _subRouteUID;
    map["Direction"] = _direction;
    map["EstimateTime"] = _estimateTime;
    map["StopCountDown"] = _stopCountDown;
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