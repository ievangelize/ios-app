import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'category_horizontal_widget.dart' show CategoryHorizontalWidget;
import 'package:flutter/material.dart';

class CategoryHorizontalModel
    extends FlutterFlowModel<CategoryHorizontalWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    navBarModel.dispose();
  }
}
