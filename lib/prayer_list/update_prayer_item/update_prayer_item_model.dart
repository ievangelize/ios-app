import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'update_prayer_item_widget.dart' show UpdatePrayerItemWidget;
import 'package:flutter/material.dart';

class UpdatePrayerItemModel extends FlutterFlowModel<UpdatePrayerItemWidget> {
  ///  Local state fields for this page.

  int? stage;

  String? selectedAvatar;

  ///  State fields for stateful widgets in this page.

  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();
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

  // State field(s) for Location widget.
  FocusNode? locationFocusNode;
  TextEditingController? locationTextController;
  String? Function(BuildContext, String?)? locationTextControllerValidator;
  String? _locationTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for Description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Model for largeBtn component.
  late LargeBtnModel largeBtnModel;
  // Stores action output result for [Backend Call - API (Prayer AI)] action in largeBtn widget.
  ApiCallResponse? apiResultzqy;
  // Stores action output result for [Backend Call - Update Row(s)] action in largeBtn widget.
  List<PrayerTargetsRow>? target;
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Icon widget.
  bool? response;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    locationTextControllerValidator = _locationTextControllerValidator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
    largeBtnModel = createModel(context, () => LargeBtnModel());
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    locationFocusNode?.dispose();
    locationTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    largeBtnModel.dispose();
  }
}
