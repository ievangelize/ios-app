import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'conversation_starters_widget.dart' show ConversationStartersWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class ConversationStartersModel
    extends FlutterFlowModel<ConversationStartersWidget> {
  ///  Local state fields for this page.

  bool disliked = false;

  bool liked = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<XpEventsRow>? xpEvents;
  // Stores action output result for [Custom Action - calculateStreak] action in Icon widget.
  List<dynamic>? streak;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
  }

  @override
  void dispose() {}
}
