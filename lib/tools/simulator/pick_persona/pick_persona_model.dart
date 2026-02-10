import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pick_persona_widget.dart' show PickPersonaWidget;
import 'package:flutter/material.dart';

class PickPersonaModel extends FlutterFlowModel<PickPersonaWidget> {
  ///  Local state fields for this page.

  String? persona;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
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
