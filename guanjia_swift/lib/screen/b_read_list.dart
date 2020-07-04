import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guanjia_swift/screen/b_read_detail.dart';
import 'package:guanjia_swift/root/tool/b_data.dart';
import 'package:guanjia_swift/root/widgets/loading_widget.dart';

class BReadList extends StatefulWidget {
  BReadList({Key key}) : super(key: key);

  @override
  _BReadListState createState() => _BReadListState();
}

class _BReadListState extends State<BReadList> {
  List _list;

  @override
  void initState() {
    super.initState();
    _loadReads();
  }

  _loadReads() async {
    List list = await BData.getReads();
    _list = [];
    if (list.length > 0) {
      _list.addAll(list);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('荐股心得'),
      ),
      body: SafeArea(
        child: null == _list
            ? Center(
                child: LoadingWidget(),
              )
            : _list.length < 1
                ? Container()
                : ListView.builder(
                    itemBuilder: (c, i) {
                      String msg = _list[i];
                      var plugin = jsonDecode(msg);
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      BReadDetail(plugin: plugin)));
                        },
                        title: Text(plugin['name']),
                        subtitle: Text(plugin['date']),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      );
                    },
                    itemCount: _list.length,
                  ),
      ),
    );
  }
}
