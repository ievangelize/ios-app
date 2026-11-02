import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'target_saved_widget.dart' show TargetSavedWidget;
import 'package:flutter/material.dart';

class TargetSavedModel extends FlutterFlowModel<TargetSavedWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? targetSavedSupabaseStream;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
  }
}
