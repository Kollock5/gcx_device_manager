// device_stream_publisher.dart

import 'package:firebase_database/firebase_database.dart';
import 'package:gcx_device_manager/models/device.dart';

class DeviceStreamPublisher {
  final _database = FirebaseDatabase.instance.ref();

  Stream<List<Device>> getDeviceStream() {
    print('alarm');
    final deviceStream = _database.child('devices').onValue;
    final results = deviceStream.map((event) {
      final deviceMap = Map<String, dynamic>.from(
          event.snapshot.value as Map<dynamic, dynamic>);
      final deviceList = deviceMap.entries.map((element) {
        return Device.fromJson(Map<String, dynamic>.from(element.value));
      }).toList();
      return deviceList;
    });
    return results;
  }
}
