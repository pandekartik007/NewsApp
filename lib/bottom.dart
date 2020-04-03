import 'package:flutter/material.dart';
import './views/homepage.dart';
import './views/categoriesScreen.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> with SingleTickerProviderStateMixin{
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: new Material(
            color: Colors.blue[600],
            child: new TabBar(controller: controller, tabs: <Tab>[
              new Tab(icon: new Icon(Icons.view_headline, size: 30.0)),
              new Tab(icon: new Icon(Icons.explore, size: 30.0)),
            ])),
        body: new TabBarView(controller: controller, children: <Widget>[
          new HomePage(),
          new CategoriesScreen(),
        ]));
  }
}
