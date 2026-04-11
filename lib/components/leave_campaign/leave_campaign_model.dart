import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'leave_campaign_widget.dart' show LeaveCampaignWidget;
import 'package:flutter/material.dart';

class LeaveCampaignModel extends FlutterFlowModel<LeaveCampaignWidget> {
  ///  State fields for stateful widgets in this component.

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
