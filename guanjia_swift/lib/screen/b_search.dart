import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:guanjia_swift/root/plugin/select_plugin.dart';
import 'package:guanjia_swift/root/tool/b_data.dart';
import 'package:guanjia_swift/root/tool/b_api.dart';

class BSearch extends StatefulWidget {
  BSearch({Key key}) : super(key: key);

  @override
  _BSearchState createState() => _BSearchState();
}

class _BSearchState extends State<BSearch> {
  final SearchBarController<SelectPlugin> _searchBarController =
      SearchBarController();
  bool isReplay = false;
  List<SelectPlugin> _list = [];

  Future<List<SelectPlugin>> _searchNumber(String text) async {
    try {
      String res = await BApi.loadSelect(text);
      List<String> stockstrs = res.split(";");
      stockstrs.removeLast();
      _list = [];
      for (var item in stockstrs) {
        SelectPlugin plugin = SelectPlugin();
        _list.add(ConfigPlugin(item, plugin));
      }
      return _list;
    } catch (e) {
      return [];
    }
  }

  _addNumber(String number) async {
    await BData.addNumber(number);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SearchBar(
        searchBarController: _searchBarController,
        minimumChars: 6,
        onCancelled: () {
          Navigator.pop(context);
        },
        searchBarPadding: EdgeInsets.symmetric(horizontal: 16),
        headerPadding: EdgeInsets.symmetric(horizontal: 16),
        listPadding: EdgeInsets.symmetric(horizontal: 16),
        header: Wrap(
          spacing: 10,
          children: <Widget>[
            RaisedButton(
              color: Colors.redAccent[100],
              padding: EdgeInsets.all(6),
              child: Text("爱迪尔", style: TextStyle(color: Colors.white)),
              onPressed: () => _addNumber('sz002740'),
            ),
            RaisedButton(
              color: Colors.redAccent[100],
              child: Text("聚合顺", style: TextStyle(color: Colors.white)),
              onPressed: () => _addNumber('sh605166'),
            ),
            RaisedButton(
              color: Colors.redAccent[100],
              child: Text("利德曼", style: TextStyle(color: Colors.white)),
              onPressed: () => _addNumber('sz300289'),
            ),
            RaisedButton(
              color: Colors.redAccent[100],
              child: Text("虹软科技", style: TextStyle(color: Colors.white)),
              onPressed: () => _addNumber('sh688088'),
            ),
            RaisedButton(
              color: Colors.redAccent[100],
              child: Text("南国置业", style: TextStyle(color: Colors.white)),
              onPressed: () => _addNumber('sz002305'),
            ),
          ],
        ),
        onSearch: _searchNumber,
        cancellationWidget: Text('取消'),
        hintText: '请输入股票代码[例:sh601669]',
        onItemFound: (SelectPlugin selectNumber, int index) {
          return ListTile(
            onTap: () {
              _addNumber(selectNumber.stock_code2);
            },
            title: Text('${selectNumber.name}'),
            subtitle: Text('${selectNumber.stock_code}'),
            trailing: Text('${double.parse(selectNumber.current_prices)}元'),
          );
        },
      )),
    );
  }
}
