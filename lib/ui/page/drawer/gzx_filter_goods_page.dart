import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/screen_util.dart';

class ExpansionPanelItem {
  final String headerText;
  final Widget body;
  bool isExpanded;

  ExpansionPanelItem({this.headerText, this.body, this.isExpanded});
}

class GZXFilterGoodsPage extends StatefulWidget {
  @override
  _GZXFilterGoodsPageState createState() => _GZXFilterGoodsPageState();
}

class _GZXFilterGoodsPageState extends State<GZXFilterGoodsPage> {
  List<ExpansionPanelItem> _expansionPanelItems;

  List<String> _value = ['轻薄便捷', '商务办公', '家庭影音', '家庭娱乐', '女性定位', '学生'];
  List<String> _value1 = ['尊贵旗舰', '移动工作站', '高清游戏', '炒股理财', '30876.G18'];
  List<String> _value2 = ['包邮', '天猫', '公益宝贝', '天猫直送', '花呗分期', '赠送运费险', '天猫无忧购', '消费者保障', '全球购', '淘金币抵钱', '通用排序'];
  List _value3 = ['65-5130', '5130-1.1万', '1.1万-1.5万'];
  List _value4 = ['10%的选择', '52%的选择', '23%的选择'];
  List<String> _value5 = ['江浙泸', '珠三角', '港澳台', '海外'];
  List<String> _value6 = [
    '上海',
    '北京',
    '深圳',
    '广州',
    '成都',
    '杭州',
    '重庆',
    '武汉',
    '苏州',
    '天津',
    '南京',
    '西安',
    '郑州',
    '长沙',
    '沈阳',
    '青岛',
    '宁波',
    '东莞',
    '无锡'
  ];
  List<String> _value7 = [
    '河北',
    '河南',
    '云南',
    '辽宁',
    '黑龙江',
    '湖南',
    '安徽',
    '山东',
    '新疆维吾尔',
    '江苏',
    '浙江',
    '江西',
    '湖北',
    '广西',
    '甘肃',
    '山西',
    '内蒙古',
    '陕西',
    '吉林',
    '福建',
    '贵州',
    '广东',
    '青海',
    '西藏',
    '四川',
    '宁夏回族',
    '海南',
    '台湾',
    '香港',
    '澳门',
    '台湾'
  ];

  List<String> _value8 = [
    '11.6英寸',
    '12英寸',
    '12.1英寸',
    '13英寸',
    '13.3英寸',
    '14英寸',
    '15英寸',
    '15.4英寸',
    '15.6英寸',
    '17英寸',
    '17.3英寸'
  ];
  List<String> _value9 = [
    '750GB',
    '512GB',
    '512GB',
    '纯固态512G',
    '500g',
    '500GB',
    '320GB',
    '256GB',
    '128GB',
    '128G',
    '2TB',
    '1TB',
    '无机械硬盘',
    '0'
  ];
  List<String> _value10 = ['64GB', '32GB', '16g', '16GB', '8GB', '8g', '4GB', '4G'];

  bool _isHideValue1 = true;
  bool _isHideOtherLocation = true;

  bool _isHideValue8 = true;
  bool _isHideValue9 = true;
  bool _isHideValue10 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _expansionPanelItems = <ExpansionPanelItem>[
      ExpansionPanelItem(
          headerText: 'Panel A',
//          body: Container(
//            padding: EdgeInsets.all(16.0),
//            width: double.infinity,
//            child: Image.network('http://pic1.win4000.com/wallpaper/2019-02-15/5c664c46823f8.jpg'),
//          ),
          body: Container(
            height: 200,
            width: 200,
            child: GridView.count(
              crossAxisCount: 3,
              reverse: false,
              scrollDirection: Axis.vertical,
              controller: ScrollController(
                initialScrollOffset: 0.0,
              ),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 2,
              physics: BouncingScrollPhysics(),
              primary: false,
              children: _value.map((i) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      i,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          isExpanded: false),
      ExpansionPanelItem(
          headerText: 'Panel B',
          body: Container(
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            child: Image.network('http://pic1.win4000.com/wallpaper/2019-02-14/5c651084373de.jpg'),
          ),
          isExpanded: false),
      ExpansionPanelItem(
          headerText: 'Panel C',
          body: Container(
            padding: EdgeInsets.all(16.0),
            width: double.infinity,
            child: Image.network('http://pic1.win4000.com/wallpaper/2019-02-14/5c65107a0ee05.jpg'),
          ),
          isExpanded: false)
    ];
  }

  Widget _typeGridWidget(List<String> items,{double childAspectRatio = 2.0}) {
    return GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        childAspectRatio: childAspectRatio,
        padding: EdgeInsets.only(left: 6, right: 6, top: 6),
//    padding: EdgeInsets.all(6),
        children: items.map((value) {
          return Container(
//              height: 64.0,
//              padding: EdgeInsets.only(left: 6, right: 6, top: 6),
              decoration: BoxDecoration(color: GZXColors.mainBackgroundColor, borderRadius: BorderRadius.circular(3.0)),
              child: Center(child: Text(value, style: TextStyle(color: Color(0xFF333333), fontSize: 12.0))));
        }).toList());
  }

  Widget _buildGroup() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text('适应场景', style: TextStyle(fontSize: 12, color: Color(0xFF6a6a6a))),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isHideValue1 = !_isHideValue1;
                });
              },
              child: Icon(
                _isHideValue1 ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 6,
            ),
          ],
        ),
        _typeGridWidget(_value),
        Offstage(
          offstage: _isHideValue1,
          child: _typeGridWidget(_value1),
        ),
        Container(
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
//      color: Colors.red,
                border: Border(bottom: BorderSide(width: 1, color: GZXColors.mainBackgroundColor)))),
      ],
    );
  }

  Widget _buildGroup1(String title, bool isShowExpansionIcon, List<String> items) {
    return Column(children: [
      SizedBox(
        height: 6,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 12, color: Color(0xFF6a6a6a))),
          ),
          !isShowExpansionIcon
              ? SizedBox()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      _isHideValue1 = !_isHideValue1;
                    });
                  },
                  child: Icon(
                    _isHideValue1 ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                    color: Colors.grey,
                  ),
                ),
          SizedBox(
            width: 6,
          ),
        ],
      ),
      _typeGridWidget(items),
//      Offstage(
//        offstage: _isHideValue1,
//        child: _typeGridWid2(_value1),
//      ),
      Container(
          margin: EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
//      color: Colors.red,
              border: Border(bottom: BorderSide(width: 1, color: GZXColors.mainBackgroundColor))))
    ]);
  }

  Widget _buildGroup2() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 6,
      ),
      Padding(
        padding: EdgeInsets.only(left: 6),
        child: Text('价格区间(元)', style: TextStyle(fontSize: 12, color: Color(0xFF6a6a6a))),
      ),
      SizedBox(
        height: 6,
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 6, right: 6),
              height: 25,
              decoration: BoxDecoration(
                color: GZXColors.mainBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text('最低价', style: TextStyle(fontSize: 11, color: Colors.grey)),
              alignment: Alignment.center,
            ),
          ),
          Container(
            width: 20,
            height: 1,
            color: Colors.grey[500],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 6, right: 6),
              height: 25,
              decoration: BoxDecoration(
                color: GZXColors.mainBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text('最低价', style: TextStyle(fontSize: 11, color: Colors.grey)),
              alignment: Alignment.center,
            ),
          )
        ],
      ),
      GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        childAspectRatio: 2,
        padding: EdgeInsets.only(left: 6, right: 6, top: 6),
//    padding: EdgeInsets.all(6),
        children: List.generate(
          3,
          (index) {
            return Container(
                alignment: Alignment.center,
//                height: 164.0,
                decoration:
                    BoxDecoration(color: GZXColors.mainBackgroundColor, borderRadius: BorderRadius.circular(3.0)),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(_value3[index], style: TextStyle(color: Color(0xFF333333), fontSize: 12.0)),
                    Text(_value4[index], style: TextStyle(color: Color(0xFF333333), fontSize: 11.0))
                  ],
                )));
          },
        ),
      ),
//      Offstage(
//        offstage: _isHideValue1,
//        child: _typeGridWid2(_value1),
//      ),
//    Offstage(offstage: _isHideOtherLocation,child: Container(
//      child: Column(
//        children: <Widget>[
//          Expanded(
//            child: Text('发货地', style: TextStyle(fontSize: 11, color: Color(0xFF6a6a6a))),
//          ),
//          _typeGridWid2(_value5),
//        ],
//      ),
//    ),),
      Container(
          margin: EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
//      color: Colors.red,
              border: Border(bottom: BorderSide(width: 1, color: GZXColors.mainBackgroundColor))))
    ]);
  }

  Widget _buildGroup3() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text('发货地', style: TextStyle(fontSize: 12, color: Color(0xFF6a6a6a))),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isHideOtherLocation = !_isHideOtherLocation;
                });
              },
              child: Icon(
                _isHideOtherLocation ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 6,
            ),
          ],
        ),
//        _typeGridWid2(_value),
        Row(
          children: <Widget>[
            SizedBox(
              width: 6,
            ),
            Container(
//                height: 64.0,
                padding: EdgeInsets.only(left: 8, top: 6, right: 8, bottom: 6),
                decoration:
                    BoxDecoration(color: GZXColors.mainBackgroundColor, borderRadius: BorderRadius.circular(3.0)),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text('深圳', style: TextStyle(color: Color(0xFF333333), fontSize: 12.0)),
                  ],
                )),
            SizedBox(
              width: 6,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.refresh,
                  size: 14,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 2,
                ),
                Text('定位', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
              ],
            )
          ],
        ),
        Offstage(
          offstage: _isHideOtherLocation,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 6, top: 6),
                  child: Text('区域', style: TextStyle(fontSize: 11, color: Color(0xFF6a6a6a))),
                ),
                _typeGridWidget(_value5,childAspectRatio: 3),
                Padding(
                  padding: EdgeInsets.only(left: 6, top: 6),
                  child: Text('城市', style: TextStyle(fontSize: 11, color: Color(0xFF6a6a6a))),
                ),
                _typeGridWidget(_value6,childAspectRatio: 3),
                Padding(
                  padding: EdgeInsets.only(left: 6, top: 6),
                  child: Text('省份', style: TextStyle(fontSize: 11, color: Color(0xFF6a6a6a))),
                ),
                _typeGridWidget(_value7,childAspectRatio: 3),
              ],
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
//      color: Colors.red,
                border: Border(bottom: BorderSide(width: 1, color: GZXColors.mainBackgroundColor)))),
      ],
    );
  }

  Widget _buildGroup4() {
    return Column(children: <Widget>[
      SizedBox(
        height: 6,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: Text('我喜欢', style: TextStyle(fontSize: 11, color: Color(0xFF6a6a6a))),
          ),
        ],
      ),
      SizedBox(
        height: 6,
      ),
      Row(
        children: <Widget>[
          SizedBox(
            width: 6,
          ),
          Container(
//                height: 64.0,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: GZXColors.mainBackgroundColor, borderRadius: BorderRadius.circular(3.0)),
              child: Row(
                children: <Widget>[
                  Text('购买过的店', style: TextStyle(color: Color(0xFF333333), fontSize: 12.0)),
                ],
              )),
          SizedBox(
            width: 6,
          ),
        ],
      ),
      Container(
          margin: EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
//      color: Colors.red,
              border: Border(bottom: BorderSide(width: 1, color: GZXColors.mainBackgroundColor)))),
    ]);
  }

  Widget _buildGroup5(String title, List<String> items, bool isHideValue, VoidCallback onTapExpansion) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 6,
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text(title, style: TextStyle(fontSize: 12,color: Color(0xFF6a6a6a))),
            ),
            GestureDetector(
//              onTap: () {
//                setState(() {
//                  isHideValue = !isHideValue;
//                });
//              },
              onTap: onTapExpansion,
              child: Icon(
                isHideValue ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 6,
            ),
          ],
        ),
        Offstage(
          offstage: isHideValue,
          child: _typeGridWidget(items),
        ),
        Container(
            margin: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
//      color: Colors.red,
                border: Border(bottom: BorderSide(width: 1, color: GZXColors.mainBackgroundColor)))),
      ],
    );
  }

  doi(i) {
    i++;
  }

  @override
  Widget build(BuildContext context) {
    var i = 0;
    doi(i);
    print('doi${i}');
    return Container(
      margin: EdgeInsets.only(left: ScreenUtil.screenWidth / 4, top: 0),
      color: Colors.white,
      height: ScreenUtil.screenHeight,
//      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(primary: false, shrinkWrap: true, children: <Widget>[
              _buildGroup(),
              _buildGroup1('折扣和服务', false, _value2),
              _buildGroup2(),
              _buildGroup3(),
              _buildGroup4(),
              _buildGroup5('尺寸', _value8, _isHideValue8, () {
                setState(() {
                  _isHideValue8 = !_isHideValue8;
                });
              }),
              _buildGroup5('硬盘容量', _value9, _isHideValue9, () {
                setState(() {
                  _isHideValue9 = !_isHideValue9;
                });
              }),
              _buildGroup5('内存容量', _value10, _isHideValue10, () {
                setState(() {
                  _isHideValue10 = !_isHideValue10;
                });
              }),
            ]),
          ),
          Container(
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
//            margin: EdgeInsets.only(left: 6, right: 6),
                  padding: EdgeInsets.only(left: 25, top: 6, right: 25, bottom: 6),
                  height: 34,
//                  width: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFFfea000),
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                  ),
                  child: Text(
                    '重置',
                    style: TextStyle(color: Colors.white,fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Container(
//            margin: EdgeInsets.only(left: 6, right: 6),
                  padding: EdgeInsets.only(left: 25, top: 6, right: 25, bottom: 6),
                  height: 34,
                  decoration: BoxDecoration(
                    color: Color(0xFFfe7201),
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
                  ),
                  child: Text('确定', style: TextStyle(fontSize: 15, color: Colors.white)),
                  alignment: Alignment.centerLeft,
                ),
                SizedBox(
                  width: 6,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
