import 'package:flutter/material.dart';
import '../../../service/factory.dart';
import '../../utils.dart';
import '../tabs.dart';
import 'filters/filters.dart' as fi;

class FilterList extends StatefulWidget {
  final PageCreator createPage;
  final Modeler modeler;
  final List<fi.ExploreFilter> currentFilters;

  FilterList(
      {Key key,
      @required this.createPage,
      @required this.modeler,
      @required this.currentFilters})
      : super(key: key);

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  List<fi.ExploreFilter> nextFilters;

  @override
  initState() {
    int filterKey = 0;
    widget.currentFilters.forEach((filter) {
      filterKey |= filter.id;
    });
    nextFilters = [];
    if (filterKey > 0 && fi.filterRoutes.containsKey(filterKey)) {
      fi.filterRoutes[filterKey].forEach((id) {
        fi.filters[id].resetFilter();
        nextFilters.add(fi.filters[id]);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<fi.DynamicFilter>>(
        future: widget.currentFilters.last.list,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _getList(context, snapshot.data);
          } else if (snapshot.hasError) {
            return WarningScreen(txt: snapshot.error);
          }
          // By default, show a loading spinner
          return const LoadingScreen(txt: "Loading List");
        },
      ),
    );
  }

  Widget _getList(BuildContext context, List<fi.DynamicFilter> list) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getListTitle(),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: list.length,
              itemBuilder: (context, i) {
                return ExpansionTile(
                    title: Text(
                      list[i].getFullName(),
                      style: BIGGERFONT,
                    ),
                    children: [
                      Wrap(
                        spacing: 5.0,
                        runSpacing: 1.0,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: _getExploreFilterList(context, list[i]),
                      )
                    ]);
              }),
        ),
      ],
    );
  }

  Widget _getListTitle() {
    String txt = '';
    widget.currentFilters.forEach((cf) {
      if (cf.filter == null) {
        txt += (txt == '') ? cf.txt : ' > ' + cf.txt;
      } else {
        txt += (txt == '') ? cf.filter.getName() : ' > ' + cf.filter.getName();
      }
    });
    return Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            txt,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          )
        ]);
  }

  List<Widget> _getExploreFilterList(
      BuildContext context, fi.DynamicFilter val) {
    List<Widget> ret = [];
    nextFilters.forEach((ef) {
      ret.add(_getExploreFilter(context, val, ef));
    });
    return ret;
  }

  Widget _getExploreFilter(
      BuildContext context, fi.DynamicFilter f, fi.ExploreFilter ef) {
    return GestureDetector(
      onTap: () {
        var newFilterList = widget.currentFilters;
        newFilterList.last.filter = f;
        newFilterList.add(ef);
        newFilterList.last.list = widget.modeler.getList(newFilterList);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => widget.createPage(
                  FilterList(
                    createPage: widget.createPage,
                    modeler: widget.modeler,
                    currentFilters: newFilterList,
                  ),
                ),
          ),
        );
      },
      child: Chip(label: Text(ef.txt)),
    );
  }
}
