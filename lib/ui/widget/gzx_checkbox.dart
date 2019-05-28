import 'package:flutter/material.dart';

class GZXCheckbox extends StatefulWidget {
  final double size;
  final Widget descriptionWidget;
  final double spacing;
  final ValueChanged<bool> onChanged;
  final bool value;

  const GZXCheckbox(
      {Key key,
      @required this.value = true,
      @required this.onChanged,
      this.size = 18,
      this.descriptionWidget,
      this.spacing = 0})
      : super(key: key);

  @override
  _GZXCheckboxState createState() => _GZXCheckboxState();
}

class _GZXCheckboxState extends State<GZXCheckbox> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Row(
        children: <Widget>[
          !widget.value
              ? Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Color(0xFFc5c6c5), width: 1)),
                )
              : Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(widget.size / 2)), color: Color(0xFFfe5400)),
                  child: Icon(
                    Icons.check,
                    size: widget.size - 4,
                    color: Colors.white,
                  ),
                ),
          SizedBox(
            width: widget.spacing,
          ),
          widget.descriptionWidget == null ? Container() : widget.descriptionWidget,
        ],
      ),
    );
  }
}
