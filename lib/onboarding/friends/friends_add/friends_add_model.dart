import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'friends_add_widget.dart' show FriendsAddWidget;
import 'package:flutter/material.dart';

class FriendsAddModel extends FlutterFlowModel<FriendsAddWidget> {
  ///  Local state fields for this page.

  String shareMessage =
      'Hey, check out this evangelism app I’ve been using, iEvangelize. When you join, use my code so we can become friends on the app and grow together in evangelism.\n\nMy code: ';

  String downloadMessage =
      '\nDownload link: https://link.ievangelize.app/aFij/download';

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
