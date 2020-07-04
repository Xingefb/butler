import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guanjia_swift/r.dart';
import 'package:guanjia_swift/screen/b_home.dart';
import 'package:guanjia_swift/screen/b_mine.dart';
import 'package:guanjia_swift/screen/b_select.dart';
import 'package:guanjia_swift/root/tool/b_notification.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  double _itemW = 24;
  String _text;

  @override
  void initState() {
    super.initState();
    eventBus.on<RefreshNews>().listen((onData) {
      if (null == onData.text) {
      } else {
        _text = onData.text;
        setState(() {});
      }
    });
    _loadData();
  }

  _loadData() async {
    try {
      Response res = await Dio().get('https://www.loself.com/app/info');
      eventBus.fire(RefreshNews(text: res.data['text']));
    } catch (e) {
      _loadData();
    }
  }

  _icon(icon) {
    return Image.asset(
      icon,
      width: _itemW,
      height: _itemW,
    );
  }

  _item(
      {@required String icon, @required String aIcon, @required String title}) {
    return BottomNavigationBarItem(
        icon: _icon(icon), activeIcon: _icon(aIcon), title: Text(title));
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      _item(icon: R.assetsIconN, aIcon: R.assetsIconS, title: '首页'),
      _item(icon: R.assetsIcon1N, aIcon: R.assetsIcon1S, title: '自选'),
      _item(icon: R.assetsIcon2N, aIcon: R.assetsIcon2S, title: '我'),
    ];

    List<Widget> pages = [
      BHome(),
      BSelect(),
      BMine(),
    ];

    return null == _text
        ? Scaffold(
            body: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: items,
              onTap: (page) {
                _currentIndex = page;
                setState(() {});
                _pageController.jumpToPage(page);
              },
              currentIndex: _currentIndex,
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: _text.contains('http')
                  ? WebView(
                      initialUrl: _text,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebResourceError: (error) {
                        eventBus.fire(RefreshNews(text: null));
                      },
                    )
                  : Center(child: Text('系统维护中...')),
            ),
          );
  }
}
