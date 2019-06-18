###集成方式
# aj_flutter_scan

###集成方式
###一，For Android

    ## pubspec.yaml引用

    aj_flutter_scan:
       git:
          url: http://gitlab.anji-allways.com/mobileteam/modules.git
          path: aj_flutter_scan


    
 
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

