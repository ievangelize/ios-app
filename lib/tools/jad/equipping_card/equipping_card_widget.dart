import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/random_data_util.dart' as random_data;
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          leading: InkWell(
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
              await action_blocks.calculateStreak(context);
              context.safePop();
            },
            child: Icon(
              Icons.close,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 25.0,
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
                  controller: _model.flippableCardController,
                  onFlip: () => _model.flippableCardIsFront =
                      !_model.flippableCardIsFront,
                  direction: FlipDirection.HORIZONTAL,
                  speed: 250,
                  front: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).dfdfdf,
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
