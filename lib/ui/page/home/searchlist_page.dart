import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/model/search.dart';
import 'package:flutter_taobao/common/services/search.dart';
import 'package:flutter_taobao/common/style/color.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/ui/widget/searchresult.dart';
import 'package:flutter_taobao/ui/widget/searchresult_gridview.dart';

class GoodsSortCondition {
  String name;
  bool isSelected;

  GoodsSortCondition({this.name, this.isSelected}) {}
}

class SearchResultListPage extends StatefulWidget {
  final String keyword;
  final bool isList;
  final bool isShowFilterWidget;
  final VoidCallback onTapfilter;

  SearchResultListPage(this.keyword, {this.isList = false, this.onTapfilter, this.isShowFilterWidget = false});

  @override
  State<StatefulWidget> createState() => SearchResultListState();
}

class SearchResultListState extends State<SearchResultListPage>
    with AutomaticKeepAliveClientMixin<SearchResultListPage>, SingleTickerProviderStateMixin {
  SearchResultListModal listData = SearchResultListModal([]);
  int page = 0;
  bool _isList;
  bool _isShowMask = false;
  bool _isShowDropDownItemWidget = false;
  GlobalKey _keyFilter = GlobalKey();
  GlobalKey _keyDropDownItem = GlobalKey();

  double _dropDownHeight = 0;
  Animation<double> _animation;
  AnimationController _controller;
  List _filterConditions = ['综合', '信用', '价格降序', '价格升序'];
  var _dropDownItem;
  List<GoodsSortCondition> _goodsSortConditions = [];
  GoodsSortCondition _selectGoodsSortCondition;

  SearchResultListState();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    getSearchList(widget.keyword);
    super.initState();

    _isList = widget.isList;

    _controller = new AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    _goodsSortConditions.add(GoodsSortCondition(name: '综合', isSelected: true));
    _goodsSortConditions.add(GoodsSortCondition(name: '信用', isSelected: false));
    _goodsSortConditions.add(GoodsSortCondition(name: '价格降序', isSelected: false));
    _goodsSortConditions.add(GoodsSortCondition(name: '价格升序', isSelected: false));
    _selectGoodsSortCondition=_goodsSortConditions[0];
  }

  _afterLayout(_) {
    _getPositions('_keyFilter', _keyFilter);
    _getSizes('_keyFilter', _keyFilter);

    _getPositions('_keyDropDownItem', _keyDropDownItem);
    _getSizes('_keyDropDownItem', _keyDropDownItem);
  }

  _getPositions(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var positionRed = renderBoxRed.localToGlobal(Offset.zero);
    print("POSITION of $log: $positionRed ");
  }

  _getSizes(log, GlobalKey globalKey) {
    RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
    var sizeRed = renderBoxRed.size;
    print("SIZE of $log: $sizeRed");
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dropDownItem = ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: _goodsSortConditions.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        GoodsSortCondition goodsSortCondition = _goodsSortConditions[index];
        return GestureDetector(
          onTap: () {
            for (var value in _goodsSortConditions) {
              value.isSelected = false;
            }
            goodsSortCondition.isSelected = true;
            _selectGoodsSortCondition=goodsSortCondition;

            _hideDropDownItemWidget();
          },
          child: Container(
            height: 40,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    goodsSortCondition.name,
                    style: TextStyle(
                      color: goodsSortCondition.isSelected ? Colors.red : Colors.black,
                    ),
                  ),
                ),
                goodsSortCondition.isSelected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 16,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        );

//        return Container(
////          height: 30,
//        padding: EdgeInsets.all(0),
//          child: ListTile(
//            leading: Icon(Icons.keyboard), // item 前置图标
//            trailing: Icon(
//              Icons.check,
//              color: Theme.of(context).primaryColor,
//              size: 16,
//            ), // item 后置图标
//            contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
//            isThreeLine: false, // item 是否三行显示
////          contentPadding: EdgeInsets.all(0),
////          dense:true,                // item 直观感受是整体大小
////          contentPadding: EdgeInsets.all(10.0),// item 内容内边距
//            selected: false, // item 是否选中状态
//          ),
//        );
      },
    );

    var hideWidget = Container(
      key: _keyDropDownItem,
      child: _dropDownItem,
    );
//_getSizes();
    super.build(context);
//    return Scaffold(
//        appBar: AppBar(
//            brightness: Brightness.light,
//            backgroundColor: KColorConstant.searchAppBarBgColor,
////            leading: SearchTopBarLeadingWidget(),
//            //  actions: <Widget>[SearchTopBarActionWidget()],
//            elevation: 0,
//            titleSpacing: 0,
////            title: SearchListTopBarTitleWidget(keyworld: widget.keyword)
//            ),
//        body:

//        return SearchResultListWidget(listData,
//            getNextPage: () => getSearchList(widget.keyword));
    var resultWidget = _isList
        ? SearchResultListWidget(listData, getNextPage: () => getSearchList(widget.keyword))
        : SearchResultGridViewWidget(listData, getNextPage: () => getSearchList(widget.keyword));

    return Scaffold(
        backgroundColor: GZXColors.mainBackgroundColor,
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              color: Colors.white),
//      color: Colors.red,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  widget.isShowFilterWidget ? _buildFilterWidget() : SizedBox(),
                  Offstage(
                    child: hideWidget,
                    offstage: true,
                  ),
                  Expanded(
                    child: Container(
                      color: _isList ? Colors.white : GZXColors.mainBackgroundColor,
                      child: resultWidget,
                    ),
                  ),
//                  _dropDownItem
                ],
              ),
//              Offstage(
//                offstage: true,
////                child: Positioned(
////                    child: Container(
////                  color: Colors.red,
////                )),
//child: Container(color: Colors.red,),
//              )
              _buildDrapDownWidget()
//              _dropDownHeight == 0 ? SizedBox() : _buildDrapDownWidget()
//            Offstage(offstage: _dropDownHeight==0,child: _buildDrapDownWidget() ,)
            ],
          ),
        ));
//    );
  }

  Widget _buildDrapDownWidget() {
    RenderBox renderBoxRed;
    double top=0;
    if (_dropDownHeight != 0) {
      renderBoxRed = _keyFilter.currentContext.findRenderObject();
      top=renderBoxRed.size.height;
    }
//    print('SearchResultListState._buildDrapDownWidget ${renderBoxRed.size}' );
    return Positioned(
        width: MediaQuery.of(context).size.width,
        top: top,
//    top: 50,
        left: 0,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
//                color: Colors.white,
//                height: animation.value,
              height: _animation == null ? 0 : _animation.value,

              child: _dropDownItem,
            ),
            _mask()
          ],
        )
//      height: _animation == null ? 0 : _animation.value,
//
//      child: Container(
////      color: Color.fromRGBO(0, 0, 0, 0.1),
//      color: Colors.blue,
//        width: MediaQuery.of(context).size.width,
////                color: Colors.white,
//                height: MediaQuery.of(context).size.height,
//
//        child: _dropDownItem,
//      ),
        );
  }

  Widget _mask() {
    if (_isShowMask) {
      return GestureDetector(
        onTap: () {
          _hideDropDownItemWidget();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(0, 0, 0, 0.1),
        ),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  void getSearchList(String keyword) async {
    var data = await getSearchResult(keyword, page++);
    SearchResultListModal list = SearchResultListModal.fromJson(data);
    setState(() {
      listData.data.addAll(list.data);
    });
  }

  _showDropDownItemWidget() {
    final RenderBox dropDownItemRenderBox = _keyDropDownItem.currentContext.findRenderObject();

    _dropDownHeight = dropDownItemRenderBox.size.height;
    _isShowDropDownItemWidget = !_isShowDropDownItemWidget;
    _isShowMask = !_isShowMask;

    _animation = new Tween(begin: 0.0, end: _dropDownHeight).animate(_controller)
      ..addListener(() {
        //这行如果不写，没有动画效果
        setState(() {});
      });

    if (_animation.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  _hideDropDownItemWidget() {
    _isShowDropDownItemWidget = !_isShowDropDownItemWidget;
    _isShowMask = !_isShowMask;
    _controller.reverse();
  }

  Widget _buildFilterWidget() {
    return Column(
      key: _keyFilter,
      children: <Widget>[
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    _showDropDownItemWidget();
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        _selectGoodsSortCondition.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      ),
                      Icon(
                        !_isShowDropDownItemWidget ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                        color: Colors.red,
                      )
                    ],
                  ),
                )),
            Text('销量', style: TextStyle(fontSize: 14)),
            Row(
              children: <Widget>[Text('视频 ', style: TextStyle(fontSize: 14)), Icon(GZXIcons.video, size: 14)],
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isList = !_isList;
                });
              },
              child: Container(
//                color: Colors.red,
                width: 30,
                height: 24,
                child: Icon(
                  _isList ? GZXIcons.list : GZXIcons.cascades,
                  size: 18,
                ),
              ),
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  children: <Widget>[Text('筛选', style: TextStyle(fontSize: 14)), Icon(GZXIcons.filter, size: 16)],
                ),
              ),
              onTap: widget.onTapfilter,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
