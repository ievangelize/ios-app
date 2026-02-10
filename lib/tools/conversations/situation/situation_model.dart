import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'situation_widget.dart' show SituationWidget;
import 'package:flutter/material.dart';

class SituationModel extends FlutterFlowModel<SituationWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for SituationInfo widget.
  FocusNode? situationInfoFocusNode;
  TextEditingController? situationInfoTextController;
  String? Function(BuildContext, String?)? situationInfoTextControllerValidator;
  String? _situationInfoTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Model for NavBar component.
  late NavBarModel navBarModel;

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
  }
}
