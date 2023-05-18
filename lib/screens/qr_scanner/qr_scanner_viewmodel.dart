import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';

import '../../models/device.dart';

class QrScannerViewmodel extends ChangeNotifier {
  late final DeviceStreamPublisher _publisher;
  bool _isProcessingScan = false; // introduce a flag

  QrScannerViewmodel(this._publisher);

  void onBarCodeScanned(context, code) async {
    if (_isProcessingScan || RegExp(r'[.#$\[\]]').hasMatch(code)) {
      return;
    }

    _isProcessingScan = true;

    Device? scannedDevice = await _publisher.getDeviceOnce(code);
    if (scannedDevice != null) {
      await Navigator.pushNamed(
        context,
        '/deviceDetailScreen',
        arguments: scannedDevice.id,
      );
    }
    _isProcessingScan = false;
  }

  bool get isProcessingScan => _isProcessingScan;
}
