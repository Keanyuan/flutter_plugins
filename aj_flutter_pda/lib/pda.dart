import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pda/commons.dart';

/*
@author wuyan
Date:2019/10/21
功能：PDA扫描、打印、读取车架号
 */
class Pda {
  static const MethodChannel _channel =
      const MethodChannel(Commons.pdaChannel);

  ///获取条形码或二维码的扫描结果
  static Future<String> startScan() async {
    final String result = await _channel.invokeMethod(Commons.startScanMethod);
    return result;
  }

  ///停止扫描
  static stopScan() {
     _channel.invokeMethod(Commons.stopScanMethod);
  }

  ///打印
  static print(Map map) {
   _channel.invokeMethod(Commons.printMethod,map);
  }

  ///走纸一张
  static goNextPage() {
    _channel.invokeMethod(Commons.goNextPageMethod);
  }

  ///读取车架号
  static Future<String> readRFIDCode() async {
    final rfidCode  = await _channel.invokeMethod(Commons.readRFIDCodeMethod);
    return rfidCode;
  }
}
