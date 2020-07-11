import 'package:flutter/material.dart';
import 'package:guanjia_swift/r.dart';
import 'package:guanjia_swift/screen/b_home.dart';
import 'package:guanjia_swift/screen/b_mine.dart';
import 'package:guanjia_swift/screen/b_select.dart';

class Root extends StatefulWidget {
  Root({Key key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  double _itemW = 24;

  @override
  void initState() {
    super.initState();
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

    return Scaffold(
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
    );
  }
}
