import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gcx_device_manager/device_stream_publisher.dart';
import 'package:gcx_device_manager/viewmodels/device_list_viewmodel.dart';
import 'package:gcx_device_manager/views/device_list_view.dart';
import 'package:gcx_device_manager/views/add_device_view.dart';
import 'package:gcx_device_manager/viewmodels/add_device_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangeNotifierProvider<DeviceListViewModel>(
                                  create: (_) => DeviceListViewModel(
                                      DeviceStreamPublisher()),
                                  child: DeviceListView(),
                                )));
                  },
                  child: Text("Go to Device List View")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChangeNotifierProvider<AddDeviceViewmodel>(
                                  create: (_) => AddDeviceViewmodel(
                                      DeviceStreamPublisher()),
                                  child: AddDeviceView(),
                                )));
                  },
                  child: Text("Go to Add Device View")),
            ],
          ),
        ));
  }
}
