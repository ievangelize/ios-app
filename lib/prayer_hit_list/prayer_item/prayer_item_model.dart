import '/backend/supabase/supabase.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'prayer_item_widget.dart' show PrayerItemWidget;
import 'package:flutter/material.dart';

class PrayerItemModel extends FlutterFlowModel<PrayerItemWidget> {
  ///  Local state fields for this page.

  bool? saved = false;

  bool? unsaved = false;

  bool? all = true;

  String? tags = 'all';

  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? prayerItemSupabaseStream;
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
