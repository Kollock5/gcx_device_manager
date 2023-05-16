import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcx_device_manager/models/device.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';

class QrScannerViewmodel extends ChangeNotifier {
  // final String deviceId;
  // final DeviceStreamPublisher _publisher;
  late StreamSubscription<Device?> _deviceStream;

  // DeviceDetailViewModel(this._publisher, this.deviceId) {
  // }

  void onRentDevicePressed(name) {}
}
