import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcx_device_manager/models/device.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';
import 'package:gcx_device_manager/screens/device_detail/device_detail_view_model.dart';
import 'package:provider/provider.dart';

import '../device_detail/device_detail_view.dart';

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

  void onDevicePressed(BuildContext context, Device device) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider<DeviceDetailViewModel>(
          create: (_) => DeviceDetailViewModel(_publisher, device.id),
          child: DeviceDetailScreen(deviceId: device.id),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _deviceStream.cancel();
    super.dispose();
  }

  List<Device>? get devices => _devices;
}
