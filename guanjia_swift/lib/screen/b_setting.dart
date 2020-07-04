import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class BSetting extends StatefulWidget {
  BSetting({Key key}) : super(key: key);

  @override
  _BSettingState createState() => _BSettingState();
}

class _BSettingState extends State<BSetting> {
  _share() async {
    await Share.share('一款专注实用性的股票管家～（快来下载安装）', subject: '好牛Butler');
  }

  _clean() {
    Fluttertoast.showToast(
        msg: '清理中。。。', gravity: ToastGravity.CENTER, timeInSecForIosWeb: 2);
    Fluttertoast.showToast(msg: '清理完成', gravity: ToastGravity.CENTER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          ListTile(
            onTap: _clean,
            title: Text('清除缓存'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
          ListTile(
            onTap: _share,
            title: Text('分享好牛'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 12,
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey[200],
          ),
        ],
      )),
    );
  }
}
