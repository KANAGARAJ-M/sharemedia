import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';



class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final TextEditingController _textController = TextEditingController();
  String? _qrCodeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),

        
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Enter text to generate QR code',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _qrCodeData = _textController.text;
                });
              },
              child: Text('Generate QR Code'),
            ),
            SizedBox(height: 32.0),
            if (_qrCodeData != null)
              QrImage(
                data: _qrCodeData!,
                version: QrVersions.auto,
                size: 200.0,
              ),
          ],
        ),
      ),
    );
  }
}
