import 'dart:async';

import 'package:barcode_check/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeCheck extends StatefulWidget {
  @override
  _BarcodeCheckState createState() => _BarcodeCheckState();
}

class _BarcodeCheckState extends State<BarcodeCheck> {
  String _scanBarcode = 'Lets Begin';
  bool isIndian = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      isIndian = searchBarcode(barcodeScanRes);
      if (barcodeScanRes != '-1')
        _scanBarcode = isIndian ? 'Indian Product' : 'Not Indian Product';
      else
        _scanBarcode = 'Please scan again';
    });
  }

  bool searchBarcode(String barcodeValue) {
    String result = barcodeValue == '-1' ? '0' : barcodeValue.substring(0, 3);
    print('result $result');
    if (result == '890') {
      return true;
    } else {
      return false;
    }
  }

  void factCheck(bool isIndian) {
    setState(() {
      _scanBarcode = isIndian ? 'Indian Product' : 'Not Indian Product';
    });
  }

  void _searchBarcodeView(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: SearchBarcode(
              isIndian: isIndian,
              scanBarcode: _scanBarcode,
              factCheck: factCheck,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search Indian Products'),
          backgroundColor: Colors.purple,
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              // color: Colors.black,
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                          highlightedBorderColor: Colors.red,
                          hoverColor: Colors.purple,
                          onPressed: () => scanBarcodeNormal(),
                          child: Text("Start barcode scan")),
                      OutlineButton(
                          highlightedBorderColor: Colors.red,
                          hoverColor: Colors.purple,
                          onPressed: () => _searchBarcodeView(context),
                          child: Text("Search barcode")),
                    ],
                  ),
                  Text(
                    'Scan result : $_scanBarcode\n',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
