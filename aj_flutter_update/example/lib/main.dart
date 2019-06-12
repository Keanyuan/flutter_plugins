import 'package:flutter/material.dart';

import 'package:aj_flutter_update/aj_flutter_update.dart';

void main() => runApp(new MaterialApp(
      //application名字
      title: "FlutterApplication",
      //页面
      home: new AppWidget(),
    ));

class AppWidget extends StatefulWidget {
  AppWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _AppPageState();
  }
}

class _AppPageState extends State<AppWidget> with AjFlutterUpdateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: InkWell(
        child: Text('版本更新'),
        onTap: () {
          AjFlutterUpdateMixin.versionUpdate(
              context,
              "https://test1.4q.sk/flutter_hello_world.apk",
              "1，我的老哥==2，你的老妹",
              false);
        },
      ),
    ));
  }
}
