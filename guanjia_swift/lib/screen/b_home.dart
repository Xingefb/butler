import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:guanjia_swift/r.dart';
import 'package:guanjia_swift/screen/b_read_list.dart';
import 'package:guanjia_swift/screen/b_information.dart';
import 'package:guanjia_swift/screen/b_information_list.dart';
import 'package:guanjia_swift/screen/b_last_news.dart';
import 'package:guanjia_swift/screen/b_moni_list.dart';
import 'package:guanjia_swift/screen/b_new_master.dart';
import 'package:guanjia_swift/screen/b_to_call.dart';
import 'package:guanjia_swift/root/plugin/information_plugin.dart';
import 'package:guanjia_swift/root/tool/b_api.dart';
import 'package:guanjia_swift/root/widgets/loading_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BHome extends StatefulWidget {
  BHome({Key key}) : super(key: key);

  @override
  _BHomeState createState() => _BHomeState();
}

class _BHomeState extends State<BHome> with AutomaticKeepAliveClientMixin {
  List _list;
  int _pageIndex;
  RefreshController _refreshController = RefreshController();

  List _icons = [
    {'title': '最新公告', 'icon': R.assetsH1},
    {'title': '帮助手册', 'icon': R.assetsH2},
    {'title': '联系我们', 'icon': R.assetsH3},
    {'title': '我的持仓', 'icon': R.assetsH4},
    {'title': '荐股心得', 'icon': R.assetsH5},
    {'title': '新闻资讯', 'icon': R.assetsH6},
  ];

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

  _clikcIndex(i) {
    switch (i) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BLastNews()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BNewMaster()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => BToCall()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BMoniList()));
        break;
      case 4:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BReadList()));
        break;
      case 5:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => BInformationList()));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: null == _list
          ? null
          : AppBar(
              title: Text('好牛'),
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
          child: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: null == _list
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            '好牛Butler',
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[200]),
                          ),
                        )
                      : Swiper(
                          itemCount: 4,
                          itemBuilder: (c, i) {
                            Records plugin = _list[i];
                            return CachedNetworkImage(
                              imageUrl: plugin.imgUrl,
                              fit: BoxFit.fitWidth,
                            );
                          },
                        ),
                ),
              ),
              SliverGrid.count(
                crossAxisCount: 3,
                childAspectRatio: 1.6,
                children: List.generate(6, (i) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => _clikcIndex(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          _icons[i]['icon'],
                          width: 44,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(_icons[i]['title']),
                      ],
                    ),
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: Divider(),
              ),
              null == _list
                  ? SliverToBoxAdapter(
                    child: LoadingWidget(),
                  )
                  : SliverList(
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
                    }, childCount: _list.length)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
