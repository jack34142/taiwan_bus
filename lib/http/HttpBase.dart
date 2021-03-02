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
    return MyConfig.BASE_URL;
  }
  
  void mRequest(Method method, String path,
      {Map<String, dynamic> params,
        Map<String, dynamic> headers,
        ContentType contentType: ContentType.URLENCODE,
        onResponse(String response),
        onError(DioError e),
        onComplete()}){

    Dio dio = request(method, path,
      params: params,
      headers: headers,
      contentType: contentType,
      onResponse: onResponse,
      onError: (e){
        if(onError == null)
          _onError(e);
        else
          e is DioError ? onError(e) : _onError(e);
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
}
