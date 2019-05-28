import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_taobao/common/data/home.dart';
import 'package:flutter_taobao/common/data/message.dart';
import 'package:flutter_taobao/common/model/conversation.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';
import 'package:flutter_taobao/common/utils/navigator_utils.dart';
import 'package:flutter_taobao/ui/widget/UserIconWidget.dart';
import 'package:flutter_taobao/ui/widget/gzx_search_card.dart';

class GZXChatPage extends StatefulWidget {
  final Conversation conversation;

  GZXChatPage({Key key, this.conversation}) : super(key: key);

  @override
  _GZXChatPageState createState() => _GZXChatPageState(conversation);
}

class _GZXChatPageState extends State<GZXChatPage> with TickerProviderStateMixin {
  Conversation _conversation;

  _GZXChatPageState(this._conversation);

  List<ChatItem> items = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    ChatItem message = new ChatItem(
      _conversation.describtion  , 1, new AnimationController(vsync: this, duration: Duration(milliseconds: 500)));
    items.add(message);
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (ChatItem message in items) message.animationController.dispose(); //  释放动效
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('_GZXChatPageState.build');
    final controller = TextEditingController();
    //定义发送文本事件的处理函数
    void _handleSubmitted(String text) {
      if (controller.text.length > 0) {
        controller.clear(); //清空输入框
        ChatItem message =
            new ChatItem(text, 0, new AnimationController(vsync: this, duration: Duration(milliseconds: 500)));
        //状态变更，向聊天记录中插入新记录
        setState(() {
          items.add(message);
        });
        message.animationController.forward();
      }
    }

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        titleSpacing: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            GZXIcons.back_light,
            color: Colors.black87,
          ),
        ),
        title: Text(
          _conversation.title,
          style: GZXConstant.appBarTitleBlackTextStyle,
        ),
        elevation: 0.0,
//        textTheme: TextTheme(),
        actions: [
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                decoration: BoxDecoration(
                    gradient: GZXColors.primaryGradient, borderRadius: BorderRadius.all(Radius.circular(10))),
//                height: 30,
                child: Text('店铺',style: TextStyle(fontSize: 11),),
              ),
            ],
          ),
IconButton(icon: Icon(GZXIcons.friend_settings_light,color: Colors.black,size: 20,), onPressed: null),
//          Row(
//            children: <Widget>[
//              Container(
//      width: 24,
//        height: 24,
////             padding: EdgeInsets.all(0),
//                decoration: BoxDecoration(
//                    gradient: GZXColors.primaryGradient, borderRadius: BorderRadius.all(Radius.circular(12))),
//                alignment: Alignment.center,
//                child: Text('店铺'),
//              ),
//            ],
//          )
        ],
      ),
      body: new Container(
        color: Color(0xFFe4e5e4),
        child: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ChatContentView(chatItem: items[index], conversation: _conversation);
              },
              itemCount: items.length,
            )),
            Divider(
              height: 1.0,
              color: Color(0xFFF7F8F8),
            ),
            Container(
              padding: EdgeInsets.only(left: 8, top: 4, bottom: 3),
//              padding: EdgeInsets.only(top: 5.0, bottom: 15.0, right: 20.0, left: 15.0),
              color: Color(0xFFf1f1f1),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
//                      SizedBox(
//                        width: 10,
//                      ),
                      Text(
                        '我想',
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            children: chatRecommendedOperatings.map((String item) {
                              return GestureDetector(
                                onTap: () {
//                                  NavigatorUtils.gotoSearchGoodsResultPage(context, item);
                                },
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  height: 20,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFFbfbfbe), width: 1),
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: new Material(
                                    borderRadius: BorderRadius.circular(10.0),
//              shadowColor: Colo rs.blue.shade200,
//              elevation: 5.0,
                                    color: Color(0xFFf2f1f1),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8),
                                      child: Center(
                                        child: Text(
                                          item,
                                          style: TextStyle(color: Colors.black54, fontSize: 13),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
//            return Text(item);
//            return _KingKongItemWidget(
//              item: item,
//            );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(GZXIcons.sound_light),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: GZXSearchCardWidget(
                          textEditingController: controller,
                          isShowLeading: false,
                          hintText: '',
                          elevation: 0,
                          isShowSuffixIcon: false,
                          onSubmitted: _handleSubmitted,
                          onChanged: (value) {
                            print('_GZXSearchCardWidgetState.searchCard  ${controller.text}');
                          },
                          rightWidget: Icon(
                            GZXIcons.emoji,
//                            color: Colors.grey,
//                            size: 2,
                          ),
                        ),
                      ),
//                      Expanded(
//                          child: Container(
//                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 5.0),
//                        decoration: BoxDecoration(
//                            borderRadius: BorderRadius.all(
//                              Radius.circular(5.0),
//                            ),
//                            color: Colors.white),
//                        child: TextField(
//                          controller: controller,
//                          decoration: InputDecoration.collapsed(hintText: null),
//                          autocorrect: true,
//                          //是否自动更正
//                          autofocus: false,
//                          textAlign: TextAlign.start,
//                          style: TextStyle(color: Colors.black),
//                          cursorColor: Colors.green,
//                          onChanged: (text) {
//                            //内容改变的回调
//                            print('change=================== $text');
//                          },
//                          onSubmitted: _handleSubmitted,
//                          enabled: true, //是否禁用
//                        ),
//                      )),
                      new Container(
                        margin: new EdgeInsets.only(left: 6, right: 8),
                        child: GestureDetector(
                          onTap: () => _handleSubmitted(controller.text),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                                gradient: GZXColors.primaryGradient,
                                borderRadius: BorderRadius.all(Radius.circular(12))),
                            alignment: Alignment.center,
                            child: Icon(
                              GZXIcons.add_light,
                              color: Colors.white,
                            ),
                          ),
                        ),
//                        child: new IconButton(
//                            //发送按钮
//                            icon: new Icon(GZXIcons.round_add_light,color: Colors.red,), //发送按钮图标
//                            onPressed: () => _handleSubmitted(controller.text)), //触发发送消息事件执行的函数_handleSubmitted
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatContentView extends StatelessWidget {
  final ChatItem chatItem;
  final Conversation conversation;

  ChatContentView({Key key, this.chatItem, this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 头像组件
    Widget userImage = new UserIconWidget(
        padding:
            EdgeInsets.only(top: 0.0, right: (chatItem.type == 0 ? 0.0 : 5.0), left: (chatItem.type == 0 ? 5.0 : 0.0)),
        width: 35.0,
        height: 35.0,
        image: chatItem.type == 0 ? 'static/images/default_nor_avatar.png' : conversation.avatar,
        isNetwork: (chatItem.type == 1 && conversation.isNetwork),
        onPressed: () {
          // NavigatorUtils.goPerson(context, eventViewModel.actionUser);
        });
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: this.chatItem.animationController, curve: Curves.easeOutCirc),
      axisAlignment: 0.0,
      child: chatItem.type == 0
          ? Container(
              margin: EdgeInsets.only(top: 8.0, left: 8.0),
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    // Column被Expanded包裹起来，使其内部文本可自动换行
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          //image: DecorationImage(image: AssetImage('static/images/chat_bg.png'), fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: Color(0xFF9EEA6A),
                        ),
                        child: Text(
                          chatItem.msg,
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      )
                    ],
                  )),
                  userImage
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.only(top: 8.0, right: 8.0),
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  userImage,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            color: Colors.white),
                        child: Text(
                          chatItem.msg,
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ),
    );
  }
}

class ChatItem {
  var msg;
  int type;
  AnimationController animationController;

  ChatItem(this.msg, this.type, this.animationController);

  String getMsg() {
    return msg;
  }
}
