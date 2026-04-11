import '/backend/supabase/supabase.dart';
import '/components/form_item_options/form_item_options_widget.dart';
import '/components/form_item_update/form_item_update_widget.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'update_encounter_campaign_widget.dart'
    show UpdateEncounterCampaignWidget;
import 'package:flutter/material.dart';

class UpdateEncounterCampaignModel
    extends FlutterFlowModel<UpdateEncounterCampaignWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Models for formItemUpdate dynamic component.
  late FlutterFlowDynamicModels<FormItemUpdateModel> formItemUpdateModels;
  // Models for formItemOptions dynamic component.
  late FlutterFlowDynamicModels<FormItemOptionsModel> formItemOptionsModels;
  // State field(s) for RadioButtonPray widget.
  FormFieldController<String>? radioButtonPrayValueController;
  // Stores action output result for [Custom Action - checkPushPermission] action in RadioButtonPray widget.
  bool? pushAllowed;
  // State field(s) for ChoiceChipsDay widget.
  FormFieldController<List<String>>? choiceChipsDayValueController;
  List<String>? get choiceChipsDayValues =>
      choiceChipsDayValueController?.value;
  set choiceChipsDayValues(List<String>? val) =>
      choiceChipsDayValueController?.value = val;
  DateTime? datePicked;
  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Custom Action - getTimeZone] action in largeBtn widget.
  String? deviceTimeZone;
  // Stores action output result for [Backend Call - Update Row(s)] action in largeBtn widget.
  List<EncounterFieldValuesRow>? updatedEncounter1;
  // Stores action output result for [Backend Call - Update Row(s)] action in largeBtn widget.
  List<EncounterFieldValuesRow>? updatedEncounter2;
  // Stores action output result for [Backend Call - Query Rows] action in largeBtn widget.
  List<EncounterFieldValuesRow>? encounterField;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Icon widget.
  bool? response;

  @override
  void initState(BuildContext context) {
    formItemUpdateModels =
        FlutterFlowDynamicModels(() => FormItemUpdateModel());
    formItemOptionsModels =
        FlutterFlowDynamicModels(() => FormItemOptionsModel());
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    formItemUpdateModels.dispose();
    formItemOptionsModels.dispose();
    largeBtnModel.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonPrayValue => radioButtonPrayValueController?.value;
}
