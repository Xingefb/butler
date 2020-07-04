import 'package:flutter/material.dart';
import 'package:guanjia_swift/screen/b_new_master.dart';
import 'package:guanjia_swift/screen/b_private.dart';
import 'package:guanjia_swift/screen/b_to_call.dart';
import 'package:guanjia_swift/r.dart';

class BAbout extends StatefulWidget {
  BAbout({Key key}) : super(key: key);

  @override
  _BAboutState createState() => _BAboutState();
}


class _BAboutState extends State<BAbout> {
  _toChat() async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BToCall()));
  }

  _toNewMaster() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BNewMaster()));
  }

  _toPrivate() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BPrivate()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
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
            onTap: _toChat,
            title: Text('联系我们'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          Divider(),
          ListTile(
            onTap: _toNewMaster,
            title: Text('帮助手册'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          ListTile(
            onTap: _toPrivate,
            title: Text('隐私协议'),
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
