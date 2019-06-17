import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/services/address.dart';
import 'package:quiver/strings.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'navigator_utils.dart';

class CommonUtils {
  static final double MILLIS_LIMIT = 1000.0;

  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;

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

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }

  static String getNewsTimeStr(DateTime date) {
    int subTime = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    if (subTime < MILLIS_LIMIT) {
      return "刚刚";
    } else if (subTime < SECONDS_LIMIT) {
      return (subTime / MILLIS_LIMIT).round().toString() + " 秒前";
    } else if (subTime < MINUTES_LIMIT) {
      return (subTime / SECONDS_LIMIT).round().toString() + " 分钟前";
    } else if (subTime < HOURS_LIMIT) {
      return (subTime / MINUTES_LIMIT).round().toString() + " 小时前";
    } else if (subTime < DAYS_LIMIT) {
      return (subTime / HOURS_LIMIT).round().toString() + " 天前";
    } else {
      return getDateStr(date);
    }
  }

  static String getTimeDuration(String comTime) {
    var nowTime = DateTime.now();
    var compareTime = DateTime.parse(comTime);
    if (nowTime.isAfter(compareTime)) {
      if (nowTime.year == compareTime.year) {
        if (nowTime.month == compareTime.month) {
          if (nowTime.day == compareTime.day) {
            if (nowTime.hour == compareTime.hour) {
              if (nowTime.minute == compareTime.minute) {
                return '片刻之间';
              }
              return (nowTime.minute - compareTime.minute).toString() + '分钟前';
            }
            return (nowTime.hour - compareTime.hour).toString() + '小时前';
          }
          return (nowTime.day - compareTime.day).toString() + '天前';
        }
        return (nowTime.month - compareTime.month).toString() + '月前';
      }
      return (nowTime.year - compareTime.year).toString() + '年前';
    }
    return 'time error';
  }

  ///版本更新
  static Future<Null> showUpdateDialog(BuildContext context, String contentMsg) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('版本更新'),
            content: new Text(contentMsg),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text('取消')),
              new FlatButton(
                  onPressed: () {
                    launch(Address.updateUrl);
                    Navigator.pop(context);
                  },
                  child: new Text('确定')),
            ],
          );
        });
  }

  static Future<Null> showPromptDialog(BuildContext context, String title, String contentMsg) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(title),
            content: new Text(contentMsg),
            actions: <Widget>[
//              new FlatButton(
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                  child: new Text('取消')),
              new FlatButton(
                  onPressed: () {
//                    launch(Address.updateUrl);
                    Navigator.pop(context);
                  },
                  child: new Text('确定')),
            ],
          );
        });
  }
}
