import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'confirm_salvation_model.dart';
export 'confirm_salvation_model.dart';

class ConfirmSalvationWidget extends StatefulWidget {
  const ConfirmSalvationWidget({
    super.key,
    required this.target,
  });

  final PrayerTargetsRow? target;

  @override
  State<ConfirmSalvationWidget> createState() => _ConfirmSalvationWidgetState();
}

class _ConfirmSalvationWidgetState extends State<ConfirmSalvationWidget> {
  late ConfirmSalvationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmSalvationModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        color: Color(0xFFDDECD5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 55.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              thickness: 3.0,
              indent: 150.0,
              endIndent: 150.0,
              color: Color(0xB3C0C0C0),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.celebration_rounded,
                  color: Color(0xFF5C9342),
                  size: 22.0,
                ),
                Text(
                  'Confirm Salvation',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                        color: Color(0xFF5C9342),
                        fontSize: 18.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .fontStyle,
                      ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 26.0, 0.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFC8D5C1),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Has this person has personally accepted Jesus Christ as their Lord and Savior? Tap Yes if so.\n\nThey will be removed from your prayer list and added to your encounter list.',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: Colors.black,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ].divide(SizedBox(height: 6.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 26.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: wrapWithModel(
                      model: _model.largeBtnModel,
                      updateCallback: () => safeSetState(() {}),
                      child: LargeBtnWidget(
                        text: 'Yes',
                        color: Color(0xFF5C9342),
                        textColor: FlutterFlowTheme.of(context).info,
                        action: () async {
                          _model.newReached = await ReachedTable().insert({
                            'Name': widget.target?.name,
                            'Note': 'This person was once on your prayer list.',
                            'status': 'Saved',
                            'created_by': currentUserUid,
                            'people_reached': 1,
                          });
                          unawaited(
                            () async {
                              await XpEventsTable().insert({
                                'user_id': currentUserUid,
                                'delta': 50,
                                'reason': 'new encounter',
                                'idempotency_key': _model.newReached?.id,
                                'share_with_friends': true,
                              });
                            }(),
                          );
                          await action_blocks.calculateStreak(context);
                          unawaited(
                            () async {
                              await action_blocks.sendFriendNotification(
                                context,
                                eventType: 'target saved',
                                prayerTargetName: widget.target?.name,
                              );
                            }(),
                          );
                          await PrayerTargetsTable().delete(
                            matchingRows: (rows) => rows
                                .eqOrNull(
                                  'id',
                                  widget.target?.id,
                                )
                                .eqOrNull(
                                  'user_id',
                                  widget.target?.userId,
                                ),
                          );
                          FFAppState().clearPrayerTargetsCache();
                          FFAppState().clearEncountersCache();

                          context.pushNamed(
                            TargetSavedWidget.routeName,
                            queryParameters: {
                              'lessonXp': serializeParam(
                                50,
                                ParamType.int,
                              ),
                            }.withoutNulls,
                          );

                          Navigator.pop(context);

                          safeSetState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
