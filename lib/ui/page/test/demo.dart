import 'package:flutter/material.dart';
import 'package:flutter_taobao/ui/page/home/searchlist_page.dart';

class Index extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<String> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = ['tab_1', 'tab_2'];
  }

  Widget buildNestedScrollView() {
    return DefaultTabController(
      length: _tabs.length, // This is the number of tabs.
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              // This widget takes the overlapping behavior of the SliverAppBar,
              // and redirects it to the SliverOverlapInjector below. If it is
              // missing, then it is possible for the nested "inner" scroll view
              // below to end up under the SliverAppBar even when the inner
              // scroll view thinks it has not been scrolled.
              // This is not necessary if the "headerSliverBuilder" only builds
              // widgets that do not overlap the next sliver.
              // 交叠减震器，当组件滚动造成交叠、覆盖时，可以增加SliverOverlapAbsorber
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverAppBar(
                title: const Text('NestedScrollView'),
                // This is the title in the app bar.
                pinned: true,
                // 固定顶部appbar
                expandedHeight: 200.0,
                // 展开显示面板的最大高度
                // The "forceElevated" property causes the SliverAppBar to show
                // a shadow. The "innerBoxIsScrolled" parameter is true when the
                // inner scroll view is scrolled beyond its "zero" point, i.e.
                // when it appears to be scrolled below the SliverAppBar.
                // Without this, there are cases where the shadow would appear
                // or not appear inappropriately, because the SliverAppBar is
                // not actually aware of the precise position of the inner
                // scroll views.
                forceElevated: innerBoxIsScrolled,
                // appbar底部阴影
                bottom: TabBar(
                  // These are the widgets to put in each tab in the tab bar.
                  tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                ),
                // appbar导航左侧按钮
                leading: Container(
                  child: Icon(Icons.access_alarm),
                ),
                flexibleSpace: Container(
                  height: 200,
                  color: Colors.red,
                ),
//                flexibleSpace: FlexibleSpaceBar(
////                  background: Image.network(
////                    'https://static.moschat.com/efoxfile/Moschat/ojbk.png',
////                    filterQuality: FilterQuality.high,
////                    fit: BoxFit.none,
////                  ),
//                  background: ListView(children: <Widget>[
//                    Container(height: 200,color: Colors.red,)
//                  ],),
//                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          // These are the contents of the tab views, below the tabs.
          children: _tabs.map((String name) {
//            return SearchResultListPage('iphone');

            return SafeArea(
              top: true,
              bottom: true,
              child: Builder(
                // This Builder is needed to provide a BuildContext that is "inside"
                // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                // find the NestedScrollView.
                builder: (BuildContext context) {
                  //            return SearchResultListPage('iphone');

                  return CustomScrollView(
                    // The "controller" and "primary" members should be left
                    // unset, so that the NestedScrollView can control this
                    // inner scroll view.
                    // If the "controller" property is set, then this scroll
                    // view will not be associated with the NestedScrollView.
                    // The PageStorageKey should be unique to this ScrollView;
                    // it allows the list to remember its scroll position when
                    // the tab view is not on the screen.
                    // controller跟primary属性不需要在此设置，否则会独立与NestedScrollView的控制。
                    key: PageStorageKey<String>(name),
                    slivers: <Widget>[
                      // SliverOverlapInjector与SliverOverlapAbsorber是相对成立的，
                      // 若不增加SliverOverlapInjector，则下方的list顶部会被上方headerSliverBuilder所创建的组件遮住，
                      // 增加后，类似clear:both效果，使得布局能顺畅衔接
                      SliverOverlapInjector(
                        // This is the flip side of the SliverOverlapAbsorber above.
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      ),
//                      SearchResultListPage('iphone'),
                      SliverPadding(
                        padding: const EdgeInsets.all(8.0),
                        // In this example, the inner scroll view has
                        // fixed-height list items, hence the use of
                        // SliverFixedExtentList. However, one could use any
                        // sliver widget here, e.g. SliverList or SliverGrid.
                        sliver: SliverFixedExtentList(
                          // The items in this example are fixed to 48 pixels
                          // high. This matches the Material Design spec for
                          // ListTile widgets.
                          itemExtent: 200,
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              // This builder is called for each child.
                              // In this example, we just number each list item.
                                          return SearchResultListPage('iphone');

                              return ListTile(
                                title: Text('Item $index'),
                              );
                            },
                            // The childCount of the SliverChildBuilderDelegate
                            // specifies how many children this inner list
                            // has. In this example, each tab has a list of
                            // exactly 30 items, but this is arbitrary.
                            childCount: 1,
                          ),
                        ),
//                      sliver: Container(color: Colors.red,height: 200,),
//                      sliver: SearchResultListPage('iphone'),
//
                      ),
                    ],
                  );
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildNestedScrollView();
    return ListView(
      children: <Widget>[
        Container(
          height: 200,
          color: Colors.red,
        ),
        Container(
          height: 200,
          width: 200,
          child: buildNestedScrollView(),
        ),
      ],
    );
  }
}
