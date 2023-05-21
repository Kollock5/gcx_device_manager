import 'package:flutter/material.dart';
import 'package:gcx_device_manager/services/device_database_manager.dart';

import '../../models/device.dart';

class QrScannerViewmodel extends ChangeNotifier {
  late final DeviceDatabaseManager _publisher;
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
