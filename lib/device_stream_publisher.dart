// device_stream_publisher.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:gcx_device_manager/models/device.dart';

class DeviceStreamPublisher {
  final _database = FirebaseDatabase.instance.ref();

  Stream<List<Device>> getDeviceStream() {
    final devicesStream = _database.child('devices').onValue;
    final results = devicesStream.map((event) {
      final deviceMap = Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      final deviceList = deviceMap.entries.map((element) {
        return Device.fromJson(Map<String, dynamic>.from(element.value));
      }).toList();
      return deviceList;
    });
    return results;
  }

  Stream<Device> getDevice(String id) {
    final deviceStream = _database.child('devices/$id').onValue;
    final result = deviceStream.map((event) {
      final deviceData = Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      final device = Device.fromJson(deviceData);
      return device;
    });
    return result;
  }
}
