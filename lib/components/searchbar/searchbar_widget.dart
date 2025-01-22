import '/backend/supabase/supabase.dart';
import '/components/tags_loading/tags_loading_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'searchbar_model.dart';
export 'searchbar_model.dart';

class SearchbarWidget extends StatefulWidget {
  const SearchbarWidget({
    super.key,
    this.initialKeyword,
    this.initialChip,
  });

  final String? initialKeyword;
  final String? initialChip;

  @override
  State<SearchbarWidget> createState() => _SearchbarWidgetState();
}

class _SearchbarWidgetState extends State<SearchbarWidget> {
  late SearchbarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchbarModel());

    _model.searchTextController ??=
        TextEditingController(text: widget.initialKeyword);
    _model.searchFocusNode ??= FocusNode();
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
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).accent2,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
                  child: Icon(
                    Icons.search,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24.0,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _model.searchTextController,
                    focusNode: _model.searchFocusNode,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.searchTextController',
                      const Duration(milliseconds: 1000),
                      () => safeSetState(() {}),
                    ),
                    autofocus: false,
                    textCapitalization: TextCapitalization.none,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      alignLabelWithHint: false,
                      hintText: FFLocalizations.of(context).getText(
                        'htzcu2vf' /* Search */,
                      ),
                      hintStyle: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'Inter',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.normal,
                          ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding:
                          const EdgeInsetsDirectional.fromSTEB(4.0, 12.0, 8.0, 12.0),
                      suffixIcon: _model.searchTextController!.text.isNotEmpty
                          ? InkWell(
                              onTap: () async {
                                _model.searchTextController?.clear();
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 20.0,
                              ),
                            )
                          : null,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.normal,
                        ),
                    maxLines: null,
                    validator: _model.searchTextControllerValidator
                        .asValidator(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: FutureBuilder<List<FilterTagsRow>>(
                  future: FFAppState().tags(
                    requestFn: () => FilterTagsTable().queryRows(
                      queryFn: (q) => q.order('order', ascending: true),
                    ),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return const TagsLoadingWidget();
                    }
                    List<FilterTagsRow> choiceChipsFilterTagsRowList =
                        snapshot.data!;

                    return FlutterFlowChoiceChips(
                      options: choiceChipsFilterTagsRowList
                          .map((e) => e.name)
                          .withoutNulls
                          .toList()
                          .map((label) => ChipData(label))
                          .toList(),
                      onChanged: (val) async {
                        safeSetState(
                            () => _model.choiceChipsValue = val?.firstOrNull);
                        safeSetState(() {
                          _model.searchTextController?.text =
                              _model.choiceChipsValue!;
                        });
                      },
                      selectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.of(context).secondary,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Inter',
                                  color: FlutterFlowTheme.of(context).info,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                        iconColor: FlutterFlowTheme.of(context).info,
                        iconSize: 16.0,
                        labelPadding:
                            const EdgeInsetsDirectional.fromSTEB(8.0, 1.0, 8.0, 1.0),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.of(context).accent2,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                        iconColor: FlutterFlowTheme.of(context).secondaryText,
                        iconSize: 16.0,
                        labelPadding:
                            const EdgeInsetsDirectional.fromSTEB(8.0, 1.0, 8.0, 1.0),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      chipSpacing: 8.0,
                      rowSpacing: 8.0,
                      multiselect: false,
                      alignment: WrapAlignment.start,
                      controller: _model.choiceChipsValueController ??=
                          FormFieldController<List<String>>(
                        [],
                      ),
                      wrapped: true,
                    );
                  },
                ),
              ),
            ].addToStart(const SizedBox(width: 16.0)).addToEnd(const SizedBox(width: 16.0)),
          ),
        ),
      ],
    );
  }
}
