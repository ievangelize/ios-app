import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'form_item_options_model.dart';
export 'form_item_options_model.dart';

class FormItemOptionsWidget extends StatefulWidget {
  const FormItemOptionsWidget({
    super.key,
    required this.formField,
    required this.encounter,
    required this.changePageState,
  });

  final FormFieldsRow? formField;
  final ReachedRow? encounter;
  final Future Function(List<String> fieldOptionIDs)? changePageState;

  @override
  State<FormItemOptionsWidget> createState() => _FormItemOptionsWidgetState();
}

class _FormItemOptionsWidgetState extends State<FormItemOptionsWidget> {
  late FormItemOptionsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FormItemOptionsModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.encounterField = await EncounterFieldValuesTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'encounter_id',
              widget.encounter?.id,
            )
            .eqOrNull(
              'form_field_id',
              widget.formField?.id,
            ),
      );
      _model.fieldOption = await FieldOptionsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'form_field_id',
              widget.formField?.id,
            )
            .eqOrNull(
              'label',
              widget.formField?.label,
            ),
      );
      _model.encounterFieldOption =
          await EncounterFieldValueOptionsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'encounter_field_value_id',
              _model.encounterField?.firstOrNull?.id,
            )
            .eqOrNull(
              'field_option_id',
              _model.fieldOption?.firstOrNull?.id,
            ),
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          valueOrDefault<String>(
            widget.formField?.label,
            'Multiple Choice',
          ),
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
                fontSize: 16.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
              ),
        ),
        FutureBuilder<List<FieldOptionsRow>>(
          future: FieldOptionsTable().queryRows(
            queryFn: (q) => q.eqOrNull(
              'form_field_id',
              widget.formField?.formId,
            ),
          ),
          builder: (context, snapshot) {
            // Customize what your widget looks like when it's loading.
            if (!snapshot.hasData) {
              return Center(
                child: SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: SpinKitFadingCircle(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 20.0,
                  ),
                ),
              );
            }
            List<FieldOptionsRow> dropDownFieldOptionsRowList = snapshot.data!;

            return FlutterFlowDropDown<String>(
              multiSelectController: _model.dropDownValueController ??=
                  FormListFieldController<String>(
                      _model.dropDownValue ??= List<String>.from(
                dropDownFieldOptionsRowList
                        .where((e) =>
                            e.id ==
                            _model.encounterFieldOption?.firstOrNull
                                ?.fieldOptionId)
                        .toList()
                        .map((e) => e.label)
                        .withoutNulls
                        .toList() ??
                    [],
              )),
              options: List<String>.from(
                  dropDownFieldOptionsRowList.map((e) => e.id).toList()),
              optionLabels: dropDownFieldOptionsRowList
                  .map((e) => e.label)
                  .withoutNulls
                  .toList(),
              width: 200.0,
              height: 40.0,
              textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
              hintText: 'Select...',
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24.0,
              ),
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              elevation: 2.0,
              borderColor: Colors.transparent,
              borderWidth: 0.0,
              borderRadius: 8.0,
              margin: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
              hidesUnderline: true,
              isOverButton: false,
              isSearchable: false,
              isMultiSelect: true,
              onMultiSelectChanged: (val) =>
                  safeSetState(() => _model.dropDownValue = val),
            );
          },
        ),
      ].divide(SizedBox(height: 10.0)),
    );
  }
}
