import 'package:flutter/material.dart';
import 'package:guanjia_swift/r.dart';
import 'package:guanjia_swift/screen/b_detail.dart';
import 'package:guanjia_swift/screen/b_search.dart';
import 'package:guanjia_swift/root/plugin/select_plugin.dart';
import 'package:guanjia_swift/root/tool/b_data.dart';
import 'package:guanjia_swift/root/tool/b_api.dart';
import 'package:guanjia_swift/root/tool/b_notification.dart';
import 'package:guanjia_swift/root/widgets/loading_widget.dart';
import 'package:guanjia_swift/root/widgets/select_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BSelect extends StatefulWidget {
  BSelect({Key key}) : super(key: key);

  @override
  _BSelectState createState() => _BSelectState();
}

class _BSelectState extends State<BSelect>
    with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController = RefreshController();
  List _list;

  @override
  void initState() {
    super.initState();
    eventBus.on<RefreshSelectList>().listen((onData) {
      // ignore: unnecessary_statements
      onData.refresh ? _loadData() : () {};
    });
    _loadData();
  }

  _deleteItem(SelectPlugin plugin) {
    Alert(
        context: context,
        title: '取消自选',
        desc: '是否移除${plugin.name}?',
        buttons: [
          DialogButton(
            child: Text(
              "确定",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => _removeNumber(plugin),
            color: Colors.red,
          ),
        ],
        closeFunction: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        }).show();
  }

  _removeNumber(SelectPlugin plugin) async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    await BData.selectNumber(plugin.stock_code2);
    _loadData();
  }

  _addSelect() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => BSearch()));
  }

  _toDetail(SelectPlugin plugin) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BDetail(
                  code: plugin.stock_code2,
                )));
  }

  _loadData() async {
    String url = await BData.searchNumbers();
    if (null == url) {
      _list = [];
      setState(() {});
      return;
    }
    try {
      String res = await BApi.loadSelect(url);
      List<String> stockstrs = res.split(";");
      _list = [];
      for (var item in stockstrs) {
        SelectPlugin plugin = SelectPlugin();
        _list.add(ConfigPlugin(item, plugin));
        if (_list.length > 0) {
          setState(() {});
        }
      }
    } catch (e) {
      _refreshController.refreshFailed();
    }
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // loading widget
    Widget _loadingWidget = LoadingWidget();
    // temp widget
    Widget _tempWidget = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _addSelect,
      child: Center(
        child: Image.asset(R.assetsAddASelect),
      ),
    );
    // body widget

    return Scaffold(
      appBar: AppBar(
        title: Text('自选'),
        actions: <Widget>[
          null == _list || _list.length < 1
              ? SizedBox()
              : IconButton(
                  icon: Image.asset(R.assetsAddZx,
                      width: 24, height: 24),
                  onPressed: _addSelect)
        ],
      ),
      body: null == _list
          ? _loadingWidget
          : _list.length < 1 ? _tempWidget : _listWidget(),
    );
  }

  _listWidget() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _loadData,
      child: ListView.builder(
        itemBuilder: (context, index) {
          SelectPlugin plugin = _list[index];
          SelectItem _item = SelectItem(
            plugin: plugin,
            onTap: () => _toDetail(plugin),
            onLongPress: () => _deleteItem(plugin),
          );
          return _item;
        },
        itemCount: _list.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
