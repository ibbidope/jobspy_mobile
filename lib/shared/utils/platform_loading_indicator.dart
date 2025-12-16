import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PlatformLoadingIndicator extends StatelessWidget {
  final Color color;

  const PlatformLoadingIndicator({super.key, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(radius: 15.0, color: color);
    } else {
      return CircularProgressIndicator(
        strokeWidth: 3.0,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      );
    }
  }
}
