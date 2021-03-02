import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:taiwan_bus/utils/Log.dart';

enum Method { GET, POST }

enum ContentType {
  URLENCODE,
  JSON
}

class HttpUtil {
  static const String _TAG = "HttpUtil";

  String getBaseUrl() {
    return "";
  }

  Dio request(Method method, String path,
      {Map<String, dynamic> params,
      Map<String, dynamic> headers,
      ContentType contentType: ContentType.URLENCODE,
      @required onResponse(String response),
      onError(e),
      onComplete(Dio dio)}) {
    String url = getBaseUrl() + path;

    Dio dio = new Dio();
    dio.options.connectTimeout = 30000;
//    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
//      client.badCertificateCallback =
//          (X509Certificate cert, String host, int port) => host == Uri.parse(url).host;
//      return client;
//    };
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      StringBuffer stringBuffer = new StringBuffer();
      stringBuffer.write("----- onRequest -----\n");
      stringBuffer
      .write("(" + options.method + ") " + options.uri.toString() + "\n");
      stringBuffer.write("header: " + options.headers.toString() + "\n");
      stringBuffer.write("data: " + options.data.toString() + "\n");
      stringBuffer
          .write("queryParameters: " + options.queryParameters.toString());
      Log.d(stringBuffer.toString());
      return options; //continue
    }, onResponse: (Response response) {
      StringBuffer stringBuffer = new StringBuffer();
      stringBuffer.write("----- onResponse -----\n");
      stringBuffer
          .write("statusCode = " + response.statusCode.toString() + "\n");
      String body = response.data.toString();
      stringBuffer.write(body);
      Log.d(stringBuffer.toString());
      return response; // continue
    }, onError: (DioError e) {
      StringBuffer stringBuffer = new StringBuffer();
      stringBuffer.write("----- onError -----\n");
      if (e.response != null) {
        stringBuffer.write("statusCode = " + e.response.statusCode.toString() + "\n");
        String body = e.response.data.toString();
        stringBuffer.write(body);
      }else{
        stringBuffer.write(e.message);
      }
      Log.e(stringBuffer.toString());
      return e; //continue
    }));

    if (headers != null) dio.options.headers.addAll(headers);

    Future<Response<dynamic>> mResponse;
    switch (method) {
      case Method.GET:
        mResponse = dio.get(url, queryParameters: params);
        break;
      case Method.POST:
        switch(contentType){
          case ContentType.JSON:
            break;
          case ContentType.URLENCODE:
          default:
            dio.options.contentType = "application/x-www-form-urlencoded";
            break;
        }
        mResponse = dio.post(url, data: params);
        break;
      default:
        throw("no match http method");
    }
    mResponse
      .then((response) => onResponse(response.data.toString()))
      .catchError((e, stackTrace){
        print(e);
        print(stackTrace);
        if(onError != null) onError(e);
      })
      .whenComplete((){
        if (onComplete != null) onComplete(dio);
      });
    return dio;
  }
}
