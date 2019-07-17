###集成方式
# aj_flutter_scan

###集成方式
###一，For Android
```
    <!--请求访问使用照相设备-->
    <uses-permission android:name="android.permission.CAMERA" />
    ## pubspec.yaml引用

    aj_flutter_scan:
       git:
          url: https://github.com/Keanyuan/flutter_plugins.git
          path: aj_flutter_scan

```
    
 
###二，iOS
```
Deployment Target 设置为 10.0
Podfile 中 target 'Runner' do 添加 use_frameworks! 支持swift
-- iOS需要添加如下内容
  <key>NSCameraUsageDescription</key>
  <string>允许应用在扫码功能中使用您的摄像头</string>
  <key>NSPhotoLibraryUsageDescription</key>
  <string>需要访问你的相册</string>
  <key>NSMicrophoneUsageDescription</key>
  <string>需要访问你的麦克风</string>
```

###三，dart层调用
      （1）引用
``` 
      import 'package:permission_handler/permission_handler.dart';//permission request
	  import 'package:aj_flutter_scan/aj_flutter_scan.dart';
``` 
     (2)使用	
```     
  //扫一扫
  _onScanRequest() async {
    //permission_handler: ^3.1.0 iOS、Android通用
    //权限先校验
    final List<PermissionGroup> permissions = <PermissionGroup>[PermissionGroup.camera];
    final Map<PermissionGroup, PermissionStatus> permissionRequestResult =
    await PermissionHandler().requestPermissions(permissions);
    PermissionStatus status =  permissionRequestResult[PermissionGroup.camera];
    if (status == PermissionStatus.granted) {
      String barcode = "";
      try {
      //成功回调
      barCode = await AjFlutterScan.getBarCode;
      Toast.toast(context, barcode);
      } catch (e) {
      //成功失败
      if (e.code == AjFlutterScan.ScanCancle) {
      print("Unknown error: 取消扫描 ${e.code}");
      } else {
      print("Unknown error: $e");
      }
      }
    } else {
      String positiveMsg = Platform.isIOS ? "确定" : "前往";
      String msg = Platform.isIOS
          ? "扫描失败,请在iOS\"设置\"-\"隐私\"-\"相机\"中开启权限"
          : '"相机权限获取失败,是否跳转“应用信息”>“权限”中开启相机权限？"';
      AppUtils.showCommonDialog(context,
          msg: msg, negativeMsg: '取消', positiveMsg: positiveMsg, onDone: () {
          PermissionHandler().openAppSettings().then((openSuccess) {
            if (openSuccess != true) {}
          });
      });
    }
  }
```
