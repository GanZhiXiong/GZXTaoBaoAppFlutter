import 'package:flutter/material.dart';

class GZXQuantityWidget extends StatelessWidget {
  final int quantity;
  final GestureTapCallback addTap;
  final GestureTapCallback removeTap;
  final Color borderColor;
  final double height;

  const GZXQuantityWidget(
      {Key key,
      this.quantity,
      this.addTap,
      this.removeTap,
      this.borderColor = const Color(0xFFedeeed),
      this.height = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)), border: Border.all(color: borderColor, width: 1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: removeTap,
            child: Container(
              alignment: Alignment.center,
              width: 20,
//              height: 22,
              decoration: BoxDecoration(border: _getRemoveButtonBorder()),
              child: Icon(
                Icons.remove,
                color: Colors.grey,
                size: 10,
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              width: 32,
//              height: 22,
              decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 1)),
              child: Text(
                '$quantity',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )),
          GestureDetector(
            onTap: addTap,
            child: Container(
              alignment: Alignment.center,
              width: 20,
//              height: 22,
              decoration: BoxDecoration(border: _getAddButtonBorder()),
              child: Icon(
                Icons.add,
                color: Colors.grey,
                size: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Border _getRemoveButtonBorder() {
    return Border(
      right: BorderSide(width: 1, color: borderColor),
    );
  }

  Border _getAddButtonBorder() {
    return Border(
      left: BorderSide(width: 1, color: borderColor),
    );
  }
}
