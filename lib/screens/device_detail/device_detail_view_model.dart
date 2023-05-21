import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcx_device_manager/models/device.dart';
import 'package:gcx_device_manager/services/device_database_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:provider/provider.dart';

class DeviceDetailViewModel extends ChangeNotifier {
  String? deviceId;
  final DeviceDatabaseManager _publisher;
  Device? _device;
  StreamSubscription<Device?>? _deviceStream;
  bool hasDefaultName = false;
  late String? _defaultName;

  DeviceDetailViewModel(this._publisher, this.deviceId) {
    if (deviceId == null) {
      _getIdFromLocalData();
    } else {
      _listenToDevice();
    }
    _getDefaultName();
  }

  Future<void> _getDefaultName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _defaultName = prefs.getString('defaultName');
    if (_defaultName != null) {
      hasDefaultName = true;
    }
    notifyListeners();
  }

  Future<void> _getIdFromLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    deviceId = prefs.getString('savedId');
    if (deviceId != null && deviceId != '') {
      _listenToDevice();
    }
  }

  void _listenToDevice() {
    if (deviceId != null) {
      _deviceStream = _publisher.getDevice(deviceId!).listen((device) {
        _device = device;
        notifyListeners();
      });
    }
  }

  void onRentDevicePressed(name) {
    if (name != null) {
      Device myDevice = _device!.copy();
      myDevice.isRented = true;
      myDevice.location = name;
      _publisher.updateDevice(myDevice);
    }
  }

  void onReturnDevicePressed() {
    Device myDevice = _device!;
    myDevice.isRented = false;
    myDevice.location = myDevice.homeLocation;
    _publisher.updateDevice(myDevice);
  }

  @override
  void dispose() {
    if (_deviceStream != null) {
      _deviceStream!.cancel();
    }
    super.dispose();
  }

  Device? get device => _device;
  String? get defaultName => _defaultName;
}
