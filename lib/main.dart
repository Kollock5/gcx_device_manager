import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';
import 'package:gcx_device_manager/screens/device_detail/device_detail_view.dart';
import 'package:gcx_device_manager/screens/device_detail/device_detail_view_model.dart';
import 'package:gcx_device_manager/screens/device_list/device_list_viewmodel.dart';
import 'package:gcx_device_manager/screens/device_list/device_list_view.dart';
import 'package:gcx_device_manager/screens/add_device/add_device_view.dart';
import 'package:gcx_device_manager/screens/add_device/add_device_viewmodel.dart';
import 'package:gcx_device_manager/screens/qr_scanner/qr_scanner_view.dart';
import 'package:gcx_device_manager/screens/qr_scanner/qr_scanner_viewmodel.dart';
import 'package:gcx_device_manager/screens/settings/settings_view.dart';
import 'package:gcx_device_manager/screens/settings/settings_viewmodel.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GCX device manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/deviceListView': (context) =>
            ChangeNotifierProvider<DeviceListViewModel>(
              create: (_) => DeviceListViewModel(DeviceStreamPublisher()),
              child: const DeviceListView(),
            ),
        '/deviceDetailScreen': (context) {
          final String deviceId =
              ModalRoute.of(context)!.settings.arguments as String;
          return ChangeNotifierProvider<DeviceDetailViewModel>(
            create: (_) => DeviceDetailViewModel(
              DeviceStreamPublisher(),
              deviceId,
            ),
            child: DeviceDetailScreen(deviceId: deviceId),
          );
        },
        '/addDeviceView': (context) =>
            ChangeNotifierProvider<AddDeviceViewmodel>(
              create: (_) => AddDeviceViewmodel(DeviceStreamPublisher()),
              child: const AddDeviceView(),
            ),
        '/qrScannerView': (context) =>
            ChangeNotifierProvider<QrScannerViewmodel>(
              create: (_) => QrScannerViewmodel(),
              child: const QrScannerScreen(),
            ),
        '/settings': (context) => ChangeNotifierProvider<SettingsViewmodel>(
              create: (_) => SettingsViewmodel(DeviceStreamPublisher()),
              child: const SettingsScreen(),
            ),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("GCX device manager"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/deviceListView');
                  },
                  child: const Text("Go to Device List View")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addDeviceView');
                  },
                  child: const Text("Go to Add Device View")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/qrScannerView');
                  },
                  child: const Text("Go to Scanner")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: const Text("Settings")),
            ],
          ),
        ));
  }
}
