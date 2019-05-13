import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'dart:math' as math;

class CommonUtils {
  static Color string2Color(String colorString) {
    int value = 0x00000000;

    if (isNotEmpty(colorString)) {
      if (colorString[0] == '#') {
        colorString = colorString.substring(1);
      }
      value = int.tryParse(colorString, radix: 16);
      if (value != null) {
        if (value < 0xFF000000) {
          value += 0xFF000000;
        }
      }
    }
    return Color(value);
  }

  static Map url2query(String url) {
    var search = new RegExp('([^&=]+)=?([^&]*)');
    var result = new Map();

    // Get rid off the beginning ? in query strings.
    if (url.startsWith('?')) url = url.substring(1);

    // A custom decoder.
    decode(String s) => Uri.decodeComponent(s.replaceAll('+', ' '));

    // Go through all the matches and build the result map.
    for (Match match in search.allMatches(url)) {
      result[decode(match.group(1))] = decode(match.group(2));
    }

    return result;
  }

  static Color randomColor() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }
}
