import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:guanjia_swift/root/plugin/select_plugin.dart';

class SelectItem extends StatelessWidget {
  const SelectItem({Key key, this.plugin, this.onTap, this.onLongPress})
      : super(key: key);
  final SelectPlugin plugin;
  final onTap;
  final onLongPress;

  @override
  Widget build(BuildContext context) {
    var num = NumUtil.divideDec(double.parse(plugin.current_prices),
            double.parse(plugin.yesterday_close))
        .toDouble();
    var beishu = (num > 1 ? num - 1 : 1 - num) * 100;
    var zhuangtai = num > 1 ? '+' : num == 1 ? '' : '-';
    Color yanse = num > 1 ? Colors.red : num == 1 ? Colors.grey : Colors.green;
    TextStyle _style = TextStyle(color: yanse);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.only(top: 12),
        alignment: Alignment.center,
        // height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      plugin.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '${double.parse(plugin.current_prices).toStringAsFixed(2)}元',
                    style: _style,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '$zhuangtai ${beishu.toStringAsFixed(2)}%',
                    style: _style,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12,),
            Container(
              padding: EdgeInsets.only(left:20),
              child: Divider(height: 1,),
            )
          ],
        ),
      ),
    );
  }
}
