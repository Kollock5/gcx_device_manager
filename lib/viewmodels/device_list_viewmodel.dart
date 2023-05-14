import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcx_device_manager/models/device.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';

class DeviceListViewModel extends ChangeNotifier {
  List<Device>? _devices;
  final DeviceStreamPublisher _publisher;

  late StreamSubscription<List<Device>> _deviceStream;

  DeviceListViewModel(this._publisher) {
    _listenToDevices();
  }

  void _listenToDevices() {
    _deviceStream = _publisher.getDeviceStream().listen((devices) {
      _devices = devices;
      notifyListeners();
    });
  }

  void onDevicePressed(Device device) {
    // Handle the device press event here
    print('Device pressed: ${device.name}');
  }

  @override
  void dispose() {
    _deviceStream.cancel();
    super.dispose();
  }

  List<Device>? get devices => _devices;
}
