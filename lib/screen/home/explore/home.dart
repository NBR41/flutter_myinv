import 'package:flutter/material.dart';
import 'filters/filters.dart' as fi;
import '../../../service/factory.dart';
import '../tabs.dart';
import 'home_card.dart';
import 'list.dart';

class ExplorePage extends StatefulWidget {
  final PageCreator createPage;
  final Modeler modeler;

  ExplorePage({Key key, @required this.createPage, @required this.modeler})
      : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<fi.ExploreFilter> filters;

  _ExplorePageState() {
    filters = new List<fi.ExploreFilter>();
  }

  @override
  Widget build(BuildContext context) {
    if (filters.length == 0) {
      return _getHome();
    }
    return FilterList(
        createPage: widget.createPage,
        modeler: widget.modeler,
        currentFilters: filters);
  }

  Widget _getHome() {
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
      padding: const EdgeInsets.all(10.0),
      crossAxisSpacing: 10.0,
      crossAxisCount: 3,
      children: childs,
    );
  }
}
