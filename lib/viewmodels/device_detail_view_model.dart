import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcx_device_manager/models/device.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';

class DeviceDetailViewModel extends ChangeNotifier {
  final String deviceId;
  final DeviceStreamPublisher _publisher;
  Device? _device;
  late StreamSubscription<Device?> _deviceStream;

  DeviceDetailViewModel(this._publisher, this.deviceId) {
    _listenToDevice();
  }

  void _listenToDevice() {
    _deviceStream = _publisher.getDevice(deviceId).listen((device) {
      _device = device;
      notifyListeners();
    });
  }

  void onRentDevicePressed(name) {
    if (name != null) {
      Device myDevice = _device!;
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
    _deviceStream.cancel();
    super.dispose();
  }

  Device? get device => _device;
}
