import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'add_friend_widget.dart' show AddFriendWidget;
import 'package:flutter/material.dart';

class AddFriendModel extends FlutterFlowModel<AddFriendWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for friendCode widget.
  FocusNode? friendCodeFocusNode;
  TextEditingController? friendCodeTextController;
  String? Function(BuildContext, String?)? friendCodeTextControllerValidator;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Backend Call - Query Rows] action in largeBtn widget.
  List<UsersRow>? friend;

  @override
  void initState(BuildContext context) {
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    friendCodeFocusNode?.dispose();
    friendCodeTextController?.dispose();

    largeBtnModel.dispose();
  }
}
