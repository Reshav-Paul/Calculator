import 'package:flutter/material.dart';

import '../Utilities/ui_colors.dart';
import './sidebar_items.dart';
import './ui_colors.dart';

class CollapsingCard extends StatefulWidget {
  final SideBarItemStructure item;
  final AnimationController animationController;
  final VoidCallback onTap;

  CollapsingCard({this.item, this.animationController, this.onTap});
  @override
  _CollapsingCardState createState() => _CollapsingCardState();
}

class _CollapsingCardState extends State<CollapsingCard> {
  double maxWidth, minWidth;
  Animation<double> _widthAnimation;

  @override
  void initState() {
    maxWidth = 260.0;
    minWidth = 45.0;
    _widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(widget.animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: _widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
        child: new InkWell(
          onTap: widget.onTap,
          child: Row(
            children: <Widget>[
              (_widthAnimation.value >= maxWidth)
                  ? (widget.item.children.isEmpty)
                      ? getSingleTile(widget.item)
                      : getCollapsingExpansionTile(widget.item)
                  : new Container(
                      padding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                          left: (_widthAnimation.value - 45) / 19),
                      child: Icon(
                        widget.item.icon,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    )
            ],
          ),
        ));
  }

  Widget getSingleTile(SideBarItemStructure item) {
    return new Container(
        width: maxWidth,
          child: ListTile(
            title: Text(
              item.title,
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            leading: Icon(
              item.icon,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        );
  }

  Widget getCollapsingExpansionTile(SideBarItemStructure item) {
    if (item.children.isEmpty)
      return new Container(
          width: maxWidth,
            child: ListTile(
              title: Text(
                item.title,
                style: TextStyle(color: darkBackgroundColor, fontSize: 15.0),
              ),
              leading: Icon(
                item.icon,
                color: darkBackgroundColor,
                size: 24.0,
              ),
            ),
          );
    return new Container(
      width: maxWidth,
        decoration: new BoxDecoration(
            color: lightButtonColor, //Color(0xaf113e14),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: ExpansionTile(
          leading: Icon(
            widget.item.icon,
            color: darkBackgroundColor,
            size: 24.0,
          ),
          key: PageStorageKey<SideBarItemStructure>(item),
          title: Text(
            item.title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: darkBackgroundColor,
                fontSize: 15.0),
          ),
          children: item.children.map(getCollapsingExpansionTile).toList(),
        ),
    );
  }
}
