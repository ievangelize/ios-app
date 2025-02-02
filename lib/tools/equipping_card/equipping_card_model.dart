import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'equipping_card_widget.dart' show EquippingCardWidget;
import 'package:flutter/material.dart';

class EquippingCardModel extends FlutterFlowModel<EquippingCardWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    navBarModel.dispose();
  }
}
