import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'encounter_update_widget.dart' show EncounterUpdateWidget;
import 'package:flutter/material.dart';

class EncounterUpdateModel extends FlutterFlowModel<EncounterUpdateWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for Phone widget.
  FocusNode? phoneFocusNode;
  TextEditingController? phoneTextController;
  String? Function(BuildContext, String?)? phoneTextControllerValidator;
  // State field(s) for Email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  // State field(s) for Address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressTextController;
  String? Function(BuildContext, String?)? addressTextControllerValidator;
  // State field(s) for Note widget.
  FocusNode? noteFocusNode;
  TextEditingController? noteTextController;
  String? Function(BuildContext, String?)? noteTextControllerValidator;
  String? _noteTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for RadioButtonBornAgain widget.
  FormFieldController<String>? radioButtonBornAgainValueController;
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
  String? deviceTimeZoneUpdate;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Icon widget.
  bool? response;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    noteTextControllerValidator = _noteTextControllerValidator;
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    phoneFocusNode?.dispose();
    phoneTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    noteFocusNode?.dispose();
    noteTextController?.dispose();

    largeBtnModel.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonBornAgainValue =>
      radioButtonBornAgainValueController?.value;
  String? get radioButtonPrayValue => radioButtonPrayValueController?.value;
}
