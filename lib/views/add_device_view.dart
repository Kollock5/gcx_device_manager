import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gcx_device_manager/viewmodels/add_device_viewmodel.dart';

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
        builder: (context, viewModel, child) {
          if (viewModel.device == null) {
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
                    initialValue: viewModel.device?.id,
                    decoration: InputDecoration(
                        labelText: 'Device Id',
                        hintText: 'No Spaces and at least 8 characters'),
                    onChanged: (value) => viewModel.setId(value),
                  ),
                  TextFormField(
                    initialValue: viewModel.device?.name,
                    decoration: InputDecoration(labelText: 'Device Name'),
                    onChanged: (value) => viewModel.setName(value),
                  ),
                  TextFormField(
                    initialValue: viewModel.device?.homeLocation,
                    decoration: InputDecoration(labelText: 'Home Location'),
                    onChanged: (value) => viewModel.setHomeLocation(value),
                  ),
                  Text('Model: ${viewModel.device?.model ?? ''}'),
                  Text(
                      'System Version: ${viewModel.device?.systemVersion ?? ''}'),
                  Text('Type: ${viewModel.device?.type ?? ''}'),
                  // Add more fields here for the device
                  ElevatedButton(
                    child: Text('Save Device'),
                    onPressed: viewModel.isAddDeviceButtonDisabled
                        ? null
                        : () => viewModel.onAddDevicePressed(context),
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
