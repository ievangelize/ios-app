import '/flutter_flow/flutter_flow_util.dart';
import 'searchbar_dummy_widget.dart' show SearchbarDummyWidget;
import 'package:flutter/material.dart';

class SearchbarDummyModel extends FlutterFlowModel<SearchbarDummyWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();
  }
}
