import 'package:flutter/material.dart';
import 'package:flutter_mqtt/dialogConstan.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
//import 'dart:async';
//import 'package:ez_mqtt_client/ez_mqtt_client.dart';

const TAG = "MQTT";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /*final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();*/

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _refresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //key: _scaffoldKey,
        appBar:
            AppBar(title: Text('Notifikasi'), backgroundColor: Color(0xFFF04950)),
        body: SmartRefresher(
          //key: _refreshIndicatorKey,
          //enablePullDown: true,
          onRefresh: _refresh,
          controller: _refreshController,
          //showChildOpacityTransition: false,
          child: ListView.builder(
              itemCount: Shistory.distance.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                      ListTile(
                        title: Text('${Shistory.distance[index]}' +
                            ' Tidak Menjaga Jarak\n'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${Shistory.mask[index]}' +
                                ' Tidak Memakai Masker'),
                            //Text('${Shistory.alarm[index]}' + ' Kali alarm bunyi'),
                          ],
                        ),
                      ),
                    ]));
              }),
        ),
      ),
    );
  }
}
