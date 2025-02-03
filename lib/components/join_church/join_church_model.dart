import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'join_church_widget.dart' show JoinChurchWidget;
import 'package:flutter/material.dart';

class JoinChurchModel extends FlutterFlowModel<JoinChurchWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for CodeField widget.
  FocusNode? codeFieldFocusNode;
  TextEditingController? codeFieldTextController;
  String? Function(BuildContext, String?)? codeFieldTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<ChurchesRow>? foundChurch;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    codeFieldFocusNode?.dispose();
    codeFieldTextController?.dispose();
  }
}
