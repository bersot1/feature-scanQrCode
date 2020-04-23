import 'package:featurereadqrcode/widget/loader.widget.dart';
import 'package:featurereadqrcode/widget/result.scanner.qrcode.widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerPage extends StatefulWidget {
  @override
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  bool isScanner = false;

  QRViewController qrController;
  GlobalKey qrKey = GlobalKey();

  var qrText = "";
  String loaderMessage = "Leia um QrCode";

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        isScanner = true;
      });
    });
  }

  _restart() {
    setState(() {
      isScanner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 400,
            child: isScanner == false
                ? LoaderQrCode(
                    loaderMessage: loaderMessage,
                  )
                : ResultScannerQrCode(
                    resultaQrCodeScanner: qrText,
                    func: _restart,
                  ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 2,
                  color: Colors.orange,
                ),
              ),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreate,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
