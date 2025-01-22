import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'follow_up_update_widget.dart' show FollowUpUpdateWidget;
import 'package:flutter/material.dart';

class FollowUpUpdateModel extends FlutterFlowModel<FollowUpUpdateWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '5lr4b78h' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for Phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  // State field(s) for Adrdess widget.
  FocusNode? adrdessFocusNode;
  TextEditingController? adrdessTextController;
  String? Function(BuildContext, String?)? adrdessTextControllerValidator;
  // State field(s) for Note widget.
  FocusNode? noteFocusNode;
  TextEditingController? noteTextController;
  String? Function(BuildContext, String?)? noteTextControllerValidator;
  String? _noteTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'j81as06y' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for Status widget.
  String? statusValue;
  FormFieldController<String>? statusValueController;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in DeleteBtn widget.
  bool? response;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    noteTextControllerValidator = _noteTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();

    adrdessFocusNode?.dispose();
    adrdessTextController?.dispose();

    noteFocusNode?.dispose();
    noteTextController?.dispose();
  }
}
