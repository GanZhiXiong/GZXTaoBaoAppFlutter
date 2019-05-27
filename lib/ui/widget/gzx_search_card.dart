import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/data/home.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';

class GZXSearchCardWidget extends StatefulWidget {
  final FocusNode focusNode;
  TextEditingController textEditingController;
  final VoidCallback onTap;
  final bool isShowLeading;
  final String hintText;
  final ValueChanged<String> onSubmitted;
  final ValueChanged<String> onChanged;
  final bool autofocus;
  final bool isShowSuffixIcon;
  final double elevation;
   Widget rightWidget;

  GZXSearchCardWidget({
    Key key,
    this.focusNode,
    this.textEditingController,
    this.onTap,
    this.isShowLeading = true,
    this.onSubmitted,
    this.onChanged,
    this.autofocus = false,
    this.isShowSuffixIcon = true,
    this.hintText,
    this.elevation = 2.0,
    this.rightWidget,
  }) : super(key: key);

  @override
  _GZXSearchCardWidgetState createState() => _GZXSearchCardWidgetState();
}

class _GZXSearchCardWidgetState extends State<GZXSearchCardWidget> {
//  TextEditingController textEditingController;
  String _hintText;
  Widget _rightWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    textEditingController = widget.textEditingController;
  }

  @override
  Widget build(BuildContext context) {
//    if (widget.textEditingController == null) {
//      widget.textEditingController = TextEditingController();
//    }
    _rightWidget = widget.rightWidget;
    _rightWidget ??= Icon(
      GZXIcons.camera,
      color: Colors.grey,
      size: 20,
    );
    _hintText = widget.hintText;
    _hintText ??= searchHintTexts[Random().nextInt(searchHintTexts.length)];
    if (widget.textEditingController == null) {
      widget.textEditingController = TextEditingController();
    }

    return searchCard();
  }

  Widget searchCard() => Padding(
//    padding: const EdgeInsets.only(top: 8,bottom: 8),
        padding: const EdgeInsets.only(top: 0, right: 0),
        child: Card(
          elevation: widget.elevation,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))), //设置圆角
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                widget.isShowLeading
                    ? Padding(
                        padding: EdgeInsets.only(right: 5, top: 0, left: 5),
                        child: Icon(
                          GZXIcons.search_light,
                          color: Colors.grey,
                          size: 20,
                        ),
                      )
                    : SizedBox(
                        width: 10,
                      ),
//               Container(
//                 color: Colors.red,
//                 child:
                Expanded(
                  child: Container(
//                     color: Colors.red,
                      height: 34,
                      child: TextField(
                        autofocus: widget.autofocus,
                        onTap: widget.onTap,
                        focusNode: widget.focusNode,
                        style: TextStyle(fontSize: 13),
                        controller: widget.textEditingController,
//                        autofocus: true,
//                    focusNode: _focusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 8),
                          border: InputBorder.none,
                          hintText: _hintText,
                          suffixIcon: widget.textEditingController.text.length == 0 || !widget.isShowSuffixIcon
                              ? SizedBox()
                              : Container(
                                  width: 20.0,
                                  height: 20.0,
                                  alignment: Alignment.centerRight,
                                  child: new IconButton(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 6),
                                    iconSize: 18.0,
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey[500],
                                      size: 16,
                                    ),
//onPressed: ,
                                    onPressed: () {
                                      setState(() {
//                                  textEditingController.clear();
                                        widget.textEditingController.text = '';
                                        widget.onChanged('');
                                      });
////                                setState(() {
////                                  _inputText = "";
////                                  _hasdeleteIcon = (_inputText.isNotEmpty);
////                                  widget.fieldCallBack(_inputText);
////                                });
                                    },
                                  ),
                                ),
                        ),
                        onSubmitted: widget.onSubmitted,
                        onChanged: widget.onChanged,
//                      onChanged: (value){
//                        print('_GZXSearchCardWidgetState.searchCard  ${widget.textEditingController.text}');
//                      },
//                     ),
                      )),
                ),

                widget.textEditingController.text.length == 0 || !widget.isShowSuffixIcon
                    ? Padding(padding: EdgeInsets.only(right: 5), child: _rightWidget)
                    : SizedBox(),
              ],
            ),
          ),
        ),
      );
}
