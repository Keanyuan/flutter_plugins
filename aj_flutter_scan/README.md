###集成方式
# aj_flutter_scan

###集成方式
话说前头：
example运行报错，需要集成到混合项目中，app中运行，
flutter run打包后的apk不支持armeabi-v7a，而android引用的so正好是基于armeabi-v7a，
所以运行会报找不到so的错误,这个问题后续解决

###一，For Android

    ##1，pubspec.yaml引用

    aj_flutter_scan:
       git:
          url: http://gitlab.anji-allways.com/mobileteam/modules.git
          path: aj_flutter_scan

    ##2，权限添加，在AndroidManifest.xml加入
    <uses-permission android:name="android.permission.FLASHLIGHT" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.CAMERA" />

    <uses-feature android:name="android.hardware.camera" />
    <uses-feature android:name="android.hardware.camera.autofocus" />
 
###二，iOS
```
Deployment Target 设置为 10.0
Podfile 中 target 'Runner' do 添加 use_frameworks! 支持swift
```

###三，dart层调用
      （1）引用
	  import 'package:simple_permissions/simple_permissions.dart';//permission request
	  import 'package:aj_flutter_scan/aj_flutter_scan.dart';
	  
     (2)使用	
   
  //扫一扫
  _onScanRequest() async {
    //权限先校验
    PermissionStatus status =
        await SimplePermissions.requestPermission(Permission.Camera);
    if (status == PermissionStatus.authorized) {
      String barcode = await AjFlutterScan.getBarCode;
      //成功回调
      _getWaybillNoByWaybillNo(barcode);
      Toast.toast(context, barcode);
    } else {
      String positiveMsg = Platform.isIOS ? "确定" : "前往";
      String msg = Platform.isIOS
          ? "扫描失败,请在iOS\"设置\"-\"隐私\"-\"相机\"中开启权限"
          : '"相机权限获取失败,是否跳转“应用信息”>“权限”中开启相机权限？"';

      AppUtils.showCommonDialog(context,
          msg: msg, negativeMsg: '取消', positiveMsg: positiveMsg, onDone: () {
        if (Platform.isAndroid) {
          SimplePermissions.openSettings().then((openSuccess) {
            if (openSuccess != true) {}
          });
        }
      });
    }
  }

