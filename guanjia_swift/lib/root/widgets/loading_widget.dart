import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key key, this.color, this.size}) : super(key: key);
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        size: size ?? 40,
        color: color ?? Colors.red,
      ),
    );
  }
}
