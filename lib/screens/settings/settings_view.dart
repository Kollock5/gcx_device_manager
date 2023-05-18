import 'package:flutter/material.dart';
import 'package:gcx_device_manager/screens/settings/settings_viewmodel.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<SettingsViewmodel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: SingleChildScrollView(
          child: viewmodel.settingsReady
              ? SettingLoaded(formKey: _formKey, viewmodel: viewmodel)
              : const CircularProgressIndicator(),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class SettingLoaded extends StatelessWidget {
  const SettingLoaded({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.viewmodel,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final SettingsViewmodel viewmodel;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        LocalSettings(viewmodel: viewmodel, formKey: _formKey),
        viewmodel.device != null
            ? DeviceSettings(viewmodel: viewmodel, formKey: _formKey)
            : ElevatedButton(
                onPressed: () => viewmodel.onAddDevicePressed(context),
                child: const Text('Add this Device'),
              ),
      ]),
    );
  }
}

class LocalSettings extends StatelessWidget {
  const LocalSettings({
    super.key,
    required this.viewmodel,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final SettingsViewmodel viewmodel;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('Local settings:'),
      TextFormField(
        initialValue: viewmodel.defaultName,
        decoration: const InputDecoration(labelText: 'Default rental name'),
        onChanged: (value) => viewmodel.onDefaultNameChanged(value),
      ),
      TextFormField(
        initialValue: viewmodel.savedId,
        decoration: const InputDecoration(labelText: 'Device Id'),
        onChanged: (value) {
          if (_formKey.currentState!.validate()) {}
        },
        validator: (value) {
          if (value != null && value.contains(RegExp(r'[.#$\[\]]'))) {
            return 'Do not use . # \$ [ or ]';
          } else {
            viewmodel.onSavedIdChanged(value);
          }
          return null;
        },
      ),
    ]);
  }
}

class DeviceSettings extends StatelessWidget {
  const DeviceSettings({
    super.key,
    required this.viewmodel,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final SettingsViewmodel viewmodel;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('Local settings:'),
      TextFormField(
        initialValue: viewmodel.device?.id,
        decoration: const InputDecoration(labelText: 'Device Id'),
        onChanged: (value) {
          _formKey.currentState!.validate();
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          } else if (value.contains(RegExp(r'[.#$\[\]]'))) {
            return 'Do not use . # \$ [ or ]';
          } else {
            viewmodel.setUpdatedId(value);
          }
          return null;
        },
      ),
      TextFormField(
        initialValue: viewmodel.device?.name,
        decoration: const InputDecoration(labelText: 'Device Name'),
        onChanged: (value) => viewmodel.setUpdatedName(value),
      ),
      TextFormField(
        initialValue: viewmodel.device?.homeLocation,
        decoration: const InputDecoration(labelText: 'Home Location'),
        onChanged: (value) => viewmodel.setUpdatedHomeLocation(value),
      ),
      ElevatedButton(
        onPressed: viewmodel.isSaveUpdateButtonDisabled
            ? null
            : () => viewmodel.onSaveUpdatePressed(context),
        child: const Text('Save Device'),
      ),
    ]);
  }
}
