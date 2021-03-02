import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:taiwan_bus/base/BaseView.dart';
import 'package:taiwan_bus/mvp/contract/InitContract.dart';
import 'package:taiwan_bus/mvp/presenter/InitPresenter.dart';
import 'package:taiwan_bus/ui/scaffold/CommonScaffold.dart';

class InitPage extends BaseView{
  @override
  State<StatefulWidget> createState() => _InitPageViewState();
}

class _InitPageViewState extends BaseViewState<IInitPresenter, InitPage> implements IInitView {

  @override
  IInitPresenter createPresenter() => InitPresenter();

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
        body: Text("init page")
    );
  }
}