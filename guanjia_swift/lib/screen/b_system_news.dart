import 'package:flutter/material.dart';
import 'package:guanjia_swift/r.dart';

class BSystemNews extends StatefulWidget {
  BSystemNews({Key key}) : super(key: key);

  @override
  _BSystemNewsState createState() => _BSystemNewsState();
}

class _BSystemNewsState extends State<BSystemNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('系统消息'),
       ),
       body: SafeArea(child: Center(
         child: Image.asset(R.assetsNoSystemNews),
       ),),
    );
  }
}