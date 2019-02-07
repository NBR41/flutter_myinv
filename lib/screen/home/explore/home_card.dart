import 'package:flutter/material.dart';
import '../../../service/factory.dart';
import '../../utils.dart';
import 'filters/filters.dart';
import 'home.dart';
import 'list.dart';

class FilterCard extends StatefulWidget {
  final PageCreator createPage;
  final Modeler modeler;
  final ExploreFilter filter;

  FilterCard({
    Key key,
    @required this.createPage,
    @required this.modeler,
    @required this.filter,
  }) : super(key: key);

  @override
  _FilterCardState createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var cardfilters = [widget.filter];
        cardfilters.last.list = widget.modeler.getList(cardfilters);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => widget.createPage(
                  FilterList(
                    createPage: widget.createPage,
                    modeler: widget.modeler,
                    currentFilters: cardfilters,
                  ),
                ),
          ),
        );
      },
      child: Center(
        child: Card(
          color: myColorGreen,
          elevation: 3.0,
          margin: const EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              widget.filter.txt,
              style: MYSTYLEMEDIUMBOLDWHITE,
            ),
            widthFactor: 3.0,
            heightFactor: 3.0,
          ),
        ),
      ),
    );
  }
}
