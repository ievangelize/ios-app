import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'selected_starter_widget.dart' show SelectedStarterWidget;
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SelectedStarterModel extends FlutterFlowModel<SelectedStarterWidget> {
  ///  Local state fields for this page.

  bool disliked = false;

  bool liked = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for SwipeableStack widget.
  late CardSwiperController swipeableStackController;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Icon widget.
  bool? response;

  @override
  void initState(BuildContext context) {
    swipeableStackController = CardSwiperController();
  }

  @override
  void dispose() {}
}
