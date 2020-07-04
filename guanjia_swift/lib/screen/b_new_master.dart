import 'package:flutter/material.dart';
import 'package:guanjia_swift/r.dart';

class BNewMaster extends StatefulWidget {
  BNewMaster({Key key}) : super(key: key);

  @override
  _BNewMasterState createState() => _BNewMasterState();
}

class _BNewMasterState extends State<BNewMaster> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('帮助手册'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: <Widget>[
              Text(
                '好牛Butler-帮助手册',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Divider(),
              Text('1、好牛免费助力股市及广大股民，特别推出专属免费软件'),
              Text('2、好牛声明本软件完全免费且长久持续的为用户更新更加符合股民朋友的贴心功能'),
              Text('3、好牛1.0.0 版本特别推出符合股市特性的几大功能'),
              SizedBox(height: 20,),
              Text('3-1、行情实时同步，涨跌不容错过'),
              Image.asset(R.assetsUser1),
              Text('3-2、股票自选，心动股票不再遗漏'),
              Image.asset(R.assetsUser2),
              Text('3-3、模拟交易，体验真实交易的心态，锻炼心神'),
              Text('3-4、杠杆配比，体验多种玩法，了解更深心得'),
              Image.asset(R.assetsUser3),
              Text('3-5、日程提醒，更友好的规划自己长远的目标，让拐点不再遗忘'),
              Image.asset(R.assetsUser4),
            ],
          ),
        ),
      ),
    );
  }
}
