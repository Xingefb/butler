import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guanjia_swift/r.dart';
import 'package:guanjia_swift/screen/b_history.dart';

class BVersion extends StatefulWidget {
  BVersion({Key key}) : super(key: key);

  @override
  _BVersionState createState() => _BVersionState();
}

class _BVersionState extends State<BVersion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('版本信息'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                R.assetsIcon,
                width: 120,
              ),
            ],
          ),
          Text(
            '好牛Butler',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'version 1.0.0',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=> BHistory()));
            },
            title: Text('功能介绍'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Fluttertoast.showToast(
                  msg: '正在检测版本。。。', gravity: ToastGravity.CENTER);
              Fluttertoast.showToast(
                  msg: '当前已是最新版本~', gravity: ToastGravity.CENTER);
            },
            title: Text('检测更新'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
        ],
      )),
    );
  }
}
