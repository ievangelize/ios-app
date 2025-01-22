import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'horizontal_video_player_widget.dart' show HorizontalVideoPlayerWidget;
import 'package:flutter/material.dart';

class HorizontalVideoPlayerModel
    extends FlutterFlowModel<HorizontalVideoPlayerWidget> {
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
