import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'equipping_card_widget.dart' show EquippingCardWidget;
import 'package:flutter/material.dart';

class EquippingCardModel extends FlutterFlowModel<EquippingCardWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<XpEventsRow>? xpEvents;
  // Stores action output result for [Custom Action - calculateStreak] action in Icon widget.
  List<dynamic>? streak;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
