import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

import '../../service/mock/mock.dart';
import '../../model/book.dart';
import '../utils/warning.dart';
import '../utils/loading.dart';
import '../utils/scaffold.dart';
import '../utils.dart';

///
/// Scanner Page
///
class ScannerPage extends StatefulWidget {
  @override
  ScannerPageState createState() => ScannerPageState();
}

class ScannerPageState extends State<ScannerPage> {
  int _cameraBarcode = FlutterMobileVision.CAMERA_BACK;
  Size _previewBarcode;
  List<Barcode> _barcodes = [];

  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((previewSizes) => setState(() {
          _previewBarcode = previewSizes[_cameraBarcode].first;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return this._getButton();
  }

  Widget _getButton() {
    return Center(
        child: new RaisedButton(
      onPressed: _scan,
      child: new Text('SCAN!', style: MYSTYLEBIGBOLDWHITE),
      color: myColorGreen,
    ));
  }

  // Barcode Method
  Future<Null> _scan() async {
    _barcodes.clear();

    List<Barcode> barcodes = [];
    try {
      barcodes = await FlutterMobileVision.scan(
        flash: false,
        autoFocus: true,
        formats: Barcode.ALL_FORMATS,
        multiple: false,
        waitTap: false,
        showText: true,
        preview: _previewBarcode,
        camera: _cameraBarcode,
        fps: 15.0,
      );
    } on Exception {
      barcodes.add(new Barcode('Failed to get barcode.'));
    }

    if (!mounted) return;

    setState(() {
      print(barcodes.length);
      if (barcodes.length > 0 && barcodes[0].rawValue != '') {
        _barcodes = barcodes;
        Navigator.of(context).push(new MaterialPageRoute<void>(
          builder: (BuildContext context) {
            return getScaffold(
                context: context,
                scaffoldKey: GlobalKey<ScaffoldState>(),
                body: SearchingBook(srv: MockModeler()));
          },
        ));
      }
    });
  }
}

class SearchingBook extends StatelessWidget {
  final MockModeler srv;
  final String isbn;

  SearchingBook({Key key, this.srv, this.isbn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Book>(
        future: srv.getBook("caca"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.name);
          } else if (snapshot.hasError) {
            return new WarningScreen(txt: snapshot.error);
          }
          // By default, show a loading spinner
          return const LoadingScreen(txt: "Searching for your barcode");
        },
      ),
    );
  }
}
