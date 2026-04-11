import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'new_friend_congrats_widget.dart' show NewFriendCongratsWidget;
import 'package:flutter/material.dart';

class NewFriendCongratsModel extends FlutterFlowModel<NewFriendCongratsWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? newFriendCongratsSupabaseStream;
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
