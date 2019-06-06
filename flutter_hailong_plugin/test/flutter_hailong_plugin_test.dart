import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hailong_plugin/flutter_hailong_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_hailong_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterHailongPlugin.platformVersion, '42');
  });
}
