import 'package:flutter/material.dart';

class BHistory extends StatefulWidget {
  BHistory({Key key}) : super(key: key);

  @override
  _BHistoryState createState() => _BHistoryState();
}

class _BHistoryState extends State<BHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('版本记录'),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemBuilder: (c, i) {
          return ListTile(
            title: Text('好牛1.0.0主要更新'),
            subtitle: Text('6月30日'),
            trailing: Icon(Icons.arrow_forward_ios,size: 14,),
          );
        },
        itemCount: 1,
      )),
    );
  }
}
