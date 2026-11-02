import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'selected_starter_model.dart';
export 'selected_starter_model.dart';

class SelectedStarterWidget extends StatefulWidget {
  const SelectedStarterWidget({
    super.key,
    required this.gptAnswer,
    required this.selectedSituation,
  });

  final dynamic gptAnswer;
  final SituationRow? selectedSituation;

  static String routeName = 'selectedStarter';
  static String routePath = 'newui2';

  @override
  State<SelectedStarterWidget> createState() => _SelectedStarterWidgetState();
}

class _SelectedStarterWidgetState extends State<SelectedStarterWidget> {
  late SelectedStarterModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SelectedStarterModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'selectedStarter'});
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
              context.safePop();
            },
            child: Icon(
              Icons.arrow_back,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 25.0,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  if (isiOS) {
                    _model.response = await actions.cupertinoConfirmationDialog(
                      context,
                      'Delete conversation starter?',
                      'This can\'t be undone.',
                      'Cancel',
                      'Delete',
                      FlutterFlowTheme.of(context).error,
                      FlutterFlowTheme.of(context).secondary,
                    );
                    if (_model.response!) {
                      await SituationTable().delete(
                        matchingRows: (rows) => rows.eqOrNull(
                          'id',
                          widget.selectedSituation?.id,
                        ),
                      );
                      FFAppState().clearConversationHistoryCache();

                      context.goNamed(
                        ConversationHistoryWidget.routeName,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.rightToLeft,
                          ),
                        },
                      );
                    }
                  } else {
                    var confirmDialogResponse = await showDialog<bool>(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Delete conversation starter?'),
                              content: Text('This can\'t be undone.'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext, true),
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        ) ??
                        false;
                    if (confirmDialogResponse) {
                      await SituationTable().delete(
                        matchingRows: (rows) => rows.eqOrNull(
                          'id',
                          widget.selectedSituation?.id,
                        ),
                      );
                      FFAppState().clearConversationHistoryCache();

                      context.goNamed(
                        ConversationHistoryWidget.routeName,
                        extra: <String, dynamic>{
                          '__transition_info__': TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.rightToLeft,
                          ),
                        },
                      );
                    }
                  }

                  safeSetState(() {});
                },
                child: FaIcon(
                  FaIconData(const IconData(/* trashAlt */ 0xf2ed,
                      fontFamily: 'FontAwesomeRegular',
                      fontPackage: 'font_awesome_flutter')),
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 25.0,
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 60.0, 0.0, 0.0),
                child: Builder(
                  builder: (context) {
                    final starters = getJsonField(
                      widget.gptAnswer,
                      r'''$.Starters[:].start''',
                    ).toList();

                    return FlutterFlowSwipeableStack(
                      onSwipeFn: (startersIndex) {},
                      onLeftSwipe: (startersIndex) {},
                      onRightSwipe: (startersIndex) {},
                      onUpSwipe: (startersIndex) {},
                      onDownSwipe: (startersIndex) {},
                      itemBuilder: (context, startersIndex) {
                        final startersItem = starters[startersIndex];
                        return Stack(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          children: [
                            Container(
                              width: double.infinity,
                              height: 420.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4.0,
                                    color: Color(0x19000000),
                                    offset: Offset(
                                      0.0,
                                      2.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(24.0),
                                border: Border.all(
                                  color: valueOrDefault<Color>(
                                    () {
                                      if ('${getJsonField(
                                            startersItem,
                                            r'''$.type''',
                                          ).toString()}' ==
                                          'generic') {
                                        return Color(0x7322C55E);
                                      } else if ('${getJsonField(
                                            startersItem,
                                            r'''$.type''',
                                          ).toString()}' ==
                                          'tailored') {
                                        return Color(0x73F97316);
                                      } else {
                                        return Color(0x72864AF9);
                                      }
                                    }(),
                                    FlutterFlowTheme.of(context).secondary,
                                  ),
                                  width: 4.0,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  if ('${getJsonField(
                                            startersItem,
                                            r'''$.type''',
                                          ).toString()}' ==
                                          'tip'
                                      ? true
                                      : false)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 32.0, 16.0, 16.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SelectionArea(
                                                child: Text(
                                              getJsonField(
                                                startersItem,
                                                r'''$.title''',
                                              ).toString(),
                                              textAlign: TextAlign.start,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (('${getJsonField(
                                                startersItem,
                                                r'''$.type''',
                                              ).toString()}' ==
                                              'generic') ||
                                          ('${getJsonField(
                                                startersItem,
                                                r'''$.type''',
                                              ).toString()}' ==
                                              'tailored')
                                      ? true
                                      : false)
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        child: SelectionArea(
                                            child: Text(
                                          getJsonField(
                                            startersItem,
                                            r'''$.title''',
                                          ).toString(),
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 24.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                                lineHeight: 1.5,
                                              ),
                                        )),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, -15.0),
                              child: Container(
                                width: 175.0,
                                height: 38.0,
                                decoration: BoxDecoration(
                                  color: valueOrDefault<Color>(
                                    () {
                                      if ('${getJsonField(
                                            startersItem,
                                            r'''$.type''',
                                          ).toString()}' ==
                                          'generic') {
                                        return Color(0xFF22C55E);
                                      } else if ('${getJsonField(
                                            startersItem,
                                            r'''$.type''',
                                          ).toString()}' ==
                                          'tailored') {
                                        return Color(0xFFF97316);
                                      } else {
                                        return FlutterFlowTheme.of(context)
                                            .secondary;
                                      }
                                    }(),
                                    FlutterFlowTheme.of(context).secondary,
                                  ),
                                  borderRadius: BorderRadius.circular(37.0),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  () {
                                    if ('${getJsonField(
                                          startersItem,
                                          r'''$.type''',
                                        ).toString()}' ==
                                        'generic') {
                                      return 'General';
                                    } else if ('${getJsonField(
                                          startersItem,
                                          r'''$.type''',
                                        ).toString()}' ==
                                        'tailored') {
                                      return 'Tailored';
                                    } else {
                                      return 'Tip';
                                    }
                                  }(),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).info,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: starters.length,
                      controller: _model.swipeableStackController,
                      loop: true,
                      cardDisplayCount: 3,
                      scale: 0.85,
                      cardPadding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 40.0, 16.0, 0.0),
                      allowedSwipeDirection:
                          AllowedSwipeDirection.symmetric(horizontal: true),
                    );
                  },
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 40.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          _model.swipeableStackController.swipeRight();
                        },
                        child: Icon(
                          Icons.navigate_before,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 36.0,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          HapticFeedback.lightImpact();
                          _model.swipeableStackController.swipeLeft();
                        },
                        child: Icon(
                          Icons.navigate_next,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 36.0,
                        ),
                      ),
                    ],
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
