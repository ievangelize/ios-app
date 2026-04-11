import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'create_update_widget.dart' show CreateUpdateWidget;
import 'package:flutter/material.dart';

class CreateUpdateModel extends FlutterFlowModel<CreateUpdateWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Note widget.
  FocusNode? noteFocusNode;
  TextEditingController? noteTextController;
  String? Function(BuildContext, String?)? noteTextControllerValidator;
  String? _noteTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;

  @override
  void initState(BuildContext context) {
    noteTextControllerValidator = _noteTextControllerValidator;
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    noteFocusNode?.dispose();
    noteTextController?.dispose();

    largeBtnModel.dispose();
  }
}
