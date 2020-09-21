import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchBarcode extends StatefulWidget {
  bool isIndian;
  String scanBarcode;
  Function factCheck;
  SearchBarcode({this.isIndian, this.scanBarcode, this.factCheck});
  @override
  _SearchBarcodeState createState() => _SearchBarcodeState();
}

class _SearchBarcodeState extends State<SearchBarcode> {
  final _titleController = TextEditingController();

  void checkIndianBarcode(String barcodeValue) {
    String result = barcodeValue.substring(0, 3);
    if (result == '890') {
      setState(() {
        widget.isIndian = true;
      });
    }
    widget.factCheck(widget.isIndian);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Input Barcode'),
              controller: _titleController,
              onSubmitted: (_) => checkIndianBarcode(_titleController.text),
              // onChanged: (e) => titleInput = e,
            ),
            RaisedButton(
              child: Text('Check Product'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () => {checkIndianBarcode(_titleController.text)},
            ),
          ],
        ),
      ),
    );
  }
}
