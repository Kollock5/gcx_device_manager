// views/device_list_screen.dart
import 'package:flutter/material.dart';
import 'package:gcx_device_manager/screens/device_list/device_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../widgets/device_list_item.dart';

class DeviceListView extends StatelessWidget {
  const DeviceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices List'),
      ),
      body: Consumer<DeviceListViewModel>(
        builder: (context, viewmodel, child) {
          if (viewmodel.devices != null) {
            return SingleChildScrollView(
                child: Column(
              children: [
                ...viewmodel.devices!.map((device) => DeviceListItem(
                    device: device, onPressed: viewmodel.onDevicePressed))
              ],
            ));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
