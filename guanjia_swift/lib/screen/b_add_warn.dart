import 'package:add_calendar_oc/add_calendar_oc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BAddWarn extends StatefulWidget {
  BAddWarn({Key key, this.name}) : super(key: key);
  final String name;
  @override
  _BAddWarnState createState() => _BAddWarnState();
}

class _BAddWarnState extends State<BAddWarn> {
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  DateTime _startTime;
  DateTime _endTime;
  String _description;
  String _dateFormat = 'yyyy年M月d日 EEE,H时:m分';
  DateTimePickerLocale _locale = DateTimePickerLocale.zh_cn;

  _choiceStart() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _dateFormat,
      pickerMode: DateTimePickerMode.datetime,
      locale: _locale,
      minDateTime: DateTime.now(),
      pickerTheme: DateTimePickerTheme(
        cancel: Text(
          '取消',
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        confirm: Text(
          '确定',
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      onConfirm: (DateTime time, List<int> list) {
        _startTime = time;
        setState(() {});
      },
    );
  }

  _choiceEnd() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _dateFormat,
      pickerMode: DateTimePickerMode.datetime,
      minDateTime: _startTime.add(Duration(minutes: 10)),
      locale: _locale,
      pickerTheme: DateTimePickerTheme(
        cancel: Text(
          '取消',
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
        ),
        confirm: Text(
          '确定',
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      onConfirm: (DateTime time, List<int> list) {
        print(time);
        _endTime = time;
        setState(() {});
      },
    );
  }

  _setting() async {
    if (null == _startTime || null == _endTime) {
      Fluttertoast.showToast(msg: '完善起止时间');
      return;
    }
    if (null == _description) {
      Fluttertoast.showToast(msg: '添加备注信息');
      return;
    }
    await AddCalendarOc.addCalendar(widget.name, _description,
        startTime: _startTime, endTime: _endTime, lication: '', allDay: false);
  }

  @override
  Widget build(BuildContext context) {
    Widget _bottomBtn = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _setting,
      child: Container(
        height: 50,
        child: Text('设置提醒', style: TextStyle(color: Colors.white)),
        alignment: Alignment.center,
        color: Colors.red,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('日程提醒'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView(
                children: <Widget>[
                  _selectTime(true, _choiceStart, _startTime),
                  _selectTime(false, _choiceEnd, _endTime),
                  _descriptWidget(),
                ],
              ),
            ),
            _bottomBtn,
          ],
        ),
      ),
    );
  }

  _selectTime(bool isStart, Function onClick, DateTime time) {
    TextStyle titleStyle = TextStyle(fontSize: 17);
    TextStyle subTitleStyle = TextStyle(fontSize: 14);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        child: Row(
          children: <Widget>[
            Text(
              isStart ? '开始时间' : '结束时间',
              style: titleStyle,
            ),
            Expanded(child: SizedBox()),
            Text(
              null == time ? '请选择' : time.toString().substring(0, 16),
              style: subTitleStyle,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 12,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  _descriptWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16),
            child: Text(
              widget.name + '【备注】',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
        Theme(
            data: ThemeData(primaryColor: Colors.red),
            child: Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: _textEditingController,
                focusNode: _focusNode,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '有行情及时添加一个备注提醒呦！',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  _description = text.trim();
                },
              ),
            )),
      ],
    );
  }
}
