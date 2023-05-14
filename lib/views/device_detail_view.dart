import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/device.dart';
import '../viewmodels/device_detail_view_model.dart';

class DeviceDetailScreen extends StatelessWidget {
  final String deviceId;

  DeviceDetailScreen({required this.deviceId});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DeviceDetailViewModel>(context);
    Device? device = viewModel.device;

    return Scaffold(
      appBar: AppBar(
        title: Text(device?.name ?? 'Device Detail'),
      ),
      body: device == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${device.id}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Name: ${device.name}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Model: ${device.model}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'System Version: ${device.systemVersion}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Type: ${device.type}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Location: ${device.location}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Home Location: ${device.homeLocation}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Is Rented: ${device.isRented}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
