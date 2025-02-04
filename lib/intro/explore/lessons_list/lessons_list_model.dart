import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lessons_list_widget.dart' show LessonsListWidget;
import 'package:flutter/material.dart';

class LessonsListModel extends FlutterFlowModel<LessonsListWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for Search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();

    navBarModel.dispose();
  }
}
