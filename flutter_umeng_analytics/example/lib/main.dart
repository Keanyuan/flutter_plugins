import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_umeng_analytics/flutter_umeng_analytics.dart';

import 'aj_crash_collect.dart';

void main() async {
  if (Platform.isIOS) {
    UMengAnalytics.init("iOS AppKey",
        encrypt: true, reportCrash: false); //app debug
  } else {
    UMengAnalytics.init('5cda29173fc195b666000ced',
        policy: Policy.BATCH, encrypt: true, reportCrash: false);
  }
  AJCrashCollect.init(() {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new RaisedButton(
                  onPressed: () {
                    UMengAnalytics.logEvent("hello");
                  },
                  child: new Text('Running on: hello'),
                ),
                Container(
                  height: 200,
                  child: Text("测试"),
                ),
                Container(
                  height: 200,
                  child: Text("测试"),
                ),
                Container(
                  height: 200,
                  child: Text("测试"),
                ),
                Container(
                  height: 200,
                  child: Text("测试"),
                ),
                Container(
                  height: 200,
                  child: Text("测试"),
                ),
              ]),
        ),
      ),
    );
  }
}
