import '/components/nav_bar/nav_bar_widget.dart';
import '/components/searchbar_dummy/searchbar_dummy_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'explore_widget.dart' show ExploreWidget;
import 'package:flutter/material.dart';

class ExploreModel extends FlutterFlowModel<ExploreWidget> {
  ///  Local state fields for this page.

  String? filterTag;

  ///  State fields for stateful widgets in this page.

  // Model for searchbarDummy component.
  late SearchbarDummyModel searchbarDummyModel;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    searchbarDummyModel = createModel(context, () => SearchbarDummyModel());
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    searchbarDummyModel.dispose();
    navBarModel.dispose();
  }
}
