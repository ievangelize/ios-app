import '/backend/supabase/supabase.dart';
import '/components/nav_bar/nav_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/index.dart';
import 'prayer_list_widget.dart' show PrayerListWidget;
import 'package:flutter/material.dart';

class PrayerListModel extends FlutterFlowModel<PrayerListWidget> {
  ///  Local state fields for this page.

  bool? saved = false;

  bool? unsaved = false;

  bool? all = true;

  String? tags = 'all';

  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? prayerListSupabaseStream;
  // State field(s) for Search widget.
  FocusNode? searchFocusNode;
  TextEditingController? searchTextController;
  String? Function(BuildContext, String?)? searchTextControllerValidator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // Model for NavBar component.
  late NavBarModel navBarModel;

  @override
  void initState(BuildContext context) {
    navBarModel = createModel(context, () => NavBarModel());
  }

  @override
  void dispose() {
    searchFocusNode?.dispose();
    searchTextController?.dispose();

    navBarModel.dispose();
  }
}
