import 'dart:async';

import 'package:flutter/services.dart';

class AjFlutterScan {
  static const MethodChannel _channel =
      const MethodChannel('aj_flutter_scan');
  static const CameraAccessDenied = 'PERMISSION_NOT_GRANTED'; //权限不足
  static const ScanCancle = 'SCAN_CANCLE'; //取消扫描
  static const CheckError = 'CHECK_ERROR'; //图片扫描失败


  //todo iOS需要添加如下内容
//  <key>NSCameraUsageDescription</key>
//  <string>允许应用在扫码功能中使用您的摄像头</string>
//  <key>NSPhotoLibraryUsageDescription</key>
//  <string>需要访问你的相册</string>
//  <key>NSMicrophoneUsageDescription</key>
//  <string>需要访问你的麦克风</string>
  static Future<String> get getBarCode async {
    final String version = await _channel.invokeMethod('getBarCode');
    return version;
  }


  static Future<String> checkQRCode(String imageFile) async {
    final String version = await _channel.invokeMethod('checkQRCode',{"imageFile": imageFile});
    return version;
  }
}
