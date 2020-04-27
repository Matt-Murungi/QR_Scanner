import 'package:barcode_scan/platform_wrapper.dart';

class QrScan {
  QrScan();

  var cameraAccessDeniedError = BarcodeScanner.cameraAccessDenied;

  Future scanQR() async {
    var qrResult = await BarcodeScanner.scan();

    return qrResult;
  }
}
