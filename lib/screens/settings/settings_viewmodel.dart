import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/device_database_manager.dart';
import '../../models/device.dart';

class SettingsViewmodel extends ChangeNotifier {
  late final DeviceDatabaseManager _publisher;
  Device? _device;
  Device? _updatedDevice;

  StreamSubscription<Device?>? _deviceStream;
  String? _savedId;
  String? _defaultName;
  bool _settingsReady = false;
  bool _isSaveUpdateButtonDisabled = true;

  SettingsViewmodel(this._publisher) {
    readData();
  }

  void _listenToDevice() {
    if (_deviceStream != null) {
      _deviceStream!.cancel();
    }
    if (_savedId != null) {
      _deviceStream = _publisher.getDevice(_savedId!).listen((device) {
        _device = device;
        _updatedDevice ??= device?.copy();
        notifyListeners();
      });
    }
  }

  readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedId = prefs.getString('savedId');
    _defaultName = prefs.getString('defaultName');
    if (_savedId != null && _savedId != '') {
      _listenToDevice();
    }
    _settingsReady = true;
    notifyListeners();
  }

  setSavedId(String newId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedId', newId);
    readData();
    notifyListeners();
  }

  setDefaultName(String newName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('defaultName', newName);
    readData();
    notifyListeners();
  }

  @override
  void dispose() {
    if (_deviceStream != null) {
      _deviceStream!.cancel();
    }
    super.dispose();
  }

  void onSavedIdChanged(id) {
    if (id != null) {
      setSavedId(id);
    }
  }

  void onDefaultNameChanged(name) {
    if (name != null) {
      setDefaultName(name);
    }
  }

  void onSaveUpdatePressed(BuildContext context) {
    if (_updatedDevice != null) {
      if (_device?.id != _updatedDevice?.id) {
        _publisher.deleteDevice(_device!);
        onSavedIdChanged(_updatedDevice?.id);
      }
      _publisher.updateDevice(_updatedDevice!);
      Navigator.pop(context);
    }
  }

  void checkIfChanged() {
    _isSaveUpdateButtonDisabled = _device == _updatedDevice;
  }

  void setUpdatedId(String? x) {
    if (x != null) {
      _updatedDevice!.id = x;
      notifyListeners();
      checkIfChanged();
    }
  }

  void setUpdatedName(String? x) {
    if (x != null) {
      _updatedDevice!.name = x;
      notifyListeners();
      checkIfChanged();
    }
  }

  void setUpdatedHomeLocation(String? x) {
    if (x != null) {
      _updatedDevice!.homeLocation = x;
      notifyListeners();
      checkIfChanged();
    }
  }

  void onAddDevicePressed(context) {
    Navigator.pushNamed(
      context,
      '/addDeviceView',
    );
  }

  Device? get device => _device;
  String? get defaultName => _defaultName;
  String? get savedId => _savedId;
  bool get isSaveUpdateButtonDisabled => _isSaveUpdateButtonDisabled;
  bool get settingsReady => _settingsReady;
}
