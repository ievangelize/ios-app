import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'appbar_home_model.dart';
export 'appbar_home_model.dart';

class AppbarHomeWidget extends StatefulWidget {
  const AppbarHomeWidget({
    super.key,
    required this.user,
  });

  final UsersRow? user;

  @override
  State<AppbarHomeWidget> createState() => _AppbarHomeWidgetState();
}

class _AppbarHomeWidgetState extends State<AppbarHomeWidget> {
  late AppbarHomeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AppbarHomeModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
      _model.isDeprecated = await actions.isVersionDeprecated(
        getRemoteConfigString('deprecatedVersion'),
      );
      if (_model.isDeprecated!) {
        context.goNamedAuth(
          UpdateVersionWidget.routeName,
          context.mounted,
          extra: <String, dynamic>{
            '__transition_info__': TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );

        return;
      } else {
        if ((widget.user?.onboardingComplete == false) &&
            (FFAppState().onboardingStarted == false)) {
          GoRouter.of(context).prepareAuthEvent();
          await authManager.signOut();
          GoRouter.of(context).clearRedirectLocation();

          context.goNamedAuth(
            OnboardingFlowWidget.routeName,
            context.mounted,
            extra: <String, dynamic>{
              '__transition_info__': TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 0),
              ),
            },
          );
        } else {
          if (FFAppState().firstHomeVisit) {
            FFAppState().currentStreak = widget.user!.streak!;
            FFAppState().firstHomeVisit = false;
            FFAppState().update(() {});
            _model.donate = await actions.showDonatePage();
            if (_model.donate!) {
              context.goNamedAuth(
                DonateWidget.routeName,
                context.mounted,
                extra: <String, dynamic>{
                  '__transition_info__': TransitionInfo(
                    hasTransition: true,
                    transitionType: PageTransitionType.bottomToTop,
                  ),
                },
              );
            }
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dateTimeFormat(
                                    "a",
                                    getCurrentTimestamp,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  ) ==
                                  'AM'
                              ? 'Good Morning'
                              : 'Good Afternoon',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    fontSize: 26.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 8.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.pushNamed(
                                DonateWidget.routeName,
                                extra: <String, dynamic>{
                                  '__transition_info__': TransitionInfo(
                                    hasTransition: true,
                                    transitionType:
                                        PageTransitionType.bottomToTop,
                                  ),
                                },
                              );
                            },
                            child: Container(
                              width: 34.0,
                              height: 34.0,
                              decoration: BoxDecoration(
                                color: Color(0xFFFEE2E1),
                                shape: BoxShape.circle,
                              ),
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Color(0xFFF13A28),
                                size: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(ProfileWidget.routeName);
                      },
                      child: Container(
                        width: 38.0,
                        height: 38.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CachedNetworkImage(
                          fadeInDuration: Duration(milliseconds: 500),
                          fadeOutDuration: Duration(milliseconds: 500),
                          imageUrl: valueOrDefault<String>(
                            widget.user!.profileAdded!
                                ? widget.user?.profileUrl
                                : 'https://api.ievangelize.app/storage/v1/object/public/misc/avatar.jpg',
                            'https://api.ievangelize.app/storage/v1/object/public/misc/avatar.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'STREAK DAYS: ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              fontSize: 12.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            valueOrDefault<String>(
                              widget.user?.streak?.toString(),
                              '0',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.bolt,
                            color: FlutterFlowTheme.of(context).secondary,
                            size: 12.0,
                          ),
                        ].divide(SizedBox(width: 3.0)),
                      ),
                    ].divide(SizedBox(width: 2.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FFAppState()
                                  .activeDays
                                  .containsMap(getJsonField(
                                    <String, String>{
                                      'day': 'Mon',
                                    },
                                    r'''$.day''',
                                  ))
                              ? FlutterFlowTheme.of(context).streak
                              : FlutterFlowTheme.of(context).primaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: dateTimeFormat(
                                      "E",
                                      getCurrentTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ) ==
                                    'Mon'
                                ? FlutterFlowTheme.of(context).secondary
                                : Color(0xDFDFDFDF),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            if (!(FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Mon',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true))
                              FaIcon(
                                FontAwesomeIcons.bolt,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 14.0,
                              ),
                            if (FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Mon',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true)
                              Text(
                                'MON',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: dateTimeFormat(
                                                "E",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              'Mon'
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FFAppState()
                                  .activeDays
                                  .containsMap(getJsonField(
                                    <String, String>{
                                      'day': 'Tue',
                                    },
                                    r'''$.day''',
                                  ))
                              ? FlutterFlowTheme.of(context).streak
                              : FlutterFlowTheme.of(context).primaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: dateTimeFormat(
                                      "E",
                                      getCurrentTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ) ==
                                    'Tue'
                                ? FlutterFlowTheme.of(context).secondary
                                : Color(0xDFDFDFDF),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            if (!(FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Tue',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true))
                              FaIcon(
                                FontAwesomeIcons.bolt,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 14.0,
                              ),
                            if (FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Tue',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true)
                              Text(
                                'TUE',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: dateTimeFormat(
                                                "E",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              'Tue'
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FFAppState()
                                  .activeDays
                                  .containsMap(getJsonField(
                                    <String, String>{
                                      'day': 'Wed',
                                    },
                                    r'''$.day''',
                                  ))
                              ? FlutterFlowTheme.of(context).streak
                              : FlutterFlowTheme.of(context).primaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: dateTimeFormat(
                                      "E",
                                      getCurrentTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ) ==
                                    'Wed'
                                ? FlutterFlowTheme.of(context).secondary
                                : Color(0xDFDFDFDF),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            if (!(FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Wed',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true))
                              FaIcon(
                                FontAwesomeIcons.bolt,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 14.0,
                              ),
                            if (FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Wed',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true)
                              Text(
                                'WED',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: dateTimeFormat(
                                                "E",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              'Wed'
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FFAppState()
                                  .activeDays
                                  .containsMap(getJsonField(
                                    <String, String>{
                                      'day': 'Thu',
                                    },
                                    r'''$.day''',
                                  ))
                              ? FlutterFlowTheme.of(context).streak
                              : FlutterFlowTheme.of(context).primaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: dateTimeFormat(
                                      "E",
                                      getCurrentTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ) ==
                                    'Thu'
                                ? FlutterFlowTheme.of(context).secondary
                                : Color(0xFFDFDFDF),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            if (!(FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Thu',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true))
                              FaIcon(
                                FontAwesomeIcons.bolt,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 14.0,
                              ),
                            if (FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Thu',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true)
                              Text(
                                'THU',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: dateTimeFormat(
                                                "E",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              'Thu'
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FFAppState()
                                  .activeDays
                                  .containsMap(getJsonField(
                                    <String, String>{
                                      'day': 'Fri',
                                    },
                                    r'''$.day''',
                                  ))
                              ? FlutterFlowTheme.of(context).streak
                              : FlutterFlowTheme.of(context).primaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: dateTimeFormat(
                                      "E",
                                      getCurrentTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ) ==
                                    'Fri'
                                ? FlutterFlowTheme.of(context).secondary
                                : Color(0xDFDFDFDF),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            if (!(FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Fri',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true))
                              FaIcon(
                                FontAwesomeIcons.bolt,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 14.0,
                              ),
                            if (FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Fri',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true)
                              Text(
                                'FRI',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: dateTimeFormat(
                                                "E",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              'Fri'
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FFAppState()
                                  .activeDays
                                  .containsMap(getJsonField(
                                    <String, String>{
                                      'day': 'Sat',
                                    },
                                    r'''$.day''',
                                  ))
                              ? FlutterFlowTheme.of(context).streak
                              : FlutterFlowTheme.of(context).primaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: dateTimeFormat(
                                      "E",
                                      getCurrentTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ) ==
                                    'Sat'
                                ? FlutterFlowTheme.of(context).secondary
                                : Color(0xDFDFDFDF),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            if (!(FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Sat',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true))
                              FaIcon(
                                FontAwesomeIcons.bolt,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 14.0,
                              ),
                            if (FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Sat',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true)
                              Text(
                                'SAT',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: dateTimeFormat(
                                                "E",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              'Sat'
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FFAppState()
                                  .activeDays
                                  .containsMap(getJsonField(
                                    <String, String>{
                                      'day': 'Sun',
                                    },
                                    r'''$.day''',
                                  ))
                              ? FlutterFlowTheme.of(context).streak
                              : FlutterFlowTheme.of(context).primaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: dateTimeFormat(
                                      "E",
                                      getCurrentTimestamp,
                                      locale: FFLocalizations.of(context)
                                          .languageCode,
                                    ) ==
                                    'Sun'
                                ? FlutterFlowTheme.of(context).secondary
                                : Color(0xDFDFDFDF),
                          ),
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          children: [
                            if (!(FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Sun',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true))
                              FaIcon(
                                FontAwesomeIcons.bolt,
                                color: FlutterFlowTheme.of(context).secondary,
                                size: 14.0,
                              ),
                            if (FFAppState()
                                    .activeDays
                                    .containsMap(getJsonField(
                                      <String, String>{
                                        'day': 'Sun',
                                      },
                                      r'''$.day''',
                                    ))
                                ? false
                                : true)
                              Text(
                                'SUN',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: dateTimeFormat(
                                                "E",
                                                getCurrentTimestamp,
                                                locale:
                                                    FFLocalizations.of(context)
                                                        .languageCode,
                                              ) ==
                                              'Sun'
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : FlutterFlowTheme.of(context)
                                              .primaryText,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1.0,
          thickness: 1.0,
          color: FlutterFlowTheme.of(context).accent1,
        ),
      ],
    );
  }
}
