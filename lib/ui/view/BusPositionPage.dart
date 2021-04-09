import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taiwan_bus/base/BaseView.dart';
import 'package:taiwan_bus/beans/BusEstimateBean.dart';
import 'package:taiwan_bus/beans/BusPositionBean.dart';
import 'package:taiwan_bus/beans/BusStopBean.dart';
import 'package:taiwan_bus/config/MyColor.dart';
import 'package:taiwan_bus/mvp/contract/BusPositionContract.dart';
import 'package:taiwan_bus/mvp/presenter/BusPositionPresenter.dart';
import 'package:taiwan_bus/singleTon/MyTimer.dart';
import 'package:taiwan_bus/ui/scaffold/CommonScaffold.dart';

class BusPositionPage extends BaseView{

  final BusEstimateBean estimateBean;
  final BusStopBean stopBean;
  final String title;

  BusPositionPage(this.estimateBean, this.stopBean, {this.title});

  @override
  State<StatefulWidget> createState() => _BusPositionPageState();
}

class _BusPositionPageState extends BaseViewState<IBusPositionPresenter, BusPositionPage> implements IBusPositionView {

  int _countTime = 0;
  Map<String, BusPositionBean> _positions = {};

  @override
  IBusPositionPresenter createPresenter() => BusPositionPresenter();

  @override
  void afterInit() {
    super.afterInit();
    MyTimer.instance.addUpdate((count) {
      setState(() {
        _countTime = count;
      });
      if(_countTime % 60 == 0)
        presenter.getBusPosition(widget.estimateBean.plateNumb);
    });
    presenter.getBusPosition(widget.estimateBean.plateNumb);
  }

  @override
  void dispose() {
    super.dispose();
    MyTimer.instance.removeUpdate();
  }

  @override
  Widget build(BuildContext context) {

    return CommonScaffold(
      title: widget.title,
      body: ListView.separated(
        itemCount: widget.stopBean.stops.length,
        itemBuilder: (context, index){
          Stops stop = widget.stopBean.stops[index];
          return _buildListItem(stop);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(height: 0);
        },
      )
    );
  }

  Widget _buildListItem(Stops stop){
    BusPositionBean positionBean = _positions[stop.stopID];

    String estimateStr;
    if(positionBean != null){
      int estimateTime = positionBean.estimateTime;
      if(estimateTime != null){
        estimateTime = estimateTime - _countTime;
        if(estimateTime <= 60)
          estimateStr = s.coming_soon;
        else
          estimateStr = s.minute_second((estimateTime ~/ 60).toString(), (estimateTime % 60).toString());
      }else{
        estimateStr = s.no_departure;
      }
    }

    String stopBoarding;
    switch(stop.stopBoarding){
      case -1:
        stopBoarding = s.get_off;
        break;
      case 0:
        stopBoarding = s.get_on_and_off;
        break;
      case 1:
        stopBoarding = s.get_on;
        break;
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: 50,
      ),
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 8),
        child: Row(
          children: [
            Expanded(child: Row(
              children: [
                Flexible(child: Text(stop.stopName.zhTw)),
                stop.stopID == widget.estimateBean.stopID ? _buildMyPosition() : Container()
              ],
            )),
            Container(
              alignment: Alignment.center,
              width: 90,
              child: Column(
                children: [
                  // _buildHint("($stopBoarding)${busBusEstimate.stopName.zhTw}"),
                  _buildHint(stopBoarding),
                  estimateStr != null ? Text(estimateStr) : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyPosition(){
    return Container(
      margin: EdgeInsets.only(left: 4, top: 2),
      padding: EdgeInsets.only(bottom: 1, right: 2, left: 1),
      decoration: BoxDecoration(
        border: Border.all(color: MyColor.PRIMARY),
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Text(s.selected_stop,
        style: TextStyle(
          color: MyColor.PRIMARY,
          fontSize: 13
        ),
      ),
    );
  }

  Widget _buildHint(String text){
    return Text(text ?? "",
      style: TextStyle(
          fontSize: 14,
          color: MyColor.HINT_TEXT
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  // -------------------- mvp --------------------
  @override
  void getBusPositionCallback(List<BusPositionBean> positions) {
    if(positions.isNotEmpty){
      if (positions.first.subRouteUID != widget.stopBean.subRouteUID){
        showToast(s.route_change);
        Navigator.pop(context);
        return;
      }
    }

    setState(() {
      _positions.clear();
      positions.forEach((positionBean) {
        _positions[positionBean.stopID] = positionBean;
      });
      _countTime = 0;
      MyTimer.instance.reset();
    });
  }
}