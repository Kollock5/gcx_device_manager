import 'package:flutter/material.dart';
import 'package:gcx_device_manager/screens/qr_scanner/qr_scanner_viewmodel.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  // const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<QrScannerViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ID Scanner'),
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.back,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            viewmodel.onBarCodeScanned(context, barcode.rawValue);
            if (viewmodel.isProcessingScan == false) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Barcode detected: ${barcode.rawValue}'),
                  ),
                );
            }
          }
        },
      ),
    );
  }
}
