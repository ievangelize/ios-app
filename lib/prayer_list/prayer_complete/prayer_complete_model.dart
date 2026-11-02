import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'prayer_complete_widget.dart' show PrayerCompleteWidget;
import 'package:flutter/material.dart';

class PrayerCompleteModel extends FlutterFlowModel<PrayerCompleteWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? prayerCompleteSupabaseStream;
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
