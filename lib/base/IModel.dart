import 'package:taiwan_bus/http/HttpBase.dart';

abstract class IModel {
    void dispose();
    HttpBase http;
}