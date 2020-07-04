import 'package:flutter/material.dart';
import 'package:guanjia_swift/r.dart';
import 'package:guanjia_swift/screen/b_system_news.dart';

class BLastNews extends StatefulWidget {
  BLastNews({Key key}) : super(key: key);

  @override
  _BLastNewsState createState() => _BLastNewsState();
}

class _BLastNewsState extends State<BLastNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('最新公告'),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=> BSystemNews()));
              },
              leading: Image.asset(
                R.assetsH6,
                width: 30,
                height: 30,
              ),
              title: Text('系统消息'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
