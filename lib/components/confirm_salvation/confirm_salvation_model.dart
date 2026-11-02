import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_salvation_widget.dart' show ConfirmSalvationWidget;
import 'package:flutter/material.dart';

class ConfirmSalvationModel extends FlutterFlowModel<ConfirmSalvationWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Backend Call - Insert Row] action in largeBtn widget.
  ReachedRow? newReached;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    largeBtnModel.dispose();
  }
}
