import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'prayer_quote_widget.dart' show PrayerQuoteWidget;
import 'package:flutter/material.dart';

class PrayerQuoteModel extends FlutterFlowModel<PrayerQuoteWidget> {
  ///  Local state fields for this page.

  String? selectedAvatar;

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
