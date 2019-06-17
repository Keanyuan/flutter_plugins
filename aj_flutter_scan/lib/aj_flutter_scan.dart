import 'dart:async';

import 'package:flutter/services.dart';

class AjFlutterScan {
  static const MethodChannel _channel =
      const MethodChannel('aj_flutter_scan');

  static Future<String> get getBarCode async {
    final String version = await _channel.invokeMethod('getBarCode');
    return version;
  }
}
