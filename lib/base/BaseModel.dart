import 'package:taiwan_bus/http/HttpBase.dart';
import 'IModel.dart';

abstract class BaseModel implements IModel {

  HttpBase http;

  @override
  void dispose() {
    http.clear();
  }
}