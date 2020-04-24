# Scan QRCode

Here you will see an easy way how implements Read QRcode in your project.

I used it in my own project and when I implemented I found some plugins that won't be worked very well, so, when I finally found the good plugin I decided to documentation to help other people.

I'm not a designer, my intention here is to introduce to you how you can use this technology and to improve your skills and your project.


![final project](https://github.com/bersot1/feature-scanQrCode/blob/master/qrcodescanner.jpeg)

# implementation

#### 1 - setup your pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  qr_code_scanner: 0.0.12 # <---
```

#### 2 - setup your AndroidManifest.xml
path: android\app\src\main

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.example.featurereadqrcode">
  
<uses-permission android:name="android.permission.CAMERA" />
 .
 .
 .
```

#### 3 - Lets Code
After we set up our project, now we can go to code.

I like to start organizing my files and folder, I really like to separate in two main folders:

* pages - that will return Scaffold();
* widget - that will return anything (Container, Column, etc.);

With it, we have this simple structure:

![struct](https://github.com/bersot1/feature-scanQrCode/blob/master/folderstruct.png)


#### 3.1 - main.dart

Let's start to clean all comments that are default in Flutter at this page.

So, we have this code in dart.main:

```dart
import 'package:featurereadqrcode/pages/qrcodescanner.page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: QRCodeScannerPage(),
    );
  }
}
```
Line 11: It is to remove the weird debugger banner right side in your android emulate.

Line 15: We start our application calling this widget that we created inside the page folder.

#### 3.2 - QRCodeScannerPage()

```dart
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
```
On this page, we have the main methods to scan works and we called our widgets that we used at this page.

Attention in line 73 where out widget QRView where our camera will appear. You can put this widget where you want... This widget waits a method that we called "_onQRViewCreate, that will read QRCode and put the result in our var "qrText", that in turn, we pass her to our widget ResultScannerQrCode.

#### 3.3 - widget LoaderQrCode()
```dart
import 'package:flutter/material.dart';

class LoaderQrCode extends StatelessWidget {
  String loaderMessage;

  LoaderQrCode({
    @required this.loaderMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
            ),
            Text(
              loaderMessage,
              style: TextStyle(
                color: Colors.orange,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
#### 3.4 - widget ResultScannerQrCode

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScannerQrCode extends StatelessWidget {
  String resultaQrCodeScanner;
  Function func;

  ResultScannerQrCode({
    @required this.resultaQrCodeScanner,
    @required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 80,
              ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        blurRadius: 7.0,
                        offset: Offset(0, 3))
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://robohash.org/temporedignissimosharum.png?size=150x150&set=set1"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          resultaQrCodeScanner,
          style: TextStyle(
            color: Colors.orange,
            fontSize: 50,
          ),
        ),
        Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.deepOrange),
          child: FlatButton(
            child: Text(
              "Reiniciar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: func,
          ),
        )
      ],
    );
  }
}
```
Here is our main widget where will show what the scan reader. I used a cool random avatar picture just an example, but our really right result of QRcode will appear in var 'resultaQrCodeScanner';
