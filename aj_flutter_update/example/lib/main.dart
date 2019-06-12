import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:aj_flutter_update/aj_flutter_update.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: ListTile.divideTiles(tiles: [
            ListTile(
              title: Text("iOS跳转到外部链接"),
              onTap: () async {
                await AjFlutterUpdate.iOSUpdateApp("http://www.baidu.com");
              },
            ),
            ListTile(
              title: Text("Android下载apk"),
              onTap: () async {
              },
            ),
          ], context: context).toList(),
        ),
      ),
    );
  }
}
