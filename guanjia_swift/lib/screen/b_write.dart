import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guanjia_swift/root/plugin/select_plugin.dart';
import 'package:guanjia_swift/root/tool/b_data.dart';

class BWrite extends StatefulWidget {
  BWrite({Key key, this.plugin}) : super(key: key);
  final SelectPlugin plugin;
  @override
  _BWriteState createState() => _BWriteState();
}

class _BWriteState extends State<BWrite> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String _date;
  @override
  void initState() {
    super.initState();
    _date = DateTime.now().toString().substring(0, 16);
  }

  _save() async {
    String text = _textEditingController.text;
    if (null == text || text.trim().isEmpty) {
      Fluttertoast.showToast(msg: '还没有记录心得呦～', gravity: ToastGravity.CENTER);
      return;
    }
    Map<String, dynamic> msg = {
      'name': '${widget.plugin.name}',
      'date': _date,
      'code': '${widget.plugin.stock_code2}',
      'message': text,
    };
    String message = jsonEncode(msg);
    await BData.addRead(message);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('心得记录'),
        actions: <Widget>[IconButton(icon: Icon(Icons.save), onPressed: _save)],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  padding: EdgeInsets.all(12),
                  children: <Widget>[
                    Text(
                      widget.plugin.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      _date ?? '',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Divider(),
                    TextField(
                      controller: _textEditingController,
                      focusNode: _focusNode,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: '每一次灵感记录都可能帮你实现收益～',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
