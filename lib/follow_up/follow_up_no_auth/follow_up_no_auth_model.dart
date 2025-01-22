import '/components/list_empty/list_empty_widget.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'follow_up_no_auth_widget.dart' show FollowUpNoAuthWidget;
import 'package:flutter/material.dart';

class FollowUpNoAuthModel extends FlutterFlowModel<FollowUpNoAuthWidget> {
  ///  Local state fields for this page.

  bool? saved = false;

  bool? unsaved = false;

  bool? all = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Model for listEmpty component.
  late ListEmptyModel listEmptyModel;
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    listEmptyModel = createModel(context, () => ListEmptyModel());
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();

    listEmptyModel.dispose();
    navBarModel.dispose();
  }
}
