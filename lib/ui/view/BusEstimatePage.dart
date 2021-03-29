import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taiwan_bus/base/BaseView.dart';
import 'package:taiwan_bus/beans/BusEstimateBean.dart';
import 'package:taiwan_bus/beans/BusStationBean.dart';
import 'package:taiwan_bus/beans/BusStopBean.dart';
import 'package:taiwan_bus/config/MyColor.dart';
import 'package:taiwan_bus/mvp/contract/BusEstimateContract.dart';
import 'package:taiwan_bus/mvp/presenter/BusEstimatePresenter.dart';
import 'package:taiwan_bus/singleTon/MyTimer.dart';
import 'package:taiwan_bus/ui/scaffold/CommonScaffold.dart';
import 'package:taiwan_bus/ui/view/BusPositionPage.dart';

class BusEstimatePage extends BaseView{

  final BusStationBean station;

  BusEstimatePage(this.station);

  @override
  State<StatefulWidget> createState() => _BusEstimatePageState();
}

class _BusEstimatePageState extends BaseViewState<IBusEstimatePresenter, BusEstimatePage>
    with SingleTickerProviderStateMixin implements IBusEstimateView {

  List<Tab> _tabs;
  TabController _tabController;
  Set<String> _stopUids = Set();
  int _countTime = 0;
  List<BusEstimateBean> _estimateBean = [];
  List<Map<String, BusStopBean>> _stops = [{},{},{}];

  @override
  IBusEstimatePresenter createPresenter() => BusEstimatePresenter();

  @override
  void initState() {
    super.initState();
    widget.station.stops.forEach((stop){
      _stopUids.add(stop.stopUID);
    });
  }

  @override
  void afterInit() {
    super.afterInit();
    presenter.getBusEstimate(_stopUids);
    setState(() {
      _tabs = [
        Tab(text: s.outbound),
        Tab(text: s.return_trip),
        Tab(text: s.loop)
      ];
      _tabController = TabController(
        length: _tabs.length,
        vsync: this,
      );
    });

    MyTimer.instance.addUpdate((count) {
      setState(() {
        _countTime = count;
      });
      if(_countTime % 60 == 0)
        presenter.getBusEstimate(_stopUids);
    });
  }

  @override
  void dispose() {
    super.dispose();
    MyTimer.instance.removeUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final datas = _estimateBean.where((estimateBean) => estimateBean.direction == _tabController.index).toList();
    return CommonScaffold(
        body: _tabs != null ? Column(
          children: [
            _buildTabBar(),
            Expanded(child: ListView.separated(
              itemCount: datas.length,
              itemBuilder: (context, index){
                BusEstimateBean busBusEstimate = datas[index];
                return _buildListItem(busBusEstimate);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(height: 0);
              },
            ))
          ],
        ) : Container()
    );
  }

  Widget _buildListItem(BusEstimateBean estimateBean){
    String estimateStr;
    if(estimateBean.estimateTime != null){
      int estimateTime = estimateBean.estimateTime - _countTime;
      if(estimateTime <= 60)
        estimateStr = s.coming_soon;
      else
        estimateStr = s.minute_second((estimateTime ~/ 60).toString(), (estimateTime % 60).toString());
    }else{
      estimateStr = s.no_departure;
    }

    String currentStop, nextStop, stopBoarding, routeName;
    BusStopBean stopBean = _stops[_tabController.index][estimateBean.subRouteUID];
    if(stopBean != null){
      routeName = "${stopBean.stops.first.stopName.zhTw} 往 ${stopBean.stops.last.stopName.zhTw}";

      int len_stops = stopBean.stops.length;
      for(int i=0; i<len_stops; i++){
        final stop = stopBean.stops[i];
        if(currentStop == null && stop.stopID == estimateBean.currentStop){
          currentStop = stop.stopName.zhTw;
          if(i < len_stops-1){
            nextStop = stopBean.stops[i+1].stopName.zhTw;
          }else{
            nextStop = currentStop;
          }
        }
        if(stopBoarding == null && stop.stopID == estimateBean.stopID){
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
        }
        if(currentStop != null && stopBoarding != null)
          break;
      }
    }

    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 78,
                  child: Column(
                    children: [
                      stopBean != null ? Text(stopBean.operators.map((operator) => operator.operatorName.zhTw).join("\n")) : Container(),
                      Text(estimateBean.subRouteName.zhTw)
                    ],
                  ),
                ),
                Expanded(child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCurrentStop(currentStop, nextStop),
                      Text(routeName ?? ""),
                    ],
                  ),
                )),Container(
                  alignment: Alignment.center,
                  width: 90,
                  child: Column(
                    children: [
                      // _buildHint("($stopBoarding)${busBusEstimate.stopName.zhTw}"),
                      _buildHint(stopBoarding),
                      Text(estimateStr)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: (){
        String title = "${stopBean.operators.map((operator) => operator.operatorName.zhTw).join("/")} ${estimateBean.subRouteName.zhTw}";
        routePush(BusPositionPage(estimateBean, stopBean, title: title)).whenComplete((){
          presenter.getBusEstimate(_stopUids);
        });
      },
    );
  }

  Widget _buildCurrentStop(String currentStop, String nextStop){
    if(currentStop == null){
      return Container();
    }else if(currentStop == nextStop){
      return _buildHint(s.next_end);
    }else{
      return Row(
        children: [
          Flexible(child: _buildHint(currentStop)),
          _buildHint(" -> "),
          Flexible(child: _buildHint(nextStop))
        ],
      );
    }
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

  Widget _buildTabBar() {
    return Container(
      height: 43,
      // padding: EdgeInsets.only(bottom: 5),
      child: TabBar(
          controller: _tabController,
          tabs: _tabs,
          labelColor: MyColor.PRIMARY,
          unselectedLabelColor: MyColor.HINT_TEXT,
          indicatorColor: MyColor.PRIMARY,
          // indicatorSize: TabBarIndicatorSize.label,
          // labelPadding: EdgeInsets.only(top: 7),
          indicatorWeight: 3,
          labelStyle: TextStyle(
            fontSize: 18,
          ),
          onTap: (index){
            setState(() {});
          }
      ),
    );
    // return Container(
    //   margin: EdgeInsets.only(left: 25, right: 25, bottom: 10, top: 4),
    //   child: MyTabBar([MyTabItem(s.my_group), MyTabItem(s.join_group)],
    //       onChange: (index) {
    //     MainContainer.setPageChangeListener(GroupContainer.TAG, null);
    //     setState(() {
    //       _currentIndex = index;
    //     });
    //   }),
    // );
  }

  // -------------------- mvp --------------------
  @override
  void getBusEstimateCallback(List<BusEstimateBean> estimateBean) {
    setState(() {
      _estimateBean.clear();
      _estimateBean.addAll(estimateBean);

      _countTime = 0;
      MyTimer.instance.reset();
    });
  }

  @override
  void getBusStopsCallback(List<BusStopBean> stops) {
    setState(() {
      stops.forEach((stopBean) {
        _stops[stopBean.direction][stopBean.subRouteUID] = stopBean;
      });
    });
  }

}