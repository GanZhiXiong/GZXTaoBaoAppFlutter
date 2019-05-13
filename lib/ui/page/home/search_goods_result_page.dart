import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/ui/page/drawer/gzx_filter_goods_page.dart';
import 'package:flutter_taobao/ui/page/home/searchlist_page.dart';
import 'package:flutter_taobao/ui/widget/gzx_search_card.dart';

class SearchGoodsResultPage extends StatefulWidget {
  final String keywords;

  const SearchGoodsResultPage({Key key, this.keywords}) : super(key: key);

  @override
  _SearchGoodsResultPageState createState() => _SearchGoodsResultPageState();
}

class _SearchGoodsResultPageState extends State<SearchGoodsResultPage> {
  List _tabsTitle = ['全部', '天猫', '店铺', '淘宝经验'];
  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      endDrawer: GZXFilterGoodsPage(),
      backgroundColor: GZXColors.mainBackgroundColor,
      appBar: PreferredSize(
          child: AppBar(
//              bottomOpacity: 0,
//              toolbarOpacity: 0,
            brightness: Brightness.light,
            backgroundColor: GZXColors.mainBackgroundColor,
            elevation: 0,
//              forceElevated: false, //是否显示阴影
          ),
          preferredSize: Size.fromHeight(0)),
      body: DefaultTabController(
          length: 4,
          initialIndex: 0,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      GZXIcons.back_light,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GZXSearchCardWidget(
                      isShowLeading: false,
//                  textEditingController: _keywordTextEditingController,
//                  focusNode: _focus,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                          height: 16,
//                          padding: const EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
//                    color: randomColor(),
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            '20',
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          )),
                      Container(
                        height: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.more_horiz,
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              TabBar(
//          controller: widget.tabController,
                  indicatorColor: Color(0xFFfe5100),
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
//          labelColor: KColorConstant.themeColor,
                  labelColor: Color(0xFFfe5100),
                  unselectedLabelColor: Colors.black,
//          labelPadding: EdgeInsets.only(left: (ScreenUtil.screenWidth-30*3)/4),
                  labelPadding: EdgeInsets.only(left: 30, right: 30),
//                  labelStyle: TextStyle(fontSize: 1),
                  onTap: (i) {},
                  tabs: _tabsTitle
                      .map((i) => Text(
                            i,
                          ))
                      .toList()),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  child: TabBarView(
                children: <Widget>[
                  SearchResultListPage(
                    widget.keywords,
                    isList: true,
                    isShowFilterWidget: true,
                    onTapfilter: (){
                      _scaffoldkey.currentState.openEndDrawer();
                    },
                  ),
                ],
              ))
            ],
          )),
    );
  }
}
