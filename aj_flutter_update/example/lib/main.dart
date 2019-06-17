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
        child: Container(width: 200, height: 60, alignment: Alignment.center,child: Text('版本更新'),),
        onTap: () {
          AjFlutterUpdateMixin.versionUpdate(
            context: context,
            downloadUrl: "https://s3.cn-north-1.amazonaws.com.cn/anjiplus-ftp/6c2e042d-075f-450a-86eb-459f3722a7ad5084544252265841842.apk",
            updateLog: "1，我的老哥==2，你的老妹",//updateLog 以 == 做分割
            mustUpdate: false,
            titleColor: Color(0xFFFFA033),
            buttonColor: Colors.blue,
          );
        },
      ),
    ));
  }
}
