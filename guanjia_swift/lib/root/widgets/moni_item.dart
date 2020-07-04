import 'package:flutter/material.dart';
import 'package:guanjia_swift/root/plugin/moni_plugin.dart';

class MoniItem extends StatelessWidget {
  const MoniItem({Key key, @required this.plugin, this.onTap})
      : super(key: key);
  final MoniPlugin plugin;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  plugin.name,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  plugin.day,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            Text(
              '${plugin.state} ${plugin.number}*${plugin.price}元',
              style: TextStyle(
                  color: plugin.state == '卖' ? Colors.lightGreen : Colors.red, fontSize: 14),
            ),
            Text('x${plugin.lever}倍',style: TextStyle(fontWeight: FontWeight.w500),),
          ],
        ),
      ),
    );
  }
}
