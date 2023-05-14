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

  @override
  void dispose() {
    _deviceStream.cancel();
    super.dispose();
  }

  Device? get device => _device;
}
