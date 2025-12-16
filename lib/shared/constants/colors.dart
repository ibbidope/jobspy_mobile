import 'package:flutter/material.dart';

class ColorConstants {
  static Color primary = hexToColor('#1E4FFF');
  static Color accent = hexToColor('#FF8A00');
  static Color surface = hexToColor('#F1F5FF');
}

Color hexToColor(String hex) {
  assert(
    RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
    'hex color must be #rrggbb or #rrggbbaa',
  );

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
