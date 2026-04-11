import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'form_item_update_widget.dart' show FormItemUpdateWidget;
import 'package:flutter/material.dart';

class FormItemUpdateModel extends FlutterFlowModel<FormItemUpdateWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in formItemUpdate widget.
  List<EncounterFieldValuesRow>? encounterField;
  // State field(s) for shortAnswer widget.
  FocusNode? shortAnswerFocusNode;
  TextEditingController? shortAnswerTextController;
  String? Function(BuildContext, String?)? shortAnswerTextControllerValidator;
  // State field(s) for paragraph widget.
  FocusNode? paragraphFocusNode;
  TextEditingController? paragraphTextController;
  String? Function(BuildContext, String?)? paragraphTextControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    shortAnswerFocusNode?.dispose();
    shortAnswerTextController?.dispose();

    paragraphFocusNode?.dispose();
    paragraphTextController?.dispose();
  }
}
