import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_permissions/simple_permissions.dart';

import 'AppUtils.dart';
import 'Commons.dart';
import 'DialogUtils.dart';
import 'VersionUpdateDialog.dart';

mixin AjFlutterUpdateMixin<T extends StatefulWidget> on State<T> {
  static const apkInstallChannel =
      const MethodChannel(Commons.apkinstallChannel);

  static const String apkInstallMethod = Commons.apkInstallMethod;

  //先接口请求，versionName（code）比对后再调用，这个请求+比对放在本地即可
  static versionUpdate(BuildContext context, String downloadUrl,
      String releaseLog, bool mustUpdate) async {
    if (Platform.isIOS) {
      showUpdateDialog(context, downloadUrl, releaseLog, mustUpdate);
      return;
    }
    PermissionStatus status = await SimplePermissions.requestPermission(
        Permission.WriteExternalStorage);

    if (status == PermissionStatus.authorized) {
      showUpdateDialog(context, downloadUrl, releaseLog, mustUpdate);
    } else {
      DialogUtils.showCommonDialog(context,
          msg: '"获取文件读写权限失败,即将跳转应用信息”>“权限”中开启权限"',
          negativeMsg: '取消',
          positiveMsg: '前往', onDone: () {
        SimplePermissions.openSettings().then((openSuccess) {
          if (openSuccess != true) {}
        });
      });
    }
  }

  static showUpdateDialog(BuildContext context, String downloadUrl,
      String releaseLog, bool mustUpdate) {
    showDialog(
        context: context,
        builder: (context) {
          VersionUpdateDialog messageDialog = new VersionUpdateDialog(
            positiveText: "更新",
            versionMsgList: AppUtils.getMsgList(releaseLog),
            mustUpdate: mustUpdate,
            downloadUrl: downloadUrl,
            minHeight: 160,
          );
          return messageDialog;
        });
  }
}
