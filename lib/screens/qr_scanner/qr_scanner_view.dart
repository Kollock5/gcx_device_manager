// import 'package:flutter/material.dart';
// import 'package:gcx_device_manager/screens/qr_scanner/qr_scanner_viewmodel.dart';
// import 'package:provider/provider.dart';
// import 'package:scan/scan.dart';

// import '../../models/device.dart';

// class QrScannerScreen extends StatelessWidget {
//   // const QrScannerScreen({super.key});

//   ScanController controller = ScanController();
//   String qrcode = 'Unknown';

//   @override
//   Widget build(BuildContext context) {
//     final viewmodel = Provider.of<QrScannerViewmodel>(context);

//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         width: 250, // custom wrap size
//         height: 250,
//         child: ScanView(
//           controller: controller,
// // custom scan area, if set to 1.0, will scan full area
//           scanAreaScale: .7,
//           onCapture: (data) {
//             print("do w");
//             print(qrcode);
//             print(data.toString());
//           },
//         ),
//       ),
//     );
//   }
// }
