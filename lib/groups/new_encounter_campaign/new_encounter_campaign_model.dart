import '/backend/supabase/supabase.dart';
import '/components/form_item/form_item_widget.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'new_encounter_campaign_widget.dart' show NewEncounterCampaignWidget;
import 'package:flutter/material.dart';

class NewEncounterCampaignModel
    extends FlutterFlowModel<NewEncounterCampaignWidget> {
  ///  Local state fields for this page.

  bool addNotification = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for EncounterNumber widget.
  FocusNode? encounterNumberFocusNode;
  TextEditingController? encounterNumberTextController;
  String? Function(BuildContext, String?)?
      encounterNumberTextControllerValidator;
  // Models for formItem dynamic component.
  late FlutterFlowDynamicModels<FormItemModel> formItemModels;
  // State field(s) for RadioButtonPray widget.
  FormFieldController<String>? radioButtonPrayValueController;
  // State field(s) for ChoiceChipsDay widget.
  FormFieldController<List<String>>? choiceChipsDayValueController;
  List<String>? get choiceChipsDayValues =>
      choiceChipsDayValueController?.value;
  set choiceChipsDayValues(List<String>? val) =>
      choiceChipsDayValueController?.value = val;
  DateTime? datePicked;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Custom Action - checkPushPermission] action in largeBtn widget.
  bool? pushAllowed;
  // Stores action output result for [Backend Call - Insert Row] action in largeBtn widget.
  ReachedRow? encounter;
  // Stores action output result for [Custom Action - getTimeZone] action in largeBtn widget.
  String? deviceTimeZone;
  // Stores action output result for [Backend Call - Insert Row] action in largeBtn widget.
  EncounterFieldValuesRow? newEncounter2;
  // Stores action output result for [Backend Call - Insert Row] action in largeBtn widget.
  EncounterFieldValuesRow? newEncounter3;
  // Stores action output result for [Backend Call - Insert Row] action in largeBtn widget.
  EncounterFieldValuesRow? newEncounter1;

  @override
  void initState(BuildContext context) {
    formItemModels = FlutterFlowDynamicModels(() => FormItemModel());
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    encounterNumberFocusNode?.dispose();
    encounterNumberTextController?.dispose();

    formItemModels.dispose();
    largeBtnModel.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonPrayValue => radioButtonPrayValueController?.value;
}
