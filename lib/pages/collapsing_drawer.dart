import 'package:flutter/material.dart';

import '../Utilities/sidebar_items.dart';
import '../Utilities/collapsing_card.dart';
import '../Utilities/ui_colors.dart';

class CollapsingDrawer extends StatefulWidget {
  @override
  _CollapsingDrawerState createState() => _CollapsingDrawerState();
}

class _CollapsingDrawerState extends State<CollapsingDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth, minWidth;
  bool isCollapsed = true;
  AnimationController _animationController;
  Animation<double> widthAnimation;

  @override
  void initState() {
    maxWidth = 280.0;
    minWidth = 45.0;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    return Container(
        width: widthAnimation.value,
        color: darkBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 30.0),
              child: new CollapsingCard(
                item: SideBarItemStructure(
                    "MathBox", Colors.white, Icons.cloud_circle, []),
                animationController: _animationController,
                onTap: () {},
              ),
            ),
            new Divider(
              height: 20.0,
              color: Colors.blueGrey,
            ),
            new Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                itemBuilder: (context, counter) {
                  return CollapsingCard(
                    item: sideBarItems[counter],
                    animationController: _animationController,
                    onTap: () => tapHandler(sideBarItems[counter].title),
                  );
                },
                itemCount: sideBarItems.length,
              ),
            ),
            InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed
                        ? _animationController.reverse()
                        : _animationController.forward();
                  });
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _animationController,
                  color: Colors.blueGrey,
                  size: 22.0,
                )),
            new SizedBox(
              height: 22.0,
            )
          ],
        ));
  }

  tapHandler(String title) {
    setState(() {
      if(!isCollapsed){
        isCollapsed = !isCollapsed;
        _animationController.reverse();
      }
    });
    if (title == "Conversion") Navigator.pushNamed(context, 'Converter');
  }
}
