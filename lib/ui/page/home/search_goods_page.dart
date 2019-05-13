import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/data/home.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/navigator_utils.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';
import 'package:flutter_taobao/ui/page/home/search_suggest_page.dart';
import 'package:flutter_taobao/ui/page/home/searchlist_page.dart';
import 'package:flutter_taobao/ui/widget/gzx_search_card.dart';
import 'package:flutter_taobao/ui/widget/recomend.dart';
import 'package:flutter_taobao/ui/widget/tabbar.dart';
import 'package:flutter_taobao/ui/widget/topbar.dart';

class SearchGoodsPage extends StatefulWidget {
  final String keywords;

  const SearchGoodsPage({Key key, this.keywords}) : super(key: key);
  @override
  _SearchGoodsPageState createState() => _SearchGoodsPageState();
}

class _SearchGoodsPageState extends State<SearchGoodsPage> {
  List _tabsTitle = ['全部', '天猫', '店铺'];
  List<String> recomendWords = [];
TextEditingController _keywordsTextEditingController=TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _keywordsTextEditingController.text=widget.keywords;

    if(widget.keywords!=null){
      seachTxtChanged(widget.keywords);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          length: 3,
          initialIndex: 0,
          child: Column(
//            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
//              HomeTopBar(
//                searchHintTexts: searchHintTexts,
//              ),
//            SizedBox(height: ScreenUtil.statusBarHeight,),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: GZXSearchCardWidget(
                      autofocus: widget.keywords!=null,
                      textEditingController: _keywordsTextEditingController,
                      isShowLeading: false,
                      onSubmitted: (value) {
                        NavigatorUtils.gotoSearchGoodsResultPage(context, value);
                      },
                      onChanged: (value) {
                        seachTxtChanged(value);
                      },
//                  textEditingController: _keywordTextEditingController,
//                  focusNode: _focus,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      '取消',
                      style: TextStyle(fontSize: 13),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),

              Expanded(
                  child: (recomendWords.length == 0
                      ? _buildContentWidget()
                      : RecomendListWidget(recomendWords, onItemTap: (value) {
                          NavigatorUtils.gotoSearchGoodsResultPage(context, value);
                        })))
            ],
          )),
    );
  }

  Widget _buildContentWidget() {
    return Column(
      children: <Widget>[
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
            labelPadding: EdgeInsets.only(left: 40, right: 40),
            labelStyle: TextStyle(fontSize: 12),
            onTap: (i) {
//            _selectedIndex = i;
//
//            setState(() {});
            },
//                  tabs: _tabsTitle
//                      .map((i) => Container(
//                          color: Colors.red,
//                          alignment: Alignment.center,
////width: 30,
////                      padding: EdgeInsets.symmetric(vertical: 10),
////                  padding: EdgeInsets.only(left: (ScreenUtil.screenWidth-30*3)/4),
//                          margin: EdgeInsets.only(left: (ScreenUtil.screenWidth - 30 * 3) / 4),
//                          child: new Text(
//                            i,
//                            style: TextStyle(fontSize: 12),
////                        style: GSYConstant.smallTextWhite,
//                            maxLines: 1,
//                          )))
//                      .toList()
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
            SearchSuggestPage(),
            SearchSuggestPage(),
            SearchSuggestPage(),
          ],
        ))
      ],
    );
  }

  void seachTxtChanged(String q) async {
    var result = await getSuggest(q) as List;
    recomendWords = result.map((dynamic i) {
      List item = i as List;
      return item[0] as String;
    }).toList();
    setState(() {});
  }
}
