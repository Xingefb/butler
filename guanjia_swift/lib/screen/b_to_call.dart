import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BToCall extends StatefulWidget {
  BToCall({Key key}) : super(key: key);

  @override
  _BToCallState createState() => _BToCallState();
}

class _BToCallState extends State<BToCall> {
  @override
  Widget build(BuildContext context) {
    Widget _bottomBtn = GestureDetector(
      child: Container(
        alignment: Alignment.center,
        child: Text('@好牛Butler 2020_Inc'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('联系我们'),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView(
              children: <Widget>[
                Text(
                  '好牛Butler - 联系我们',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text('[一款专注实用性的股票管家～]'),
                SizedBox(
                  height: 20,
                ),
                Text('公司地址:'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://api.map.baidu.com/staticimage?center=%E7%AE%AD%E5%8E%82%E8%83%A1%E5%90%8C&markers=%E7%AE%AD%E5%8E%82%E8%83%A1%E5%90%8C'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('邮箱: fzw2in@126.com'),
                Text('电话: +86 15313237429')
              ],
            )),
            _bottomBtn,
          ],
        ),
      )),
    );
  }
}
