# Anji-plus Flutter Plugins

A new Flutter plugin.

## Getting Started
flutter与原生交互，包含静态资源获取，版本获取。

**FlutterFire Plugins** 
```
- 使用方式
xxx:
git:
url: http://gitlab.anji-allways.com/mobileteam/modules.git
path: xxx
```

1、 [aj_flutter_plugin](./aj_flutter_plugin/) 

2、[aj_flutter_update](./aj_flutter_update/) 

  ```
  - iOS需要添加如下内容
  Deployment Target 设置为 10.0
  Podfile 中 target 'Runner' do 添加 use_frameworks! 支持swift
  
  - Android需要添加如下内容
  
  
 ```
3、 [aj_flutter_auto_orientation](./aj_flutter_auto_orientation/) 

4、[aj_flutter_scan](./aj_flutter_scan/) 
```
    **aj_flutter_scan**
    - iOS需要添加如下内容
    <key>NSCameraUsageDescription</key>
    <string>允许应用在扫码功能中使用您的摄像头</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>需要访问你的相册</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>需要访问你的麦克风</string>
```
  

 
 


