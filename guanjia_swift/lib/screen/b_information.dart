import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:guanjia_swift/root/plugin/information_plugin.dart';

class BInformation extends StatefulWidget {
  BInformation({Key key, @required this.plugin}) : super(key: key);
  final Records plugin;
  @override
  _BInformationState createState() => _BInformationState();
}

class _BInformationState extends State<BInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Flexible(
              child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Text(
                  widget.plugin.articleTitle.trim(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Text(
                  widget.plugin.createTime.trim(),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  widget.plugin.author.trim(),
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Html(data: widget.plugin.content.trim()),
              )
            ],
          ))
        ],
      )),
    );
  }
}
