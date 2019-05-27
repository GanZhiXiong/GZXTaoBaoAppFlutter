import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/utils/common_utils.dart';
import 'package:flutter_taobao/common/utils/sql.dart';

class Conversation {
  const Conversation(
      {@required this.avatar,
      @required this.title,
      @required this.createAt,
      this.type,
      this.isMute: false,
      this.titleColor: 0xff000000,
      this.describtion,
      this.unReadMsgCount: 0,
      this.displayDot: false,
      this.isNetwork: false})
      : assert(avatar != null),
        assert(title != null),
        assert(createAt != null);
  final String avatar;
  final String title;
  final String describtion;
  final String createAt;
  final bool isMute;
  final int titleColor;
  final int unReadMsgCount;
  final bool displayDot;
  final bool isNetwork;
  final String type;

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
        avatar: json['picture']['thumbnail'],
        createAt: CommonUtils.getTimeDuration(json['registered']['date']),
        title: json['name']['first'] + ' ' + json['name']['last'],
        describtion: json['location']['timezone']['description'],
        unReadMsgCount: json['unReadMsgCount'],
        isNetwork: true);
  }
}

class ConversationControlModel {
  final String table = 'conversation';
  Sql sql;

  ConversationControlModel() {
    sql = Sql.setTable(table);
  }

  Future clear() {
    return sql.clearTable(table);
  }

  Future insert(Conversation conversation) async {
    var response = await sql.insert({'avatar': conversation.avatar, 'name': conversation.title});
    return response;
  }

  Future<List<Conversation>> getAllConversation() async {
    List list = await sql.getByCondition();
    List<Conversation> resultList = [];
    list.forEach((item) {
      resultList.add(Conversation.fromJson(item));
    });
    return resultList;
  }
}

List<Conversation> mockConversation = [];
List<Conversation> preConversation = [
  const Conversation(avatar: '', title: '', createAt: '', describtion: ''),
  const Conversation(
    type: '官方',
      avatar: 'static/images/cainiaoyizhan.png',
      title: '菜鸟驿站',
      titleColor: 0xFF7f3410,
      createAt: '09:28',
      describtion: '手慢无！抢最高2019元大包',
      unReadMsgCount: 2),
  const Conversation(
      type: '官方',
      avatar: 'static/images/taobaotoutiao.png',
      title: '淘宝头条',
      titleColor: 0xFF7f3410,
      createAt: '12:30',
      describtion: '这栋老宅被加价5000多万，还说买家赚钱了？',
      displayDot: false,
      unReadMsgCount: 8),
  const Conversation(
    type: '官方',
    avatar: 'static/images/88members.png',
    title: '淘气值',
    titleColor: 0xFF7f3410,
    createAt: '14:01',
    describtion: '88VIP 独家包场免费看《复仇4》',
    unReadMsgCount: 10,
  ),
  const Conversation(
    type: '品牌',
    avatar: 'static/images/apple_home.png',
    title: '苹果家园',
    titleColor: 0xFF7f3410,
    createAt: '昨天',
    describtion: '😂😁🙏☺️💪👍亲，您看中的咨询的产品还没下单，请及时下单付款哟，以便快马加鞭的帮您送达呢 (*^▽^*)',
    unReadMsgCount: 5,
  ),
];

class Manager {
  // 工厂模式
  factory Manager() => _getInstance();

  static Manager get instance => _getInstance();
  static Manager _instance;
  bool _hasNewData = false;

  Manager._internal() {
    // 初始化
  }

  static Manager _getInstance() {
    if (_instance == null) {
      _instance = new Manager._internal();
    }
    return _instance;
  }

  setSate(bool hasNewData) {
    this._hasNewData = hasNewData;
  }

  getState() {
    return this._hasNewData;
  }
}
