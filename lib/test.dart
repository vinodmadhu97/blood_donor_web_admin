import 'dart:convert';
import 'dart:typed_data';

import 'package:blood_donor_web_admin/size-config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:html' as html;


class QRgeneratorPage extends StatefulWidget {

  final String text;

  QRgeneratorPage(this.text);

  @override
  _QRgeneratorPageState createState() => _QRgeneratorPageState(this.text);
}

class _QRgeneratorPageState extends State<QRgeneratorPage> {
  final String data;

  _QRgeneratorPageState(this.data);

  var tableTextController = TextEditingController();
  //List<bool> _selections = List.generate(4, (_) => false);
  GlobalKey globalKey = new GlobalKey();
  QrPainter? _painter;

  Color textColor = Colors.black;

  int size = 5;

  @override
  void initState() {
    super.initState();
    //_selections[2] = true;
  }

  @override
  Widget build(BuildContext context) {
    _painter = QrPainter(
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Color(0xff128760),
      ),
      data: json.encode(data),
      version: QrVersions.auto,
    );

    SizeConfig().init(context);

    return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: Center(
                  child: RepaintBoundary(
                    child: CustomPaint(
                        size: Size.square((size * 100).toDouble()),
                        key: globalKey,
                        painter: _painter),
                  ),
                ),
              ),

              /*_buildTextField(
                tableTextController,
                "Enter text here...",
              ),*/


              SizedBox(
                height: 10,
              ),

              _buildButton(),
            ],
          ),
        ),
      );
  }



  Widget _buildButton() {
    return ElevatedButton(
        onPressed: () async {
          await _capturePng();
        },
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
        child: Text('Download'));
  }

  Future<void> _capturePng() async {
    final picData = await _painter?.toImageData((size * 100).toDouble(),
        format: ImageByteFormat.png);
    await writeToFile(picData!);
  }

  Future<void> writeToFile(ByteData data) async {
    final bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'qr_code.png';
    html.document.body?.children.add(anchor);

    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  /*Widget _buildTextField(
      TextEditingController textController, String hintText) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
            width: SizeConfig.screenHeight! * 0.4,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  data = value;
                });
              },
              textAlign: TextAlign.center,
              controller: textController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: TextStyle(fontSize: 18, color: Colors.black26)),
            )));
  }*/
}