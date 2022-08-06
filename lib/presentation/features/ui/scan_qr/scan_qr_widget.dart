
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../base/base_stateful_widget.dart';

class ScanQRWidget extends BaseStatefulWidget {
  const ScanQRWidget({Key? key}) : super(key: key);

  @override
  ScanQRWidgetState createState() => ScanQRWidgetState();
}

class ScanQRWidgetState extends State<ScanQRWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final scaffoldKey = GlobalKey<ScaffoldState>();
  QRViewController controller;
  var isSnackBarShowing = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderWidth: 10,
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      final isUrlLaunch = await launchUrl(scanData.code);
      if (!isUrlLaunch && !isSnackBarShowing) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'QR is not a Url',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        )).closed.then((_) {
          isSnackBarShowing = false;
        });
        isSnackBarShowing = true;
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
