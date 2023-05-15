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
                    initialValue: viewModel.device?.name,
                    decoration: InputDecoration(labelText: 'Device Name'),
                    onSaved: (value) {
                      // Save this to the device model
                      viewModel.device?.name = value ?? '';
                    },
                  ),
                  // Add more fields here for the device
                  ElevatedButton(
                    child: Text('Save Device'),
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState?.save();
                        // Here you can call viewModel.addDeviceToServer()
                        // Or any other action after saving the form
                      }
                    },
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
