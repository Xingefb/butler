import 'package:flutter/material.dart';
import 'package:guanjia_swift/screen/b_detail.dart';
import 'package:guanjia_swift/root/plugin/moni_plugin.dart';
import 'package:guanjia_swift/root/tool/b_data.dart';
import 'package:guanjia_swift/root/tool/b_notification.dart';
import 'package:guanjia_swift/root/widgets/loading_widget.dart';
import 'package:guanjia_swift/root/widgets/moni_item.dart';

class BMoniList extends StatefulWidget {
  BMoniList({Key key}) : super(key: key);

  @override
  _BMoniListState createState() => _BMoniListState();
}

class _BMoniListState extends State<BMoniList> {
  List _list;

  @override
  void initState() {
    super.initState();
    eventBus.on<RefreshMoniList>().listen((onData) {
      // ignore: unnecessary_statements
      onData.refresh ? _loadMoniList() : () {};
    });
    _loadMoniList();
  }

  _toDetail(MoniPlugin plugin) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BDetail(
                  code: plugin.code,
                )));
  }

  _loadMoniList() async {
    _list = [];
    List data = await BData.loadMoniList() ?? [];
    print(data);
    _list.addAll(data);
    setState(() {});
    return;
  }

  @override
  Widget build(BuildContext context) {
    Widget _loading = LoadingWidget();
    Widget _tempWidget = Center();

    return Scaffold(
      appBar: AppBar(
        title: Text('模拟持仓'),
      ),
      body: SafeArea(
        child:
            null == _list ? _loading : _list.length < 1 ? _tempWidget : _body(),
      ),
    );
  }

  _body() {
    return ListView.builder(
      itemBuilder: (c, i) {
        MoniPlugin plugin = _list[i];
        return MoniItem(
          plugin: plugin,
          onTap: () => _toDetail(plugin),
        );
      },
      itemCount: _list.length,
    );
  }
}
