import '/flutter_flow/flutter_flow_util.dart';
import 'new_situation_widget.dart' show NewSituationWidget;
import 'package:flutter/material.dart';

class NewSituationModel extends FlutterFlowModel<NewSituationWidget> {
  ///  Local state fields for this page.

  bool disliked = false;

  bool liked = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
