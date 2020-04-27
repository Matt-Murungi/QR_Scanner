import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code/customs/qrscan.dart';


class QRScanScreen extends StatefulWidget {
  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  String result = "Please Scan below";
  QrScan qrScan = new QrScan();
  
  Future _scanQR() async {
    try {
      var qrResult = await qrScan.scanQR();
      setState(() {
        result = qrResult.toString();
      });
    } on PlatformException catch (e) {
      if (e.code == qrScan.cameraAccessDeniedError) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $e";
        });
      }
    } on FormatException {
      setState(() {
        result = "You did not scan";
      });
    } catch (e) {
      setState(() {
        result = "error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(child: Text(result)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
         hoverColor: Colors.white,
        onPressed: _scanQR,
        label: Text("Scan"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
