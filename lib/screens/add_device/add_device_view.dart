import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gcx_device_manager/screens/add_device/add_device_viewmodel.dart';

class AddDeviceView extends StatefulWidget {
  const AddDeviceView({super.key});

  @override
  AddDeviceViewState createState() => AddDeviceViewState();
}

class AddDeviceViewState extends State<AddDeviceView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Consumer<AddDeviceViewmodel>(
        builder: (context, viewmodel, child) {
          if (viewmodel.device == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    initialValue: viewmodel.device?.id,
                    decoration: const InputDecoration(labelText: 'Device Id'),
                    onChanged: (value) {
                      if (_formKey.currentState!.validate()) {}
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.contains(RegExp(r'[.#$\[\]]'))) {
                        return 'Do not use . # \$ [ or ]';
                      } else {
                        viewmodel.setId(value);
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: viewmodel.device?.name,
                    decoration: const InputDecoration(labelText: 'Device Name'),
                    onChanged: (value) => viewmodel.setName(value),
                  ),
                  TextFormField(
                    initialValue: viewmodel.device?.homeLocation,
                    decoration:
                        const InputDecoration(labelText: 'Home Location'),
                    onChanged: (value) => viewmodel.setHomeLocation(value),
                  ),
                  Text('Model: ${viewmodel.device?.model ?? ''}'),
                  Text(
                      'System Version: ${viewmodel.device?.systemVersion ?? ''}'),
                  Text('Type: ${viewmodel.device?.type ?? ''}'),
                  ElevatedButton(
                    onPressed: viewmodel.isAddDeviceButtonDisabled
                        ? null
                        : () => viewmodel.onAddDevicePressed(context),
                    child: const Text('Save Device'),
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
