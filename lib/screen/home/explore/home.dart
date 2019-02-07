import 'package:flutter/material.dart';
import 'filters/filters.dart' as fi;
import '../../../service/factory.dart';
import 'home_card.dart';

typedef PageCreator = Widget Function(Widget body);

class ExploreHomePage extends StatefulWidget {
  final PageCreator createPage;
  final Modeler modeler;

  ExploreHomePage({Key key, @required this.createPage, @required this.modeler})
      : super(key: key);

  @override
  _ExploreHomePageState createState() => _ExploreHomePageState();
}

class _ExploreHomePageState extends State<ExploreHomePage> {
  List<fi.ExploreFilter> filters;

  _ExploreHomePageState() {
    filters = new List<fi.ExploreFilter>();
  }

  @override
  Widget build(BuildContext context) {
    var childs = List<Widget>();
    fi.filterRoutes[0].forEach((id) {
      childs.add(FilterCard(
        createPage: widget.createPage,
        modeler: widget.modeler,
        filter: fi.filters[id],
      ));
    });
    return GridView.count(
      primary: false,
      mainAxisSpacing: 0.0,
      padding: const EdgeInsets.all(10.0),
      crossAxisSpacing: 0.0,
      crossAxisCount: 3,
      children: childs,
    );
  }
}
