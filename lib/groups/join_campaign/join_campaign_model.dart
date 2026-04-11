import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'join_campaign_widget.dart' show JoinCampaignWidget;
import 'package:flutter/material.dart';

class JoinCampaignModel extends FlutterFlowModel<JoinCampaignWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  FocusNode? pinCodeFocusNode;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;
  String? _pinCodeControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Campaign code is required';
    }
    if (val.length < 6) {
      return 'Requires 6 characters.';
    }
    return null;
  }

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Backend Call - Query Rows] action in largeBtn widget.
  List<CampaignsRow>? campaign;
  // Stores action output result for [Backend Call - Query Rows] action in largeBtn widget.
  List<UserGroupsRow>? group;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
    pinCodeControllerValidator = _pinCodeControllerValidator;
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    pinCodeFocusNode?.dispose();
    pinCodeController?.dispose();

    largeBtnModel.dispose();
  }
}
