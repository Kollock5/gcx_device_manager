import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gcx_device_manager/screens/add_device/add_device_viewmodel.dart';

class AddDeviceView extends StatefulWidget {
  @override
  _AddDeviceViewState createState() => _AddDeviceViewState();
}

class _AddDeviceViewState extends State<AddDeviceView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Device'),
      ),
      body: Consumer<AddDeviceViewmodel>(
        builder: (context, viewmodel, child) {
          if (viewmodel.device == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    initialValue: viewmodel.device?.id,
                    decoration: InputDecoration(
                        labelText: 'Device Id',
                        hintText: 'No Spaces and at least 8 characters'),
                    onChanged: (value) => viewmodel.setId(value),
                  ),
                  TextFormField(
                    initialValue: viewmodel.device?.name,
                    decoration: InputDecoration(labelText: 'Device Name'),
                    onChanged: (value) => viewmodel.setName(value),
                  ),
                  TextFormField(
                    initialValue: viewmodel.device?.homeLocation,
                    decoration: InputDecoration(labelText: 'Home Location'),
                    onChanged: (value) => viewmodel.setHomeLocation(value),
                  ),
                  Text('Model: ${viewmodel.device?.model ?? ''}'),
                  Text(
                      'System Version: ${viewmodel.device?.systemVersion ?? ''}'),
                  Text('Type: ${viewmodel.device?.type ?? ''}'),
                  // Add more fields here for the device
                  ElevatedButton(
                    child: Text('Save Device'),
                    onPressed: viewmodel.isAddDeviceButtonDisabled
                        ? null
                        : () => viewmodel.onAddDevicePressed(context),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
