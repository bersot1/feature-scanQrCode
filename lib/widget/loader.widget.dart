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
