import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guanjia_swift/screen/b_information.dart';
import 'package:guanjia_swift/root/plugin/information_plugin.dart';
import 'package:guanjia_swift/root/tool/b_api.dart';
import 'package:guanjia_swift/root/widgets/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BInformationList extends StatefulWidget {
  BInformationList({Key key}) : super(key: key);

  @override
  _BInformationListState createState() => _BInformationListState();
}

class _BInformationListState extends State<BInformationList> {
  List _list;
  int _pageIndex;
  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _loadNews(true);
  }

  _loadNews(bool isRefresh) async {
    if (isRefresh) {
      _pageIndex = 1;
    }
    try {
      var res = await BApi.loadNews('https://www.loself.com/article/list',
          {'page_index': _pageIndex, 'page_size': '20'});
      InformationPlugin plugin = InformationPlugin.fromJson(res);
      if (isRefresh) {
        _list = [];
        _refreshController.loadComplete();
      } else {
        _pageIndex = plugin.data.current + 1;
      }
      _list.addAll(plugin.data.records);
      setState(() {});
      isRefresh
          ? _refreshController.refreshCompleted()
          : plugin.data.records.length > 0
              ? _refreshController.loadComplete()
              : _refreshController.loadNoData();
    } catch (e) {
      isRefresh
          ? _refreshController.refreshFailed()
          : _refreshController.loadFailed();
    }
  }

  _toInformation(Records plugin) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => BInformation(plugin: plugin)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新闻资讯'),
      ),
      body: SafeArea(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () {
            _loadNews(true);
          },
          onLoading: () {
            _loadNews(false);
          },
          controller: _refreshController,
          child: null == _list
              ? Center(
                  child: LoadingWidget(),
                )
              : CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Wrap(
                          spacing: 12,
                          // runSpacing: 12,
                          children: <Widget>[
                            ActionChip(
                                label: Text('快讯'),
                                onPressed: () {
                                  // _pageIndex = 1;
                                  // _loadNews(true);
                                }),
                            ActionChip(
                                label: Text('国内资讯'),
                                onPressed: () {
                                  // _pageIndex = 5;
                                  // _loadNews(true);
                                }),
                            ActionChip(
                                label: Text('国际市场'),
                                onPressed: () {
                                  // _pageIndex = 7;
                                  // _loadNews(true);
                                }),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((c, i) {
                        Records plugin = _list[i];
                        return ListTile(
                          onTap: () => _toInformation(plugin),
                          leading: plugin.imgUrl.isEmpty
                              ? null
                              : CachedNetworkImage(imageUrl: plugin.imgUrl),
                          title: Text(plugin.articleTitle),
                          subtitle: Text(plugin.createTime),
                        );
                      }, childCount: _list.length),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
