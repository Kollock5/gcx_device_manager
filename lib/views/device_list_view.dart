// views/device_list_screen.dart
import 'package:flutter/material.dart';
import 'package:gcx_device_manager/viewmodels/device_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widgets/device_liste_item.dart';

class DeviceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Devices List'),
      ),
      body: Consumer<DeviceListViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.devices != null) {
            print(viewModel.devices.toString());
            return SingleChildScrollView(
                child: Column(
              children: [
                ...viewModel.devices!.map((device) => DeviceListItem(
                    device: device,
                    onPressed: () {
                      viewModel.onDevicePressed(device);
                    }))
              ],
            ));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
