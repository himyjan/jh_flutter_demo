///  qr_code_scanner_page.dart
///
///  Created by iotjin on 2022/06/05.
///  description:  二维码扫码页

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '/project/routes/jh_nav_utils.dart';
import '/base_appbar.dart';

class QrCodeScannerPage extends StatefulWidget {
  const QrCodeScannerPage({Key? key}) : super(key: key);

  @override
  _QrCodeScannerPageState createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  /// In order to get hot reload to work we need to pause the camera if the platform
  /// is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
      controller?.resumeCamera();
    } else if (Platform.isIOS) {
      controller?.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderLength: 20,
                borderWidth: 5,
                cutOutSize: scanArea,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.highlight_outlined,
                  size: 32,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller?.toggleFlash();
                },
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: backAppBar(context, ""),
//            MyAppBar(
//              backgroundColor: Colors.transparent,
//              backImgColor: Colors.white,
//            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      /// 避免扫描结果多次回调
      controller.dispose();
      JhNavUtils.goBackWithParams(context, scanData.code ?? '');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}