import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/components/streak/streak_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'feedback_model.dart';
export 'feedback_model.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({
    super.key,
    required this.chatFeedback,
  });

  final String? chatFeedback;

  static String routeName = 'feedback';
  static String routePath = 'feedback';

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  late FeedbackModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FeedbackModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'feedback'});
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (context) => FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.close,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 25.0,
              ),
              onPressed: () async {
                unawaited(
                  () async {
                    await XpEventsTable().insert({
                      'user_id': currentUserUid,
                      'delta': 10,
                      'reason': 'ai simulator',
                      'idempotency_key': random_data.randomString(
                        16,
                        16,
                        true,
                        true,
                        true,
                      ),
                    });
                  }(),
                );
                _model.xpEvents2 = await XpEventsTable().queryRows(
                  queryFn: (q) => q.eqOrNull(
                    'user_id',
                    currentUserUid,
                  ),
                );
                _model.streak2 = await actions.calculateStreak(
                  _model.xpEvents2!.map((e) => e.createdAt).toList(),
                  FFAppState().currentStreak,
                );
                if (getJsonField(
                  _model.streak2!.lastOrNull,
                  r'''$.is_streak''',
                )) {
                  FFAppState().currentStreak = getJsonField(
                    _model.streak2!.elementAtOrNull(1),
                    r'''$.streak''',
                  );
                  await showDialog(
                    barrierColor:
                        FlutterFlowTheme.of(context).primaryBackground,
                    barrierDismissible: false,
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: AlignmentDirectional(0.0, 0.0)
                            .resolve(Directionality.of(context)),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(dialogContext).unfocus();
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: StreakWidget(
                              streakAmount: getJsonField(
                                _model.streak2?.elementAtOrNull(1),
                                r'''$.streak''',
                              ).toString(),
                              streakDays: getJsonField(
                                _model.streak2?.firstOrNull,
                                r'''$.active_days''',
                                true,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                context.goNamed(PickPersonaWidget.routeName);

                safeSetState(() {});
              },
            ),
          ),
          title: Text(
            'Feedback',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 32.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        custom_widgets.CustomMarkdown(
                          width: double.infinity,
                          height: 50.0,
                          fontSize: 16.0,
                          textColor: FlutterFlowTheme.of(context).primaryText,
                          blockquoteBackground:
                              FlutterFlowTheme.of(context).blackAlternate,
                          blockquoteTextColor:
                              FlutterFlowTheme.of(context).primaryText,
                          data: widget.chatFeedback!,
                        ),
                      ].addToEnd(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (context) => Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 12.0),
                  child: wrapWithModel(
                    model: _model.largeBtnModel,
                    updateCallback: () => safeSetState(() {}),
                    child: LargeBtnWidget(
                      text: 'Done',
                      color: FlutterFlowTheme.of(context).secondary,
                      textColor: FlutterFlowTheme.of(context).info,
                      action: () async {
                        unawaited(
                          () async {
                            await XpEventsTable().insert({
                              'user_id': currentUserUid,
                              'delta': 0,
                              'reason': 'ai simulator',
                              'idempotency_key': random_data.randomString(
                                16,
                                16,
                                true,
                                true,
                                true,
                              ),
                            });
                          }(),
                        );
                        _model.xpEvents = await XpEventsTable().queryRows(
                          queryFn: (q) => q.eqOrNull(
                            'user_id',
                            currentUserUid,
                          ),
                        );
                        _model.streak = await actions.calculateStreak(
                          _model.xpEvents!.map((e) => e.createdAt).toList(),
                          FFAppState().currentStreak,
                        );
                        if (getJsonField(
                          _model.streak!.lastOrNull,
                          r'''$.is_streak''',
                        )) {
                          await showDialog(
                            barrierColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            barrierDismissible: false,
                            context: context,
                            builder: (dialogContext) {
                              return Dialog(
                                elevation: 0,
                                insetPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                alignment: AlignmentDirectional(0.0, 0.0)
                                    .resolve(Directionality.of(context)),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(dialogContext).unfocus();
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    child: StreakWidget(
                                      streakAmount: getJsonField(
                                        _model.streak?.elementAtOrNull(1),
                                        r'''$.streak''',
                                      ).toString(),
                                      streakDays: getJsonField(
                                        _model.streak?.firstOrNull,
                                        r'''$.active_days''',
                                        true,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );

                          FFAppState().currentStreak = getJsonField(
                            _model.streak!.elementAtOrNull(1),
                            r'''$.streak''',
                          );
                          FFAppState().activeDays = getJsonField(
                            _model.streak!.firstOrNull,
                            r'''$.active_days''',
                            true,
                          )!
                              .toList()
                              .cast<dynamic>();
                          await UsersTable().update(
                            data: {
                              'streak': FFAppState().currentStreak,
                            },
                            matchingRows: (rows) => rows.eqOrNull(
                              'id',
                              currentUserUid,
                            ),
                          );
                        }

                        context.goNamed(PickPersonaWidget.routeName);

                        safeSetState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
