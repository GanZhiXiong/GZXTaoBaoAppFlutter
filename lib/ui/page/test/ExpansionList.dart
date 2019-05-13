import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListItem {
  final WidgetBuilder bodyBuilder;
  final String title;
  final String subtitle;
  bool isExpandedInitially;

  ListItem({
    @required this.bodyBuilder,
    @required this.title,
    this.subtitle = "",
    this.isExpandedInitially = false,
  })  : assert(title != null),
        assert(bodyBuilder != null);

  ExpansionPanelHeaderBuilder get headerBuilder =>
          (context, isExpanded) => new Row(children: [
        new SizedBox(width: 100.0, child: new Text(title)),
        new Text(subtitle)
      ]);
}

class ExpansionList extends StatefulWidget {
  /// The items that the expansion list should display; this can change
  /// over the course of the object but probably shouldn't as it won't
  /// transition nicely or anything like that.
  final List<ListItem> items;

  ExpansionList(this.items) {
    // quick check to make sure there's no duplicate titles.
    assert(new Set.from(items.map((li) => li.title)).length == items.length);
  }

  @override
  State<StatefulWidget> createState() => new ExpansionListState();
}

class ExpansionListState extends State<ExpansionList> {
  Map<String, bool> expandedByTitle = new Map();

  @override
  Widget build(BuildContext context) {
    return new ExpansionPanelList(
      children: widget.items
          .map(
            (item) => new ExpansionPanel(
            headerBuilder: item.headerBuilder,
            body: new Builder(builder: item.bodyBuilder),
            isExpanded:
            expandedByTitle[item.title] ?? item.isExpandedInitially),
      )
          .toList(growable: false),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          expandedByTitle[widget.items[index].title] = !isExpanded;
        });
      },
    );
  }
}

void main() => runApp(
  new MaterialApp(
    home: new SingleChildScrollView(
      child: new SafeArea(
        child: new Material(
          child: new ExpansionList(
            [
              new ListItem(
                  title: "Title 1",
                  subtitle: "Subtitle 1",
                  bodyBuilder: (context) => new Text("Body 1")),
              new ListItem(
                  title: "Title 2",
                  subtitle: "Subtitle 2",
                  bodyBuilder: (context) => new Text("Body 1"),
                  isExpandedInitially: true)
            ],
          ),
        ),
      ),
    ),
  ),
);