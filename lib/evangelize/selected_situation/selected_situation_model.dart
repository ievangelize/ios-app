import '/flutter_flow/flutter_flow_util.dart';
import 'selected_situation_widget.dart' show SelectedSituationWidget;
import 'package:flutter/material.dart';

class SelectedSituationModel extends FlutterFlowModel<SelectedSituationWidget> {
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
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Button widget.
  bool? response;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
