import 'package:fluttertoast/fluttertoast.dart';
import 'package:guanjia_swift/root/plugin/moni_plugin.dart';
import 'package:guanjia_swift/root/plugin/select_plugin.dart';
import 'package:guanjia_swift/root/tool/b_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String selectList = 'select_list';
const String moniList = 'moni_list';
const String readList = 'read_list';

class BData {
  // start 自选------
  /// 搜索 添加自选
  static addNumber(String stockNumber) async {
    SharedPreferences per = await SharedPreferences.getInstance();
    List<String> list = per.getStringList(selectList);
    if (null == list) {
      list = [];
    }
    if (!list.contains(stockNumber)) {
      list.add(stockNumber);
      await per.setStringList(selectList, list);
      eventBus.fire(RefreshSelectList(true));
      Fluttertoast.showToast(msg: '添加成功', gravity: ToastGravity.CENTER);
    } else {
      Fluttertoast.showToast(msg: '重复添加', gravity: ToastGravity.CENTER);
    }
  }

  /// 详情页面 自选成功
  static Future<bool> selectNumber(String stockNumber) async {
    SharedPreferences per = await SharedPreferences.getInstance();
    List<String> list = per.getStringList(selectList);
    if (null == list) {
      list = [];
    }
    if (list.contains(stockNumber)) {
      list.remove(stockNumber);
      await per.setStringList(selectList, list);
      eventBus.fire(RefreshSelectList(true));
      return false;
    } else {
      list.add(stockNumber);
      await per.setStringList(selectList, list);
      eventBus.fire(RefreshSelectList(true));
      return true;
    }
  }

  /// 自选查询
  static Future<String> searchNumbers() async {
    SharedPreferences per = await SharedPreferences.getInstance();
    List<String> list = per.getStringList(selectList);
    if (null == list || list.length < 1) {
      return null;
    } else {
      String url = '';
      for (var item in list) {
        url = '$url$item,';
      }
      return url;
    }
  }
// end 自选------

  /// start 添加持仓 -------
  static Future toAddPush(
      {bool isAdd,
      int number,
      int lever,
      double price,
      SelectPlugin plugin}) async {
    if (null == number || number < 1) {
      Fluttertoast.showToast(msg: '请输入交易数量', gravity: ToastGravity.CENTER);
      return;
    }
    SharedPreferences per = await SharedPreferences.getInstance();
    List<String> list = per.getStringList(moniList);
    if (null == list) {
      list = [];
    }
    double currentPrice = double.parse(plugin.current_prices);
    String state = isAdd ? '买' : '卖';
    var date = new DateTime.now();
    String day =
        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    String second =
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}";
    String bsMsg =
        '${plugin.name};${plugin.stock_code2};$currentPrice;$number;$lever;$state;$day;$second';
    print(bsMsg);
    list.add(bsMsg);
    if (await per.setStringList(moniList, list)) {
      Fluttertoast.showToast(msg: '交易成功', gravity: ToastGravity.CENTER);
    }
  }

  /// 获取模拟持仓数据
  static Future<List> loadMoniList() async {
    SharedPreferences per = await SharedPreferences.getInstance();
    List<String> list = per.getStringList(moniList);
    if (null == list) {
      return list;
    } else {
      List data = [];
      for (var item in list) {
        MoniPlugin plugin = MoniPlugin();
        List temp = item.split(';');
        plugin.name = temp.first;
        plugin.code = temp[1];
        plugin.price = temp[2];
        plugin.number = temp[3];
        plugin.lever = temp[4];
        plugin.state = temp[5];
        plugin.day = temp[6];
        plugin.second = temp.last;
        data.add(plugin);
      }
      return data;
    }
  }

  /// start 添加心得
  static addRead(String message) async {
    SharedPreferences per = await SharedPreferences.getInstance();
    List<String> list = per.getStringList(readList);
    if (null == list) {
      list = [];
    }
    list.add(message);
    await per.setStringList(readList, list);
    Fluttertoast.showToast(msg: '添加成功', gravity: ToastGravity.CENTER);
  }

  static Future<List> getReads() async {
    SharedPreferences per = await SharedPreferences.getInstance();
    List<String> list = per.getStringList(readList);
    if (null == list) {
      list = [];
    } 
    return list;
  }
}
