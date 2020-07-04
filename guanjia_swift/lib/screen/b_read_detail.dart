import 'package:flutter/material.dart';
import 'package:guanjia_swift/screen/b_detail.dart';

class BReadDetail extends StatefulWidget {
  BReadDetail({Key key, this.plugin}) : super(key: key);
  final Map<String, dynamic> plugin;
  @override
  _BReadDetailState createState() => _BReadDetailState();
}

class _BReadDetailState extends State<BReadDetail> {
  _toDetail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BDetail(
                  code: widget.plugin['code'],
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('心得记录'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: _toDetail),
        ],
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
                      widget.plugin['name'],
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      widget.plugin['date'],
                      style: TextStyle(color: Colors.grey),
                    ),
                    Divider(),
                    Text(widget.plugin['message'])
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
