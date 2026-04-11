import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'form_item_options_widget.dart' show FormItemOptionsWidget;
import 'package:flutter/material.dart';

class FormItemOptionsModel extends FlutterFlowModel<FormItemOptionsWidget> {
  ///  Local state fields for this component.

  List<String> fieldOptionIds = [];
  void addToFieldOptionIds(String item) => fieldOptionIds.add(item);
  void removeFromFieldOptionIds(String item) => fieldOptionIds.remove(item);
  void removeAtIndexFromFieldOptionIds(int index) =>
      fieldOptionIds.removeAt(index);
  void insertAtIndexInFieldOptionIds(int index, String item) =>
      fieldOptionIds.insert(index, item);
  void updateFieldOptionIdsAtIndex(int index, Function(String) updateFn) =>
      fieldOptionIds[index] = updateFn(fieldOptionIds[index]);

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - Query Rows] action in formItemOptions widget.
  List<EncounterFieldValuesRow>? encounterField;
  // Stores action output result for [Backend Call - Query Rows] action in formItemOptions widget.
  List<FieldOptionsRow>? fieldOption;
  // Stores action output result for [Backend Call - Query Rows] action in formItemOptions widget.
  List<EncounterFieldValueOptionsRow>? encounterFieldOption;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
