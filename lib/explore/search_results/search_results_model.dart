import '/components/nav_bar/nav_bar_widget.dart';
import '/components/searchbar/searchbar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_results_widget.dart' show SearchResultsWidget;
import 'package:flutter/material.dart';

class SearchResultsModel extends FlutterFlowModel<SearchResultsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for searchbar component.
  late SearchbarModel searchbarModel;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    searchbarModel = createModel(context, () => SearchbarModel());
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    searchbarModel.dispose();
    navBarModel.dispose();
  }
}
