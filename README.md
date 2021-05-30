# DartAdvanced
I'm using [vs code](https://code.visualstudio.com/) and [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) extentsion
## Create a flutter project, we will use flutter packages
### everyThing will be inside lib directory for simplicity. For more check [.gitignore](https://github.com/yeasin50/Dart_Advanced/blob/master/.gitignore) 
</br>
comment widget_test.dart(inside test folder)  line:16 for textCode.

```
await tester.pumpWidget(MyApp()); 
```

### RiverPod `flutter_riverpod: ^0.14.0+3`
- [StateNotifierProvider](https://github.com/yeasin50/Dart_-Flutter_Advanced/blob/master/lib/riverPod/stateNotifierProvider.dart)



but to Test packages run in flutter way(like app build and run). 

### ⚠ Follow the pubspec.yaml for packages 
------
## While working with manifest, uninstall the app and rebuild again. 
-----
## Permission Handler 
add on AndroidManifest.xml file also check out for info.plist  
```
  <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-feature android:name="android.hardware.camera" />
    <uses-feature android:name="android.hardware.camera.autofocus" />
```

## For Contact Services
```
<uses-permission android:name="android.permission.READ_CONTACTS" />  
<uses-permission android:name="android.permission.WRITE_CONTACTS" />  
```
-  info.plist 
  ```
  <key>NSContactsUsageDescription</key>  
  <string>This app requires contacts access to function properly.</string>  
  ```
[Visit package Doc](https://pub.dev/packages/contacts_service)

----

## Rive 

[Animation controler](https://blog.rive.app/rives-flutter-runtime-part-1/)


## Assets Audio player
[playing sound from assets](https://pub.dev/packages/assets_audio_player)
## Getting Started

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
