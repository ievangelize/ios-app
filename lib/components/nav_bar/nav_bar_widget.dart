import '/auth/base_auth_user_provider.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'nav_bar_model.dart';
export 'nav_bar_model.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({
    super.key,
    required this.selectedPage,
  });

  final String? selectedPage;

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  late NavBarModel _model;

  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavBarModel());

    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !(isWeb
          ? MediaQuery.viewInsetsOf(context).bottom > 0
          : _isKeyboardVisible),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 0.3,
            thickness: 0.4,
            color: FlutterFlowTheme.of(context).navIcons,
          ),
          Container(
            width: double.infinity,
            height: 66.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (loggedIn) {
                        context.goNamed(
                          'home',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      } else {
                        context.goNamed(
                          'homeNoAuth',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(),
                      alignment: const AlignmentDirectional(-1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (valueOrDefault<bool>(
                              widget.selectedPage == 'home' ? false : true,
                              true,
                            ))
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/house-blank.png',
                                  width: 23.0,
                                  height: 23.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            if (valueOrDefault<bool>(
                              widget.selectedPage == 'home' ? true : false,
                              false,
                            ))
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 'assets/images/house_light.png'
                                      : 'assets/images/house_dark.png',
                                  width: 23.0,
                                  height: 23.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 6.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  '3gg5imcp' /* Home */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: widget.selectedPage == 'home'
                                          ? FlutterFlowTheme.of(context)
                                              .primaryText
                                          : FlutterFlowTheme.of(context)
                                              .navIcons,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (loggedIn) {
                        context.goNamed(
                          'situation',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      } else {
                        context.goNamed(
                          'situationNoAuth',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (valueOrDefault<bool>(
                            widget.selectedPage == 'evangelize' ? false : true,
                            true,
                          ))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/bolt.png',
                                width: 23.0,
                                height: 23.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          if (valueOrDefault<bool>(
                            widget.selectedPage == 'evangelize' ? true : false,
                            false,
                          ))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 'assets/images/bolt_light.png'
                                    : 'assets/images/bolt_(1).png',
                                width: 23.0,
                                height: 23.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 6.0, 0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'jxq04hsp' /* Evangelize */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: widget.selectedPage == 'evangelize'
                                        ? FlutterFlowTheme.of(context)
                                            .primaryText
                                        : FlutterFlowTheme.of(context).navIcons,
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.goNamed(
                        'Explore',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (valueOrDefault<bool>(
                            widget.selectedPage == 'explore' ? false : true,
                            true,
                          ))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/clapper_(1).png',
                                width: 23.0,
                                height: 23.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          if (valueOrDefault<bool>(
                            widget.selectedPage == 'explore' ? true : false,
                            false,
                          ))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 'assets/images/clapper_(3).png'
                                    : 'assets/images/clapper_(2).png',
                                width: 23.0,
                                height: 23.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 6.0, 0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'dd9gxzvk' /* Explore */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: widget.selectedPage == 'explore'
                                        ? FlutterFlowTheme.of(context)
                                            .primaryText
                                        : FlutterFlowTheme.of(context).navIcons,
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (loggedIn) {
                        context.goNamed(
                          'followUpList',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      } else {
                        context.goNamed(
                          'followUpNoAuth',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                              duration: Duration(milliseconds: 0),
                            ),
                          },
                        );
                      }
                    },
                    child: Container(
                      decoration: const BoxDecoration(),
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (valueOrDefault<bool>(
                            widget.selectedPage == 'followup' ? false : true,
                            true,
                          ))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                'assets/images/pen-nib.png',
                                width: 23.0,
                                height: 23.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          if (valueOrDefault<bool>(
                            widget.selectedPage == 'followup' ? true : false,
                            false,
                          ))
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0.0),
                              child: Image.asset(
                                Theme.of(context).brightness == Brightness.dark
                                    ? 'assets/images/pen_light.png'
                                    : 'assets/images/pen_dark.png',
                                width: 23.0,
                                height: 23.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 6.0, 0.0, 0.0),
                            child: Text(
                              FFLocalizations.of(context).getText(
                                'jtqvto1t' /* Follow Up */,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    color: widget.selectedPage == 'followup'
                                        ? FlutterFlowTheme.of(context)
                                            .primaryText
                                        : FlutterFlowTheme.of(context).navIcons,
                                    fontSize: 10.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      context.goNamed(
                        'More',
                        extra: <String, dynamic>{
                          kTransitionInfoKey: const TransitionInfo(
                            hasTransition: true,
                            transitionType: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                          ),
                        },
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(),
                      alignment: const AlignmentDirectional(1.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 30.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (valueOrDefault<bool>(
                              widget.selectedPage == 'more' ? false : true,
                              true,
                            ))
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  'assets/images/menu-burger.png',
                                  width: 23.0,
                                  height: 23.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            if (valueOrDefault<bool>(
                              widget.selectedPage == 'more' ? true : false,
                              false,
                            ))
                              ClipRRect(
                                borderRadius: BorderRadius.circular(0.0),
                                child: Image.asset(
                                  Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? 'assets/images/menu_light_(2).png'
                                      : 'assets/images/menu_dark_(2).png',
                                  width: 23.0,
                                  height: 23.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 6.0, 0.0, 0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'ircq75se' /* More */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Inter',
                                      color: widget.selectedPage == 'more'
                                          ? FlutterFlowTheme.of(context)
                                              .primaryText
                                          : FlutterFlowTheme.of(context)
                                              .navIcons,
                                      fontSize: 10.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
