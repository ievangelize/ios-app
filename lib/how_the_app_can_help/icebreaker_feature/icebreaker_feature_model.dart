import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'icebreaker_feature_widget.dart' show IcebreakerFeatureWidget;
import 'package:flutter/material.dart';

class IcebreakerFeatureModel extends FlutterFlowModel<IcebreakerFeatureWidget> {
  ///  Local state fields for this page.

  double rotation = 25.0;

  double translation = 100.0;

  ///  State fields for stateful widgets in this page.

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
