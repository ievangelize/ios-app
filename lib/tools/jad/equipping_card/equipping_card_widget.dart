import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/streak/streak_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'equipping_card_model.dart';
export 'equipping_card_model.dart';

class EquippingCardWidget extends StatefulWidget {
  const EquippingCardWidget({super.key});

  static String routeName = 'EquippingCard';
  static String routePath = 'equippingCard';

  @override
  State<EquippingCardWidget> createState() => _EquippingCardWidgetState();
}

class _EquippingCardWidgetState extends State<EquippingCardWidget> {
  late EquippingCardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EquippingCardModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'EquippingCard'});
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
            builder: (context) => InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                unawaited(
                  () async {
                    await XpEventsTable().insert({
                      'user_id': currentUserUid,
                      'delta': 0,
                      'reason': 'jad equipping card',
                      'idempotency_key': random_data.randomString(
                        16,
                        16,
                        true,
                        true,
                        true,
                      ),
                      'qualified_for_streak': true,
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
                            FocusManager.instance.primaryFocus?.unfocus();
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
                  FFAppState().update(() {});
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
                context.safePop();

                safeSetState(() {});
              },
              child: Icon(
                Icons.close,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 25.0,
              ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlipCard(
                  fill: Fill.fillBack,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 250,
                  front: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).secondaryText,
                        width: 1.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/card-back.png',
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  back: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/Card-front.jpg',
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Tap card to flip',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: Color(0xFFC2C2C2),
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                          lineHeight: 1.6,
                        ),
                  ),
                ),
              ]
                  .divide(SizedBox(height: 28.0))
                  .addToStart(SizedBox(height: 10.0)),
            ),
          ),
        ),
      ),
    );
  }
}
