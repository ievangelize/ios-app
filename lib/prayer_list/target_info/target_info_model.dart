import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'target_info_widget.dart' show TargetInfoWidget;
import 'package:flutter/material.dart';

class TargetInfoModel extends FlutterFlowModel<TargetInfoWidget> {
  ///  Local state fields for this page.

  bool? saved = false;

  bool? unsaved = false;

  bool? all = true;

  String? tags = 'all';

  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? targetInfoSupabaseStream;
  Stream<List<PrayerUpdatesRow>>? listViewSupabaseStream;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Container widget.
  bool? response;
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
