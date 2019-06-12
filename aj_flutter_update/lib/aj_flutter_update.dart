import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class AjFlutterUpdate {
  static const MethodChannel _channel =
      const MethodChannel('aj_flutter_update');

  //todo  iOS 更新跳转外部链接 Android
  static Future<void> iOSUpdateApp(String urlString){
    if(urlString.isNotEmpty){
      if(Platform.isIOS){
        return _channel.invokeMethod('launchUrl', {'url': urlString});
      } else {
        //TODO  Android处理下载功能
        return null;
      }
    }
  }

}
