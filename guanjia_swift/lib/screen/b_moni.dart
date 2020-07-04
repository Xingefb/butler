import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:guanjia_swift/root/plugin/select_plugin.dart';
import 'package:guanjia_swift/root/tool/b_data.dart';
import 'package:guanjia_swift/root/tool/b_notification.dart';
import 'package:guanjia_swift/root/widgets/num_change_widget.dart';

class BMoni extends StatefulWidget {
  BMoni({Key key, @required this.plugin, @required this.isAdd})
      : super(key: key);
  final SelectPlugin plugin;
  final bool isAdd;
  @override
  _BMoniState createState() => _BMoniState();
}

class _BMoniState extends State<BMoni> {
  int _number;
  int _lever = 1;
  double _price = 0.00;
  FocusNode _focusNode = FocusNode();
  TextEditingController _editingController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  _toPush() async {
    int numbers = int.parse(widget.plugin.traded_num);
    if (_number < numbers) {
      await BData.toAddPush(
          isAdd: widget.isAdd,
          number: _number,
          lever: _lever,
          plugin: widget.plugin);
      eventBus.fire(RefreshMoniList(true));
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: '超过最大交易数', gravity: ToastGravity.CENTER);
    }
  }

  _pushNumber(text) {
    String number = text.trim();
    RegExp exp = RegExp(r"^[1-9]\d*$");
    bool matched = exp.hasMatch(number);
    if (matched) {
      _number = int.parse(number);
      _price = _number * double.parse(widget.plugin.current_prices);
    } else {
      _editingController.text = '';
      _price = 0.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget _top = SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${widget.plugin.name} [${widget.plugin.stock_code2}]',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text(
                  '价格: ${double.parse(widget.plugin.current_prices).toStringAsFixed(2)} 元',
                  style: TextStyle(fontSize: 16, color: Colors.red)),
              SizedBox(height: 8),
              Text('数量: ${widget.plugin.traded_num}',
                  style: TextStyle(fontSize: 14)),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red[50],
          ),
        ),
      ),
    );

    Widget _title = SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16),
        child: Text(
          '模拟配置',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );

    Widget _leverWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('杠杆配比'),
        NumChangeWidget(
          num: _lever,
          onValueChanged: (int lever) {
            _lever = lever;
            setState(() {});
          },
        ),
      ],
    );

    Widget _numberWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('交易数量'),
        Container(
          width: 120,
          child: TextField(
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.end,
            textInputAction: TextInputAction.done,
            focusNode: _focusNode,
            controller: _editingController,
            onSubmitted: (text) {
              _pushNumber(text);
            },
            onChanged: (text) {
              _pushNumber(text);
            },
          ),
        ),
      ],
    );

    Widget _priceWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('合计金额'),
          SizedBox(
            width: 20,
          ),
          Text(
            '${(_price * _lever).toStringAsFixed(2)} 元',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );

    Widget _divider = SizedBox(
      height: 16,
    );

    Widget _bottom = SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
        child: Column(
          children: <Widget>[
            _leverWidget,
            _divider,
            _numberWidget,
          ],
        ),
      ),
    );

    Widget _pushBtn = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toPush,
      child: Container(
        height: 50,
        color: widget.isAdd ? Colors.red : Colors.lightGreen,
        alignment: Alignment.center,
        child: Text(
          widget.isAdd ? '确定买入' : '确定卖出',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    Widget _body = SafeArea(
      child: Column(
        children: <Widget>[
          Flexible(
              child: CustomScrollView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              _top,
              _title,
              _bottom,
            ],
          )),
          _priceWidget,
          _divider,
          _pushBtn,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.plugin.name}'),
      ),
      body: _body,
    );
  }
}
