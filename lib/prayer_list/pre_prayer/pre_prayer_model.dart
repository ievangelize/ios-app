import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'pre_prayer_widget.dart' show PrePrayerWidget;
import 'package:flutter/material.dart';

class PrePrayerModel extends FlutterFlowModel<PrePrayerWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? prePrayerSupabaseStream;
  Stream<List<UsersRow>>? textSupabaseStream;
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
