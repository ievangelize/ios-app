import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'situation_widget.dart' show SituationWidget;
import 'package:flutter/material.dart';

class SituationModel extends FlutterFlowModel<SituationWidget> {
  ///  Local state fields for this page.

  bool btnClicked = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for SituationInfo widget.
  FocusNode? situationInfoFocusNode;
  TextEditingController? situationInfoTextController;
  String? Function(BuildContext, String?)? situationInfoTextControllerValidator;
  String? _situationInfoTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '0dmatc6r' /* Field is required */,
      );
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (OpenAI API)] action in IconButton widget.
  ApiCallResponse? apiOutput;
  // Stores action output result for [Backend Call - Insert Row] action in IconButton widget.
  SituationRow? newSituation;
  // Model for NavBar component.
  late NavBarModel navBarModel;
  // State field(s) for Search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;

  @override
  void initState(BuildContext context) {
    situationInfoTextControllerValidator =
        _situationInfoTextControllerValidator;
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    situationInfoFocusNode?.dispose();
    situationInfoTextController?.dispose();

    navBarModel.dispose();
    searchFocusNode?.dispose();
    searchTextController?.dispose();
  }
}
