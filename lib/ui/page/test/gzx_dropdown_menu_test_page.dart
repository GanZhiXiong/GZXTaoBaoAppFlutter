import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
class SortCondition {
  String name;
  bool isSelected;

  SortCondition({this.name, this.isSelected}) {}
}

class GZXDropDownMenuTestPage extends StatefulWidget {
  @override
  _GZXDropDownMenuTestPageState createState() => _GZXDropDownMenuTestPageState();
}

class _GZXDropDownMenuTestPageState extends State<GZXDropDownMenuTestPage> {
  List<String> _dropDownHeaderItemStrings = ['全城', '品牌', '价格低', '筛选'];
  List<SortCondition> _brandSortConditions = [];
  List<SortCondition> _distanceSortConditions = [];
  SortCondition _selectBrandSortCondition;
  SortCondition _selectDistanceSortCondition;
  GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();

  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _brandSortConditions.add(SortCondition(name: '全部', isSelected: true));
    _brandSortConditions.add(SortCondition(name: '金逸影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '中影国际城我比较长，你看我选择后是怎么显示的', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '星美国际城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '博纳国际城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '大地影院', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '嘉禾影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '太平洋影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城1', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城2', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城3', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城4', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城5', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城6', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城7', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城8', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '万达影城9', isSelected: false));
    _selectBrandSortCondition = _brandSortConditions[0];

    _distanceSortConditions.add(SortCondition(name: '距离近', isSelected: true));
    _distanceSortConditions.add(SortCondition(name: '价格低', isSelected: false));
    _selectDistanceSortCondition = _distanceSortConditions[0];
  }

  @override
  Widget build(BuildContext context) {
    print('_GZXDropDownMenuTestPageState.build');

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.dark,
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
          ),
          preferredSize: Size.fromHeight(0)),
      backgroundColor: Colors.white,
      endDrawer: Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4, top: 0),
        color: Colors.white,
      ),
      body: Stack(
        key: _stackKey,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 44,
                color: Theme.of(context).primaryColor,
                alignment: Alignment.center,
                child: Text(
                  '仿美团电影下拉筛选菜单',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
//              SizedBox(height: 20,),
              GZXDropDownHeader(
                items: [
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[0]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[1]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[2]),
                  GZXDropDownHeaderItem(_dropDownHeaderItemStrings[3], iconData: GZXIcons.filter, iconSize: 18),
                ],
                stackKey: _stackKey,
                controller: _dropdownMenuController,
                onItemTap: (index) {
                  if (index == 3) {
                    _scaffoldKey.currentState.openEndDrawer();
                    _dropdownMenuController.hide();
                  }
                },
//                height: 40,
//                color: Colors.red,
//                borderWidth: 1,
//                borderColor: Color(0xFFeeede6),
//                dividerHeight: 20,
//                dividerColor: Color(0xFFeeede6),
//                style: TextStyle(color: Color(0xFF666666), fontSize: 13),
//                dropDownStyle: TextStyle(
//                  fontSize: 13,
//                  color: Theme
//                      .of(context)
//                      .primaryColor,
//                ),
//                iconSize: 20,
//                iconColor: Color(0xFFafada7),
//                iconDropDownColor: Theme.of(context).primaryColor,
              ),
              Expanded(
                child: ListView.separated(
                    itemCount: 100,
                    separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: ListTile(
                          leading: Text('test$index'),
                        ),
                        onTap: () {},
                      );
                    }),
              ),
            ],
          ),
          GZXDropDownMenu(
            controller: _dropdownMenuController,
            menus: [
              GZXDropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: _buildQuanChengWidget((selectValue) {
                    _dropDownHeaderItemStrings[0] = selectValue;
                    _dropdownMenuController.hide();
                    setState(() {});
                  })),
              GZXDropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: _buildConditionListWidget(_brandSortConditions, (value) {
                    _selectBrandSortCondition = value;
                    _dropDownHeaderItemStrings[1] =
                        _selectBrandSortCondition.name == '全部' ? '品牌' : _selectBrandSortCondition.name;
                    _dropdownMenuController.hide();
                    setState(() {});
                  })),
              GZXDropdownMenuBuilder(
                  dropDownHeight: 40.0 * _distanceSortConditions.length,
                  dropDownWidget: _buildConditionListWidget(_distanceSortConditions, (value) {
                    _dropDownHeaderItemStrings[2] = _selectDistanceSortCondition.name;
                    _selectDistanceSortCondition = value;
                    _dropdownMenuController.hide();
                    setState(() {});
                  })),
            ],
          ),

//          Positioned(
//              width: 200,
//              height: 200,
//              left: 0,
//              top: 0,
//              child: Container(
//                color: Colors.red,
//                width: 200,
//                height: 300,
//              ))
        ],
      ),
    );
  }

  int _selectTempFirstLevelIndex = 0;
  int _selectFirstLevelIndex = 0;

  int _selectSecondLevelIndex = -1;

  _buildQuanChengWidget(void itemOnTap(String selectValue)) {
//    List firstLevels = new List<int>.filled(15, 0);
    List firstLevels = new List<String>.generate(15, (int index) {
      if (index == 0) {
        return '全部';
      }
      return '$index区';
    });

    List secondtLevels = new List<String>.generate(15, (int index) {
      if (index == 0) {
        return '全部';
      }
      return '$_selectTempFirstLevelIndex$index街道办';
    });

    return Row(
      children: <Widget>[
        Container(
          width: 100,
          child: ListView(
            children: firstLevels.map((item) {
              int index = firstLevels.indexOf(item);
              return GestureDetector(
                onTap: () {
                  _selectTempFirstLevelIndex = index;

                  if (_selectTempFirstLevelIndex == 0) {
                    itemOnTap('全城');
                    return;
                  }
                  setState(() {});
                },
                child: Container(
                    height: 40,
                    color: _selectTempFirstLevelIndex == index ? Colors.grey[200] : Colors.white,
                    alignment: Alignment.center,
                    child: _selectTempFirstLevelIndex == index
                        ? Text(
                            '${item}',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : Text('${item}')),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.grey[200],
            child: _selectTempFirstLevelIndex == 0
                ? Container()
                : ListView(
                    children: secondtLevels.map((item) {
                      int index = secondtLevels.indexOf(item);
                      return GestureDetector(
                          onTap: () {
                            _selectSecondLevelIndex = index;
                            _selectFirstLevelIndex = _selectTempFirstLevelIndex;
                            if (_selectSecondLevelIndex == 0) {
                              itemOnTap(firstLevels[_selectFirstLevelIndex]);
                            } else {
                              itemOnTap(item);
                            }
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.centerLeft,
                            child: Row(children: <Widget>[
                              SizedBox(
                                width: 20,
                              ),
                              _selectFirstLevelIndex == _selectTempFirstLevelIndex && _selectSecondLevelIndex == index
                                  ? Text(
                                      '${item}',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  : Text('${item}'),
                            ]),
                          ));
                    }).toList(),
                  ),
          ),
        )
      ],
    );
  }

  _buildConditionListWidget(items, void itemOnTap(SortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        SortCondition goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value.isSelected = false;
            }
            goodsSortCondition.isSelected = true;

            itemOnTap(goodsSortCondition);
          },
          child: Container(
//            color: Colors.blue,
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
      },
    );
  }
}
