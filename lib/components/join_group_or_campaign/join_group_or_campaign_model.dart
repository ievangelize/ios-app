import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'join_group_or_campaign_widget.dart' show JoinGroupOrCampaignWidget;
import 'package:flutter/material.dart';

class JoinGroupOrCampaignModel
    extends FlutterFlowModel<JoinGroupOrCampaignWidget> {
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
