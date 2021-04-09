import 'dart:async';

class MyTimer {
  static const String _TAG = "MyTimer";

  static MyTimer _instance;
  Timer _timer;
  int _count = 0;
  List<void Function(int count)> _updateList = [];

  static MyTimer get instance {
    if(_instance == null)
      _instance = MyTimer._();
    return _instance;
  }

  MyTimer._(){
    print("timer start");
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _count++;
      if(_updateList.length > 0) {
        if(_count % 10 == 0)
          print("$_TAG => count: $_count");
        _updateList.last(_count);
      }else{
        print("$_TAG => clear");
        _timer.cancel();
        _timer = null;
        _instance = null;
      }
    });
  }

  void reset(){
    print("$_TAG => reset");
    _count = 0;
  }

  void addUpdate(void Function(int count) update){
    print("$_TAG => addUpdate");
    reset();
    _updateList.add(update);
  }

  void removeUpdate(){
    print("$_TAG => removeUpdate");
    reset();
    _updateList.removeLast();
  }

}