import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/device.dart';
import 'device_detail_view_model.dart';

class DeviceDetailScreen extends StatelessWidget {
  final String deviceId;

  const DeviceDetailScreen({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<DeviceDetailViewModel>(context);
    Device? device = viewmodel.device;

    return Scaffold(
      appBar: AppBar(
        title: Text(device?.name ?? 'Device Detail'),
      ),
      body: device == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${device.id}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Name: ${device.name}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Model: ${device.model}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'System Version: ${device.systemVersion}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Type: ${device.type}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Location: ${device.location}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Home Location: ${device.homeLocation}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Is Rented: ${device.isRented}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    if (device.isRented == false)
                      OutlinedButton(
                        onPressed: () async {
                          if (viewmodel.hasDefaultName) {
                            viewmodel
                                .onRentDevicePressed(viewmodel.defaultName);
                          } else {
                            ScaffoldMessenger.of(context);
                            String? name = await _showNamePromptDialog(context);
                            viewmodel.onRentDevicePressed(name);
                          }
                        },
                        child: const Text("rent"),
                      )
                    else
                      OutlinedButton(
                          onPressed: () {
                            viewmodel.onReturnDevicePressed();
                          },
                          child: const Text("return")),
                  ],
                ),
              ),
            ),
    );
  }

  Future<String?> _showNamePromptDialog(BuildContext context) async {
    String? name;

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter your name'),
          content: TextField(
            onChanged: (value) {
              name = value;
            },
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, name);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
