import '/flutter_flow/flutter_flow_util.dart';
import 'equipping_card_widget.dart' show EquippingCardWidget;
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';

class EquippingCardModel extends FlutterFlowModel<EquippingCardWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for FlippableCard widget.
  final flippableCardController = FlipCardController();
  bool flippableCardIsFront = true;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
