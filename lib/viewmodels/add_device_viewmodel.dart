import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:gcx_device_manager/models/device.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';

class AddDeviceViewmodel extends ChangeNotifier {
  final DeviceStreamPublisher _publisher;
  Device? _device;

  AddDeviceViewmodel(this._publisher) {
    _getDeviceInfo();
    fetchDevice();
  }

  Future<void> fetchDevice() async {
    _device = await _getDeviceInfo();
    print(_device.toString());
    notifyListeners();
  }

  Future<Device?> _getDeviceInfo() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      return Device(
          id: "Add Id",
          name: "$manufacturer, $model",
          model: model,
          systemVersion: "Android $release (SDK $sdkInt)",
          type: "Android",
          location: "Device storage cologne",
          homeLocation: "Device storage cologne",
          isRented: false);
    } else if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      return Device(
          id: "Add Id",
          name: name,
          model: name,
          systemVersion: "$systemName $version",
          type: "iOS",
          location: "Device storage cologne",
          homeLocation: "Device storage cologne",
          isRented: false);
    } else {
      return null;
    }
  }

  void addDeviceToServer() {}

  Device? get device => _device;
}
