import 'package:flutter/material.dart';

///颜色
class GZXColors {
//  static const String primarySwatchString = '#fe7301';
  static const Color primarySwatch1 = Color.fromRGBO(254, 115, 1, 1);

  static const Color tabBarDefaultForeColor = Color.fromRGBO(142, 142, 142, 1);
  static const Color mainBackgroundColor = Color.fromRGBO(241, 242, 241, 1);

  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

//  static const int primaryValue = 0xFF24292E;
//  static const int primaryLightValue = 0xFF42464b;
//  static const int primaryDarkValue = 0xFF121917;
  static const int primaryValue = 0xFFfe7301;
  static const int primaryLightValue = 0xFFfe7301;
  static const int primaryDarkValue = 0xFFfe7301;

  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int actionBlue = 0xff267aff;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;

//  static const int mainBackgroundColor = miWhite;

  static const int mainTextColor = primaryDarkValue;
  static const int textColorWhite = white;

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(primaryValue),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );
}

///文本样式
class GZXConstant {
  static const String app_default_share_url = "https://github.com/CarGuo/GSYGithubAppFlutter";

  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static TextStyle searchResultItemCommentCountStyle = TextStyle(
      fontSize: 12, color: Color(0xFF999999));

  static const minText = TextStyle(
    color: Color(GZXColors.subLightTextColor),
    fontSize: minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: Color(GZXColors.textColorWhite),
    fontSize: smallTextSize,
  );

  static const smallText = TextStyle(
    color: Color(GZXColors.mainTextColor),
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: Color(GZXColors.mainTextColor),
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: Color(GZXColors.subLightTextColor),
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: Color(GZXColors.actionBlue),
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: Color(GZXColors.miWhite),
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: Color(GZXColors.subTextColor),
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: Color(GZXColors.mainTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: Color(GZXColors.textColorWhite),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: Color(GZXColors.subTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: Color(GZXColors.subLightTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: Color(GZXColors.mainTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: Color(GZXColors.textColorWhite),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: Color(GZXColors.subTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: Color(GZXColors.mainTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextBold = TextStyle(
    color: Color(GZXColors.mainTextColor),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color: Color(GZXColors.subTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: Color(GZXColors.textColorWhite),
    fontSize: normalTextSize,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: Color(GZXColors.miWhite),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: Color(GZXColors.actionBlue),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: Color(GZXColors.primaryLightValue),
    fontSize: normalTextSize,
  );

  static const largeText = TextStyle(
    color: Color(GZXColors.mainTextColor),
    fontSize: bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: Color(GZXColors.mainTextColor),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: Color(GZXColors.textColorWhite),
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: Color(GZXColors.textColorWhite),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: Color(GZXColors.textColorWhite),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: Color(GZXColors.primaryValue),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );
}

class GZXIcons {
  static const String FONT_FAMILY = 'taobaoIconFont';
  static const String WEIXIN_FONT_FAMILY = 'wxIconFont';

  static const String DEFAULT_USER_ICON = 'static/images/logo.png';
  static const String DEFAULT_IMAGE = 'static/images/default_img.png';
  static const String DEFAULT_REMOTE_PIC =
      'https://raw.githubusercontent.com/CarGuo/GSYGithubAppFlutter/master/static/images/logo.png';

  static const IconData home = const IconData(0xe6b8, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData home_active = const IconData(0xe652, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData we_tao = const IconData(0xe6f5, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData we_tao_fill = const IconData(0xe6f4, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData message = const IconData(0xe6bc, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData message_fill = const IconData(0xe779, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData cart = const IconData(0xe6af, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData cart_fill = const IconData(0xe6b9, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData my = const IconData(0xe78b, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData my_fill = const IconData(0xe78c, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData scan = const IconData(0xe672, fontFamily: FONT_FAMILY);
  static const IconData search_light = const IconData(0xe7da, fontFamily: FONT_FAMILY);
  static const IconData camera = const IconData(0xe665, fontFamily: FONT_FAMILY);
  static const IconData qr_code = const IconData(0xe6b0, fontFamily: FONT_FAMILY);
  static const IconData delete_light = const IconData(0xe7ed, fontFamily: FONT_FAMILY);
  static const IconData attention_light = const IconData(0xe7f4, fontFamily: FONT_FAMILY);
  static const IconData attention_forbid = const IconData(0xe7b2, fontFamily: FONT_FAMILY);
  static const IconData back_light = const IconData(0xe7e0, fontFamily: FONT_FAMILY);
  static const IconData video = const IconData(0xe7c8, fontFamily: FONT_FAMILY);
  static const IconData cascades = const IconData(0xe67c, fontFamily: FONT_FAMILY);
  static const IconData list = const IconData(0xe682, fontFamily: FONT_FAMILY);
  static const IconData filter = const IconData(0xe69c, fontFamily: FONT_FAMILY);
  static const IconData jump = const IconData(0xe670, fontFamily: FONT_FAMILY);

//  static const IconData message = const IconData(0xe779, fontFamily: FONT_FAMILY);
  static const IconData appreciate_light = const IconData(0xe7e1, fontFamily: FONT_FAMILY);
  static const IconData appreciate_fill_light = const IconData(0xe7e2, fontFamily: FONT_FAMILY);
  static const IconData people_list_light = const IconData(0xe7db, fontFamily: FONT_FAMILY);

  static const IconData MORE = const IconData(0xe674, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData SEARCH = const IconData(0xe61c, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData MAIN_DT = const IconData(0xe684, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData MAIN_QS = const IconData(0xe818, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData MAIN_MY = const IconData(0xe6d0, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData MAIN_SEARCH = const IconData(0xe61c, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData LOGIN_USER = const IconData(0xe666, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData LOGIN_PW = const IconData(0xe60e, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData REPOS_ITEM_USER = const IconData(0xe63e, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_STAR = const IconData(0xe643, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_FORK = const IconData(0xe67e, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_ISSUE = const IconData(0xe661, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData REPOS_ITEM_STARED = const IconData(0xe698, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCH = const IconData(0xe681, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCHED = const IconData(0xe629, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_DIR = Icons.folder;
  static const IconData REPOS_ITEM_FILE = const IconData(0xea77, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData REPOS_ITEM_NEXT = const IconData(0xe610, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData USER_ITEM_COMPANY = const IconData(0xe63e, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData USER_ITEM_LOCATION = const IconData(0xe7e6, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData USER_ITEM_LINK = const IconData(0xe670, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData USER_NOTIFY = const IconData(0xe600, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData ISSUE_ITEM_ISSUE = const IconData(0xe661, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_COMMENT = const IconData(0xe6ba, fontFamily: GZXIcons.FONT_FAMILY);
  static const IconData ISSUE_ITEM_ADD = const IconData(0xe662, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData ISSUE_EDIT_H1 = Icons.filter_1;
  static const IconData ISSUE_EDIT_H2 = Icons.filter_2;
  static const IconData ISSUE_EDIT_H3 = Icons.filter_3;
  static const IconData ISSUE_EDIT_BOLD = Icons.format_bold;
  static const IconData ISSUE_EDIT_ITALIC = Icons.format_italic;
  static const IconData ISSUE_EDIT_QUOTE = Icons.format_quote;
  static const IconData ISSUE_EDIT_CODE = Icons.format_shapes;
  static const IconData ISSUE_EDIT_LINK = Icons.insert_link;

  static const IconData NOTIFY_ALL_READ = const IconData(0xe62f, fontFamily: GZXIcons.FONT_FAMILY);

  static const IconData PUSH_ITEM_EDIT = Icons.mode_edit;
  static const IconData PUSH_ITEM_ADD = Icons.add_box;
  static const IconData PUSH_ITEM_MIN = Icons.indeterminate_check_box;
}
