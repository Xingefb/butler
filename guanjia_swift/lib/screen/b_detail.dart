import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:guanjia_swift/screen/b_add_warn.dart';
import 'package:guanjia_swift/screen/b_moni.dart';
import 'package:guanjia_swift/screen/b_write.dart';
import 'package:guanjia_swift/r.dart';
import 'package:guanjia_swift/root/plugin/select_plugin.dart';
import 'package:guanjia_swift/root/tool/b_data.dart';
import 'package:guanjia_swift/root/tool/b_api.dart';
import 'package:guanjia_swift/root/widgets/loading_widget.dart';

class BDetail extends StatefulWidget {
  BDetail({Key key, this.code}) : super(key: key);
  final String code;
  @override
  _BDetailState createState() => _BDetailState();
}

class _BDetailState extends State<BDetail> {
  SelectPlugin _plugin;
  bool _isSelect = false;
  @override
  void initState() {
    super.initState();
    _setupState();
    _loadData();
  }

  // 模拟交易
  _toMoni(bool isAdd) {
    if (null == _plugin) {
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BMoni(
                    plugin: _plugin,
                    isAdd: isAdd,
                  )));
    }
  }

  // 添加提醒
  _addAlarm() {
    if (null == _plugin) {
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BAddWarn(
                    name: _plugin.name,
                  )));
    }
  }

  // 书写心得
  _writeMessage() {
    if (null == _plugin) {
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => BWrite(
                    plugin: _plugin,
                  )));
    }
  }

  // 添加自选
  _tapSelect() async {
    _isSelect = await BData.selectNumber(widget.code);
    setState(() {});
  }

  // 获取自选信息
  _setupState() async {
    String selectNumbers = await BData.searchNumbers();
    _isSelect = selectNumbers.contains(widget.code);
    setState(() {});
  }

  // 加载数据
  _loadData() async {
    try {
      String res = await BApi.loadSelect(widget.code);
      List<String> stockstrs = res.split(";");
      for (var item in stockstrs) {
        SelectPlugin plugin = SelectPlugin();
        _plugin = ConfigPlugin(item, plugin);
        setState(() {});
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Widget _loading = LoadingWidget();

    Widget _leftBtn = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _tapSelect,
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                _isSelect ? R.assetsZxS : R.assetsZxN,
                width: 24),
            Text('自选',
                style: TextStyle(
                    fontSize: 12,
                    color: _isSelect ? Colors.red : Colors.grey[350])),
          ],
        ),
      ),
    );

    Widget _centerBtn = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _toMoni(false),
      child: Container(
        color: Colors.lightGreen,
        alignment: Alignment.center,
        child: Text('模拟卖出', style: TextStyle(color: Colors.white)),
      ),
    );

    Widget _rightBtn = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _toMoni(true),
      child: Container(
        color: Colors.red,
        alignment: Alignment.center,
        child: Text('模拟买入', style: TextStyle(color: Colors.white)),
      ),
    );

    Widget _bottomBtns = Container(
      alignment: Alignment.center,
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(child: _leftBtn, flex: 1),
          Expanded(child: _centerBtn, flex: 3),
          Expanded(child: _rightBtn, flex: 3),
        ],
      ),
    );

    Widget _body = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: CustomScrollView(
              slivers: <Widget>[
                _titleWidget(),
                _contentWidget(),
                _imagesWidget(),
              ],
            ),
          ),
          _bottomBtns,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_plugin?.name ?? ''),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.border_color), onPressed: _writeMessage),
          IconButton(icon: Icon(Icons.add_alarm), onPressed: _addAlarm),
        ],
      ),
      body: null == _plugin ? _loading : _body,
    );
  }

  _temp() {
    return SliverToBoxAdapter(
      child: SizedBox(),
    );
  }

  _imagesWidget() {
    if (null == _plugin) {
      return _temp();
    } else {
      double hei = MediaQuery.of(context).size.width * 300 / 545;
      //    'min',
      // 'daily',
      // 'weekly',
      // 'monthly',
      return SliverToBoxAdapter(
        child: Container(
          child: Column(
            children: <Widget>[
              Text('分时'),
              Container(
                height: hei,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://image.sinajs.cn/newchart/min/n/${_plugin.stock_code2}.gif',
                ),
              ),
              Text('日K'),
              Container(
                height: hei,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://image.sinajs.cn/newchart/daily/n/${_plugin.stock_code2}.gif',
                ),
              ),
              Text('周K'),
              Container(
                height: hei,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://image.sinajs.cn/newchart/weekly/n/${_plugin.stock_code2}.gif',
                ),
              ),
              Text('月K'),
              Container(
                height: hei,
                child: CachedNetworkImage(
                  imageUrl:
                      'http://image.sinajs.cn/newchart/monthly/n/${_plugin.stock_code2}.gif',
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  _contentWidget() {
    if (null == _plugin) {
      return _temp();
    } else {
      return SliverToBoxAdapter(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    '昨收: ${double.parse(_plugin.yesterday_close).toStringAsFixed(2)}'),
                Text(
                    '今开: ${double.parse(_plugin.today_open).toStringAsFixed(2)}'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    '最高: ${double.parse(_plugin.today_highest_price).toStringAsFixed(2)}'),
                Text(
                    '最低: ${double.parse(_plugin.today_lowest_price).toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ));
    }
  }

  _titleWidget() {
    if (null == _plugin) {
      return _temp();
    } else {
      var num = NumUtil.divideDec(double.parse(_plugin.current_prices),
              double.parse(_plugin.yesterday_close))
          .toDouble();
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                double.parse(_plugin.current_prices).toStringAsFixed(2),
                style: TextStyle(
                    color: num > 1 ? Colors.red : Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              Text(_plugin.stock_code2)
            ],
          ),
        ),
      );
    }
  }
}
