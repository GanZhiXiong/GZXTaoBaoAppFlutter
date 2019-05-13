import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/style/gzx_style.dart';

class TextFieldTestPage extends StatefulWidget {
  @override
  _TextFieldTestPageState createState() => _TextFieldTestPageState();
}

class _TextFieldTestPageState extends State<TextFieldTestPage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: searchCard(),
    );
  }

  Widget searchCard() => Padding(
//    padding: const EdgeInsets.only(top: 8,bottom: 8),
        padding: const EdgeInsets.only(top: 0, right: 0),
        child: Card(
          elevation: 2.0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))), //设置圆角
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                     Padding(
                        padding: EdgeInsets.only(right: 5, top: 0, left: 5),
                        child: Icon(
                          GZXIcons.search_light,
                          color: Colors.grey,
                          size: 20,
                        ),
                      )
                    ,
//               Container(
//                 color: Colors.red,
//                 child:
                Expanded(
                  child: Container(
//                     color: Colors.red,
                      height: 30,
                      child: TextField(
//                        onTap: widget.onTap,
//                        focusNode: widget.focusNode,
                        style: TextStyle(fontSize: 13),
                        controller: textEditingController,
//                        autofocus: true,
//                    focusNode: _focusNode,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(top: 6),
                          border: InputBorder.none,
//                          hintText: searchHintTexts[Random().nextInt(searchHintTexts.length)],
                          suffixIcon: textEditingController.text.length == 0
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
                                        textEditingController.text = '';
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
//                        onSubmitted: widget.onSubmitted,
                        onChanged: (value){
                          print('onchanged $value');
                          setState(() {

                          });
                        },
//                     ),
                      )),
                ),

                textEditingController.text.length == 0
                    ? Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          GZXIcons.camera,
                          color: Colors.grey,
                          size: 20,
                        ))
                    : SizedBox(),
              ],
            ),
          ),
        ),
      );
}
