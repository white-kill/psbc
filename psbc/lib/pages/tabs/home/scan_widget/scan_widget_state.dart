
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
// import 'package:scan/scan.dart';

class Scan_widgetState {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  Scan_widgetState() {
    ///Initialize variables
  }
}
