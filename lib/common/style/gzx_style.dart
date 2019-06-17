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

  static Gradient primaryGradient = const LinearGradient(colors: [Colors.orange, Colors.deepOrange]);

  static const Color themeColor = Color.fromRGBO(132, 95, 63, 1.0);
  static const Color floorTitleColor = Color.fromRGBO(51, 51, 51, 1);
  static const Color searchBarBgColor = Color.fromRGBO(240, 240, 240, 1.0);
  static const Color searchBarTxtColor = Color(0xFFCDCDCD);
  static const Color divideLineColor = Color.fromRGBO(245, 245, 245, 1.0);
  static const Color categoryDefaultColor = Color(0xFF666666);
  static const Color priceColor = Color.fromRGBO(182, 9, 9, 1.0);
  static const Color pinweicorverSubtitleColor = Color.fromRGBO(153, 153, 153, 1.0);
  static const Color pinweicorverBtbgColor = themeColor;
  static const Color pinweicorverBtTxtColor = Color(0xFFFFFFFF);
  static const Color tabtxtColor = Color.fromRGBO(88, 88, 88, 1.0);
  static const Color cartDisableColor = Color.fromRGBO(221, 221, 221, 1.0);
  static const Color cartItemChangenumBtColor = Color.fromRGBO(153, 153, 153, 1.0);
  static const Color cartItemCountTxtColor = Color.fromRGBO(102, 102, 102, 1.0);
  static const Color cartBottomBgColor = Color(0xFFFFFFFF);
  static const Color goPayBtBgColor = themeColor;
  static const Color goPayBtTxtColor = Color(0xFFFFFFFF);
  static const Color searchAppBarBgColor = Color(0xFFFFFFFF);

  static const Color bottomBarbgColor = Color.fromRGBO(250, 250, 250, 1.0);

  static const Color searchRecomendDividerColor = Color(0xFFdedede);
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

  static TextStyle appBarTitleWhiteTextStyle = TextStyle(fontSize: 18, color: Colors.white);

  static TextStyle appBarTitleBlackTextStyle = TextStyle(fontSize: 16, color: Colors.black);

  static TextStyle searchResultItemCommentCountStyle = TextStyle(fontSize: 12, color: Color(0xFF999999));

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

  static const String tmall_easy_buy = 'static/images/tmall_easy_buy.png';
  static const String huangjiaju = 'static/images/可爱猫.jpeg';

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
  static const IconData time = const IconData(0xe65f, fontFamily: FONT_FAMILY);
  static const IconData time_fill = const IconData(0xe65e, fontFamily: FONT_FAMILY);
  static const IconData add_light = const IconData(0xe7dc, fontFamily: FONT_FAMILY);

  static const IconData clear = const IconData(0xe601, fontFamily: FONT_FAMILY);
  static const IconData deliver_fill = const IconData(0xe7f6, fontFamily: FONT_FAMILY);
  static const IconData comment_light = const IconData(0xe7e3, fontFamily: FONT_FAMILY);
  static const IconData comment_fill_light = const IconData(0xe7e4, fontFamily: FONT_FAMILY);
  static const IconData notification = const IconData(0xe66b, fontFamily: FONT_FAMILY);
  static const IconData notification_fill = const IconData(0xe66a, fontFamily: FONT_FAMILY);

  static const IconData emoji = const IconData(0xe64a, fontFamily: FONT_FAMILY);
  static const IconData round_add = const IconData(0xe6d9, fontFamily: FONT_FAMILY);
  static const IconData round_add_light = const IconData(0xe7a7, fontFamily: FONT_FAMILY);

  static const IconData sound = const IconData(0xe77b, fontFamily: FONT_FAMILY);
  static const IconData sound_light = const IconData(0xe7a8, fontFamily: FONT_FAMILY);

  static const IconData emoji_light = const IconData(0xe7a1, fontFamily: FONT_FAMILY);
  static const IconData friend_settings_light = const IconData(0xe7fe, fontFamily: FONT_FAMILY);

  static const IconData shop = const IconData(0xe676, fontFamily: FONT_FAMILY);
  static const IconData shop_fill = const IconData(0xe697, fontFamily: FONT_FAMILY);
  static const IconData shop_light = const IconData(0xe7b8, fontFamily: FONT_FAMILY);
  static const IconData tmall = const IconData(0xe65a, fontFamily: FONT_FAMILY);

//  static const IconData message = const IconData(0xe779, fontFamily: FONT_FAMILY);
  static const IconData appreciate_light = const IconData(0xe7e1, fontFamily: FONT_FAMILY);
  static const IconData appreciate_fill_light = const IconData(0xe7e2, fontFamily: FONT_FAMILY);
  static const IconData people_list_light = const IconData(0xe7db, fontFamily: FONT_FAMILY);
}
