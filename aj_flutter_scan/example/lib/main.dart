import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:aj_flutter_scan/aj_flutter_scan.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _barCode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String barCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
//    PermissionStatus status =
//        await SimplePermissions.requestPermission(Permission.Camera);
//    if (status == PermissionStatus.authorized) {
      try {
        barCode = await AjFlutterScan.getBarCode;
      } catch (e) {
        if (e.code == AjFlutterScan.CameraAccessDenied) {
          print("扫描失败,请在iOS\"设置\"-\"隐私\"-\"相机\"中开启权限");
        } else if (e.code == AjFlutterScan.ScanCancle) {
          print("Unknown error: 取消扫描 ${e.code}");
        } else {
          print("Unknown error: $e");
        }
      }
//    } else {
//      String positiveMsg = Platform.isIOS ? "确定" : "前往";
//      String msg = Platform.isIOS
//          ? "扫描失败,请在iOS\"设置\"-\"隐私\"-\"相机\"中开启权限"
//          : '"相机权限获取失败,是否跳转“应用信息”>“权限”中开启相机权限？"';
//
//      AppUtils.showCommonDialog(context,
//          msg: msg, negativeMsg: '取消', positiveMsg: positiveMsg, onDone: () {
//        if (Platform.isAndroid) {
//          SimplePermissions.openSettings().then((openSuccess) {
//            if (openSuccess != true) {}
//          });
//        }
//      });
//    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _barCode = barCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              initPlatformState();
            },
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(minHeight: 60),
              width: 300,
              child: Text('点击 Barcode is: $_barCode\n'),
            ),
          ),
        ),
      ),
    );
  }
}
