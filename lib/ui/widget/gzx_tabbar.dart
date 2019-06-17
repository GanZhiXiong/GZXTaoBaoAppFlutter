import 'package:flutter/material.dart';
import 'package:flutter_taobao/common/model/tab.dart';

class GZXTabBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final List<TabModel> tabModels;
  final TabController tabController;
  final int currentIndex;
  const GZXTabBarWidget({Key key, this.tabModels, this.tabController, this.currentIndex}) : super(key: key);

  @override
  _GZXTabBarWidgetState createState() => _GZXTabBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(30);
}

class _GZXTabBarWidgetState extends State<GZXTabBarWidget> {
//  get preferredSize {
//    return Size.fromHeight(60);
//  }
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
//      width: MediaQuery.of(context).size.width,
      child: TabBar(
          controller: widget.tabController,
          indicatorColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
//          labelColor: KColorConstant.themeColor,
          labelColor: Color(0xFFfe5100),
          unselectedLabelColor: Colors.black,
          labelPadding: EdgeInsets.only(right: 5.0, left: 5.0),
          onTap: (i) {
            _selectedIndex = i;

            setState(() {});
          },
          tabs: widget.tabModels
              .map((i) => Container(
//            margin: const EdgeInsets.all(0 ),
                    padding: const EdgeInsets.all(0),
//            width: 30,
                    height: 44.0,
                    child: new Tab(
                        child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 3,
                            ),
                            Text(i.title),
                            SizedBox(
                              height: 3,
                            ),
                            widget.tabModels.indexOf(i) == widget.currentIndex
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(7),
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      color: Color(0xFFfe5100),
                                      child: Text(
                                        i.subtitle,
                                        style: TextStyle(fontSize: 9, color: Colors.white),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Text(
                                      i.subtitle,
                                      style: TextStyle(fontSize: 9, color: Color(0xFFb5b6b5)),
                                    ),
                                  )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Color(0xFFc9c9ca),
                        )
                      ],
                    )),
                  ))
              .toList()),
    );
  }
}
