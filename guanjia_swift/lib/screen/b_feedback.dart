import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BFeedBack extends StatefulWidget {
  BFeedBack({Key key}) : super(key: key);

  @override
  _BFeedBackState createState() => _BFeedBackState();
}

class _BFeedBackState extends State<BFeedBack> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController1 = TextEditingController();
  FocusNode _focusNode1 = FocusNode();

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _focusNode.unfocus();
      _focusNode1.unfocus();
    });
  }

  _pushFeedBack() {
    if (null == _textEditingController.text ||
        _textEditingController.text.trim().isEmpty) {
      Fluttertoast.showToast(msg: '请输入您发现的问题～', gravity: ToastGravity.CENTER);
      return;
    }
    Fluttertoast.showToast(msg: '感谢您的反馈', gravity: ToastGravity.CENTER);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget _bottomBtn = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _pushFeedBack,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            height: 50,
            alignment: Alignment.center,
            color: Colors.red,
            child: Text(
              '提交',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ))
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('意见反馈'),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ListView(
                controller: _scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  Text('请描述发现的问题'),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    maxLines: 6,
                    decoration: InputDecoration(
                        hintText: '请输入你发现的问题', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  TextField(
                    controller: _textEditingController1,
                    focusNode: _focusNode1,
                    decoration: InputDecoration(
                        hintText: '请输入手机号', helperText: '联系方式（选填，便于我们与你联系）'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      '${DateTime.now().year}年${DateTime.now().month}月${DateTime.now().day}日 ${DateTime.now().hour}时:${DateTime.now().minute}分'),
                ],
              ),
            ),
          ),
          _bottomBtn,
        ],
      )),
    );
  }
}
