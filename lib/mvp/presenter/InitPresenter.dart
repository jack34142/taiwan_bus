import 'package:taiwan_bus/base/BasePresenter.dart';
import 'package:taiwan_bus/base/IModel.dart';
import 'package:taiwan_bus/mvp/contract/InitContract.dart';
import 'package:taiwan_bus/mvp/model/InitModel.dart';

class InitPresenter extends BasePresenter<IInitView, IInitModel> implements IInitPresenter {
  @override
  IModel createModel() => InitModel();
}