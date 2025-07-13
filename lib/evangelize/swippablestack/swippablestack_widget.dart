import '/flutter_flow/flutter_flow_swipeable_stack.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'swippablestack_model.dart';
export 'swippablestack_model.dart';

class SwippablestackWidget extends StatefulWidget {
  const SwippablestackWidget({
    super.key,
    required this.gptAnswer,
  });

  final dynamic gptAnswer;

  static String routeName = 'swippablestack';
  static String routePath = 'stack';

  @override
  State<SwippablestackWidget> createState() => _SwippablestackWidgetState();
}

class _SwippablestackWidgetState extends State<SwippablestackWidget> {
  late SwippablestackModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SwippablestackModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'swippablestack'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().firstSituaton) {
        await actions.requestReview();
        FFAppState().firstSituaton = false;
        safeSetState(() {});
      }
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
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
                size: 24.0,
              ),
            ),
            actions: [],
            centerTitle: false,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                child: Builder(
                  builder: (context) {
                    final starters = getJsonField(
                      widget.gptAnswer,
                      r'''$.Starters[:].start''',
                    ).toList();

                    return FlutterFlowSwipeableStack(
                      onSwipeFn: (index) {},
                      onLeftSwipe: (index) {},
                      onRightSwipe: (index) {},
                      onUpSwipe: (index) {},
                      onDownSwipe: (index) {},
                      itemBuilder: (context, startersIndex) {
                        final startersItem = starters[startersIndex];
                        return Stack(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          children: [
                            Container(
                              width: double.infinity,
                              height: 500.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F5F5),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.0,
                                    color: Color(0x5C000000),
                                    offset: Offset(
                                      0.0,
                                      3.0,
                                    ),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(
                                  color: Color(0xFFDFDFDF),
                                  width: 1.0,
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 32.0, 14.0, 14.0),
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
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          fontSize: 26.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(0.0, -15.0),
                              child: Container(
                                width: 167.0,
                                height: 34.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).primary,
                                  borderRadius: BorderRadius.circular(37.0),
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'ie26y1r0' /* Conversation Starter */,
                                  ),
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
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
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
                      scale: 0.88,
                      maxAngle: 180.0,
                      cardPadding:
                          EdgeInsetsDirectional.fromSTEB(22.0, 0.0, 22.0, 0.0),
                      allowedSwipeDirection:
                          AllowedSwipeDirection.symmetric(horizontal: true),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
