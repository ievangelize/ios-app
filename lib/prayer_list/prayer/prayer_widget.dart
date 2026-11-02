import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'prayer_model.dart';
export 'prayer_model.dart';

class PrayerWidget extends StatefulWidget {
  const PrayerWidget({
    super.key,
    required this.target,
    required this.user,
  });

  final PrayerTargetsRow? target;
  final UsersRow? user;

  static String routeName = 'prayer';
  static String routePath = 'prayer';

  @override
  State<PrayerWidget> createState() => _PrayerWidgetState();
}

class _PrayerWidgetState extends State<PrayerWidget> {
  late PrayerModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PrayerModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'prayer'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.queuePositiion = widget.user?.currentQueuePosition;
      safeSetState(() {});
    });
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
          leading: FlutterFlowIconButton(
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
              context.safePop();
            },
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 36.0, 16.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        custom_widgets.StreamingMarkdownText(
                          width: double.infinity,
                          height: 50.0,
                          text: widget.target!.prayer!,
                          fontSize: 24.0,
                          textColor: FlutterFlowTheme.of(context).primaryText,
                          markdownFontSize: 24.0,
                          markdownColor:
                              FlutterFlowTheme.of(context).primaryText,
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 0.99),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 12.0),
                  child: wrapWithModel(
                    model: _model.largeBtnModel,
                    updateCallback: () => safeSetState(() {}),
                    child: LargeBtnWidget(
                      text: 'I\'ve prayed',
                      color: FlutterFlowTheme.of(context).secondary,
                      textColor: FlutterFlowTheme.of(context).info,
                      action: () async {
                        _model.queuePositiion = _model.queuePositiion! + 1;
                        safeSetState(() {});
                        await UsersTable().update(
                          data: {
                            'current_queue_position': _model.queuePositiion,
                          },
                          matchingRows: (rows) => rows.eqOrNull(
                            'id',
                            currentUserUid,
                          ),
                        );
                        await PrayerTargetsTable().update(
                          data: {
                            'prayed': true,
                            'last_prayed_at':
                                supaSerialize<DateTime>(getCurrentTimestamp),
                          },
                          matchingRows: (rows) => rows
                              .eqOrNull(
                                'id',
                                widget.target?.id,
                              )
                              .eqOrNull(
                                'user_id',
                                currentUserUid,
                              ),
                        );
                        unawaited(
                          () async {
                            await XpEventsTable().insert({
                              'user_id': currentUserUid,
                              'delta': 20,
                              'reason': 'prayer',
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
                        await action_blocks.calculateStreak(context);
                        _model.apiResultewm =
                            await SendPushNotificationCall.call(
                          supabaseToken: FFAppState().SupabaseKey,
                          userIdsList: functions
                              .convertToStringList(widget.target!.userId!),
                          title: '🙏 Your friend  just prayed ',
                          body:
                              '${widget.user?.fullName} prayed for ${widget.target?.name}',
                        );

                        if ((_model.apiResultewm?.succeeded ?? true)) {
                          context.pushNamed(
                            PrayerCompleteWidget.routeName,
                            queryParameters: {
                              'encounterXp': serializeParam(
                                20,
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        } else {
                          context.pushNamed(
                            PrayerCompleteWidget.routeName,
                            queryParameters: {
                              'encounterXp': serializeParam(
                                20,
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );
                        }

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
