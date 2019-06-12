import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aj_flutter_update/aj_flutter_update.dart';

void main() {
  const MethodChannel channel = MethodChannel('aj_flutter_update');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
