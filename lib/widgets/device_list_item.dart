import 'package:flutter/material.dart';
import '../models/device.dart';

class DeviceListItem extends StatelessWidget {
  final Device device;
  final void Function(BuildContext, Device) onPressed;

  const DeviceListItem(
      {super.key, required this.device, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          onPressed(context, device);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                device.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Is at ${device.location}'),
            ]),
            const Spacer(),
            Column(
              children: [
                Icon(getTypeIcon(device.type)),
                Icon(getLocationIcon(device.isRented)),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  IconData getTypeIcon(String? type) {
    if (type == 'Android') {
      return Icons.android;
    } else if (type == 'iOS') {
      return Icons.apple;
    } else {
      return Icons.device_unknown;
    }
  }

  IconData getLocationIcon(bool? rented) {
    if (rented == null) {
      return Icons.question_mark;
    } else if (rented) {
      return Icons.hiking;
    } else {
      return Icons.home;
    }
  }
}
