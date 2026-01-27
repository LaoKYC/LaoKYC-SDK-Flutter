import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

Future<AndroidDeviceInfo> getAndroidDeviceInfo() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  return await deviceInfoPlugin.androidInfo;
}

Future<IosDeviceInfo> getIOSDeviceInfo() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  return await deviceInfoPlugin.iosInfo;
}

Future<String> getDeviceID() async {
  String deviceID = "";

  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      var androidInfo = await getAndroidDeviceInfo();
      deviceID = androidInfo.id;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      var iOSInfo = await getIOSDeviceInfo();
      deviceID = iOSInfo.identifierForVendor ?? "none_device_id";
    }
  } catch (e) {}

  return deviceID;
}
