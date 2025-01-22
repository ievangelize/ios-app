import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'searchbar_dummy_model.dart';
export 'searchbar_dummy_model.dart';

class SearchbarDummyWidget extends StatefulWidget {
  const SearchbarDummyWidget({super.key});

  @override
  State<SearchbarDummyWidget> createState() => _SearchbarDummyWidgetState();
}

class _SearchbarDummyWidgetState extends State<SearchbarDummyWidget> {
  late SearchbarDummyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchbarDummyModel());

    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();
    _model.searchFocusNode!.addListener(
      () async {
        context.pushNamed(
          'SearchResults',
          queryParameters: {
            'initialSearch': serializeParam(
              _model.searchTextController.text,
              ParamType.String,
            ),
          }.withoutNulls,
        );
      },
    );
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
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
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
                    textInputAction: TextInputAction.done,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      alignLabelWithHint: false,
                      hintText: FFLocalizations.of(context).getText(
                        'c06w0oy7' /* Search */,
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
        FutureBuilder<List<FilterTagsRow>>(
          future: FFAppState().tags(
            requestFn: () => FilterTagsTable().queryRows(
              queryFn: (q) => q.order('order', ascending: true),
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
            List<FilterTagsRow> rowFilterTagsRowList = snapshot.data!;

            return Row(
              mainAxisSize: MainAxisSize.max,
              children: List.generate(rowFilterTagsRowList.length, (rowIndex) {
                final rowFilterTagsRow = rowFilterTagsRowList[rowIndex];
                return InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    context.pushNamed(
                      'SearchResults',
                      queryParameters: {
                        'initialSearch': serializeParam(
                          _model.searchTextController.text,
                          ParamType.String,
                        ),
                        'initialChoiceChip': serializeParam(
                          rowFilterTagsRow.name,
                          ParamType.String,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).accent2,
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(12.0, 8.0, 12.0, 8.0),
                      child: Text(
                        valueOrDefault<String>(
                          rowFilterTagsRow.name,
                          'Tag name',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                );
              })
                  .divide(const SizedBox(width: 8.0))
                  .addToStart(const SizedBox(width: 16.0))
                  .addToEnd(const SizedBox(width: 16.0)),
            );
          },
        ),
      ],
    );
  }
}
