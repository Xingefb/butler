import 'package:flutter/material.dart';
import 'package:guanjia_swift/r.dart';
import 'package:guanjia_swift/screen/b_about.dart';
import 'package:guanjia_swift/screen/b_feedback.dart';
import 'package:guanjia_swift/screen/b_moni_list.dart';
import 'package:guanjia_swift/screen/b_select.dart';
import 'package:guanjia_swift/screen/b_setting.dart';
import 'package:guanjia_swift/screen/b_to_call.dart';
import 'package:guanjia_swift/screen/b_version.dart';

class BMine extends StatefulWidget {
  BMine({Key key}) : super(key: key);

  @override
  _BMineState createState() => _BMineState();
}

class _BMineState extends State<BMine> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  _moniList() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BMoniList()));
  }

  _selectList() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BSelect()));
  }

  _toSetting() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BSetting()));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    Widget _top = Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                R.assetsIcon,
                width: 60,
                height: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '好牛Butler',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text('一款专注实用性的股票管家～'),
          Divider(),
        ],
      ),
    );

    Widget _icons = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _iconBtn(R.assetsMineSelects, '持仓', _moniList),
          _iconBtn(R.assetsMineNumbers, '自选', _selectList),
          _iconBtn(R.assetsMineSetting, '设置', _toSetting),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('我'),
      ),
      body: ListView(
        children: <Widget>[
          _top,
          _icons,
          _item(R.assetsMineCall, '联系我们', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => BToCall()));
          }),
          _item(R.assetsMineReview, '意见反馈', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => BFeedBack()));
          }),
          _item(R.assetsMineAboutUs, '关于我们', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => BAbout()));
          }),
          _item(R.assetsMineVersion, '版本信息', () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => BVersion()));
          }),
        ],
      ),
    );
  }

  _item(String image, String title, Function onClick) {
    return ListTile(
      onTap: onClick,
      title: Row(
        children: <Widget>[
          Image.asset(
            image,
            width: 20,
            height: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 12,
        color: Colors.grey[300],
      ),
    );
  }

  _iconBtn(String image, String title, Function click) {
    return IconButton(
        iconSize: 60,
        icon: Column(
          children: <Widget>[
            Image.asset(
              image,
              width: 30,
              height: 30,
            ),
            Text(title)
          ],
        ),
        onPressed: click);
  }

  @override
  bool get wantKeepAlive => true;
}
