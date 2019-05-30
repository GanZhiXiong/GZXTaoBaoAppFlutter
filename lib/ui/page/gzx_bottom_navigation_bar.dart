import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/ui/page/shopping_cart/shopping_cart_page.dart';
import 'package:flutter_taobao/ui/page/test/demo.dart';
import 'package:flutter_taobao/ui/page/home/home_page.dart';
import 'package:flutter_taobao/ui/page/test/test_page.dart';
import 'package:flutter_taobao/ui/page/weitao/weitao_page.dart';

import 'message/message_page.dart';
import 'my/my_page.dart';

class GZXBottomNavigationBar extends StatefulWidget {
  static final String sName = "home";

  @override
  _GZXBottomNavigationBarState createState() => _GZXBottomNavigationBarState();
}

class _GZXBottomNavigationBarState extends State<GZXBottomNavigationBar> {
  final PageController topPageControl = new PageController();
  Color foreColor = GZXColors.tabBarDefaultForeColor;
  List tabItemForeColor = new List();

  final _bottomNavigationColor = Color(0xFF585858);
  Color _bottomNavigationActiveColor = Colors.blue;

  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  ///无奈之举，只能pageView配合tabbar，通过control同步
  ///TabView 配合tabbar 在四个页面上问题太多
  _renderTabItem() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    _bottomNavigationActiveColor = Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 360)..init(context);
//    ScreenUtil.instance = ScreenUtil(width: Klength.designWidth)..init(context);

    return Scaffold(
//      drawer: new HomeDrawer(),
      body: PageView(
        controller: _controller,
        children: <Widget>[
//          Index(),
//        TestPage(),

          HomePage(),
          WeiTaoPage(),
          MessagePage(),
          ShoppingCartPage(),
          MyPage(),

////          new AmosHomePage(),
////          new CRMPage(),
////          new WebViewContainer(
////            AmosOdooApi.serverURL,
////            title: 'CRM',
////          ),
//          MessagePage(),
//          new WebViewContainer(
//            AmosOdooApi.serverURL+'/web#home',
//            title: 'ERP',
//            isNeedAppBar: false,
//          ),
//
////          new CRMPage(),
//
////          new ERPPage(),
////          new MyPage(),
////          new ContactPage2(title: 'dswe',),
////          new ContactPage(),
//          new ContactPage1(),
//          new SettingsOnePage(),
//          new MyPage()
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                GZXIcons.home,
//              Icons.message,
                color: _currentIndex == 0 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              activeIcon: Icon(
                GZXIcons.home_active,
                color: _currentIndex == 0 ? _bottomNavigationActiveColor : _bottomNavigationColor,
                size: 34,
              ),
              title: _currentIndex == 0 ? Container() : _buildBarItemTitle('首页', 0)),
          BottomNavigationBarItem(
              icon: Icon(
                GZXIcons.we_tao,
//                Icons.message,
                color: _currentIndex == 1 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              activeIcon: Icon(
                GZXIcons.we_tao_fill,
                color: _currentIndex == 1 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              title: _buildBarItemTitle('微淘', 1)),
          BottomNavigationBarItem(
              icon: Icon(
                GZXIcons.message,
//                Icons.message,
                color: _currentIndex == 2 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              activeIcon: Icon(
                GZXIcons.message_fill,
                color: _currentIndex == 2 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              title: _buildBarItemTitle('消息', 2)),
          BottomNavigationBarItem(
              icon: Icon(
                GZXIcons.cart,
//                Icons.message,
                color: _currentIndex == 3 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              activeIcon: Icon(
                GZXIcons.cart_fill,
                color: _currentIndex == 3 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              title: _buildBarItemTitle('购物车', 3)),
          BottomNavigationBarItem(
              icon: Icon(
                GZXIcons.my,
//                Icons.message,
                color: _currentIndex == 4 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              activeIcon: Icon(
                GZXIcons.my_fill,
                color: _currentIndex == 4 ? _bottomNavigationActiveColor : _bottomNavigationColor,
              ),
              title: _buildBarItemTitle('我的淘宝', 4)),
        ],
      ),
    );
  }

  Widget _buildBarItemTitle(String text, int index) {
    return Text(
      text,
      style: TextStyle(
          color: _currentIndex == index ? _bottomNavigationActiveColor : _bottomNavigationColor, fontSize: 12),
    );
  }
}
