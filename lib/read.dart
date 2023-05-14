import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';
import 'package:gcx_device_manager/models/device.dart';

class ReadExample extends StatefulWidget {
  const ReadExample({super.key});

  @override
  State<ReadExample> createState() => _ReadExampleState();
}

class _ReadExampleState extends State<ReadExample> {
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Read Example'),
        ),
        body: Column(children: [
          Text("test"),
          StreamBuilder(
              stream: DeviceStreamPublisher().getDeviceStream(),
              builder: (context, snapshot) {
                print('bin drin');
                final dList = <ListTile>[];
                if (snapshot.hasData) {
                  final myDevies = snapshot.data as List<Device>;
                  dList.addAll(myDevies.map((nextDevice) {
                    return ListTile(
                      leading: Icon(Icons.local_cafe_outlined),
                      title: Text(nextDevice.name),
                    );
                  }));
                }
                return Column(
                  children: dList,
                );
              })
        ]));
  }
}
