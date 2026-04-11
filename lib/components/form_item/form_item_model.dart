import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'form_item_widget.dart' show FormItemWidget;
import 'package:flutter/material.dart';

class FormItemModel extends FlutterFlowModel<FormItemWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for shortAnswer widget.
  FocusNode? shortAnswerFocusNode;
  TextEditingController? shortAnswerTextController;
  String? Function(BuildContext, String?)? shortAnswerTextControllerValidator;
  // State field(s) for paragraph widget.
  FocusNode? paragraphFocusNode;
  TextEditingController? paragraphTextController;
  String? Function(BuildContext, String?)? paragraphTextControllerValidator;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;
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
