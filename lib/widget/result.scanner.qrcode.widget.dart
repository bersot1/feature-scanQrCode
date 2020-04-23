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
