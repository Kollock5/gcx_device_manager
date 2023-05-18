import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:gcx_device_manager/models/device.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDeviceViewmodel extends ChangeNotifier {
  final DeviceStreamPublisher _publisher;
  Device? _device;
  bool _isAddDeviceButtonDisabled = true;

  AddDeviceViewmodel(this._publisher) {
    _getDeviceInfo();
    fetchDevice();
  }

  Future<void> fetchDevice() async {
    _device = await _getDeviceInfo();
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
          id: "",
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
          id: "",
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
  bool get isAddDeviceButtonDisabled => _isAddDeviceButtonDisabled;

  setSavedId(String newId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedId', newId);
  }

  void onAddDevicePressed(BuildContext context) {
    if (_device != null) {
      _publisher.updateDevice(_device!);
      setSavedId(_device!.id);
      Navigator.pop(context);
    }
  }

  void setId(String? x) {
    if (x != null) {
      _device!.id = x;
      _isAddDeviceButtonDisabled = !(x.length >= 8 && !x.contains(' '));
      notifyListeners();
    }
  }

  void setHomeLocation(String? x) {
    if (x != null) {
      _device!.homeLocation = x;
    }
  }

  void setName(String? x) {
    if (x != null) {
      _device!.name = x;
    }
  }
}
