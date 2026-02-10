import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/components/streak/streak_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'daily_quote_model.dart';
export 'daily_quote_model.dart';

class DailyQuoteWidget extends StatefulWidget {
  const DailyQuoteWidget({
    super.key,
    required this.quote,
  });

  final QuotesRow? quote;

  static String routeName = 'dailyQuote';
  static String routePath = 'dailyQuote';

  @override
  State<DailyQuoteWidget> createState() => _DailyQuoteWidgetState();
}

class _DailyQuoteWidgetState extends State<DailyQuoteWidget> {
  late DailyQuoteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DailyQuoteModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'dailyQuote'});
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
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: CachedNetworkImage(
                  fadeInDuration: Duration(milliseconds: 200),
                  fadeOutDuration: Duration(milliseconds: 200),
                  imageUrl: valueOrDefault<String>(
                    widget.quote?.imageUrl,
                    'https://api.ievangelize.app/storage/v1/object/public/resources/quotes/1-min.png',
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Container(
                width: double.infinity,
                height: 56.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Builder(
                    builder: (context) => Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
                      child: FlutterFlowIconButton(
                        borderRadius: 8.0,
                        buttonSize: 44.0,
                        fillColor: Colors.transparent,
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 28.0,
                        ),
                        onPressed: () async {
                          if (FFAppState().completeQuoteDay ==
                                  dateTimeFormat(
                                    "Md",
                                    getCurrentTimestamp,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  )
                              ? true
                              : false) {
                            context.safePop();
                          } else {
                            FFAppState().completeQuoteDay = dateTimeFormat(
                              "Md",
                              getCurrentTimestamp,
                              locale: FFLocalizations.of(context).languageCode,
                            );
                            FFAppState().update(() {});
                            unawaited(
                              () async {
                                await XpEventsTable().insert({
                                  'user_id': currentUserUid,
                                  'delta': 0,
                                  'reason': 'quote of the day',
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
                              FFAppState().currentStreak = getJsonField(
                                _model.streak!.elementAtOrNull(1),
                                r'''$.streak''',
                              );
                              await UsersTable().update(
                                data: {
                                  'streak': FFAppState().currentStreak,
                                },
                                matchingRows: (rows) => rows.eqOrNull(
                                  'id',
                                  currentUserUid,
                                ),
                              );
                              await showDialog(
                                barrierColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
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

                              context.safePop();
                            } else {
                              context.safePop();
                            }
                          }

                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 1.0),
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 12.0),
                    child: wrapWithModel(
                      model: _model.largeBtnModel,
                      updateCallback: () => safeSetState(() {}),
                      child: LargeBtnWidget(
                        text: 'SHARE QUOTE',
                        textColor: FlutterFlowTheme.of(context).info,
                        action: () async {
                          await actions.shareQoute(
                            context,
                            widget.quote!.imageUrl!,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
