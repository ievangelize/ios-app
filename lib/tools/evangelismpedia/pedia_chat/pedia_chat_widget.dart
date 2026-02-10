import '/auth/supabase_auth/auth_util.dart';
import '/backend/ai_agents/ai_agent.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/api_requests/api_streaming.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/chat_item_stream/chat_item_stream_widget.dart';
import '/components/streak/streak_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'dart:convert';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pedia_chat_model.dart';
export 'pedia_chat_model.dart';

class PediaChatWidget extends StatefulWidget {
  const PediaChatWidget({
    super.key,
    required this.oldConversation,
    this.conversation,
  });

  final bool? oldConversation;
  final ConversationsRow? conversation;

  static String routeName = 'pediaChat';
  static String routePath = 'pediaChat';

  @override
  State<PediaChatWidget> createState() => _PediaChatWidgetState();
}

class _PediaChatWidgetState extends State<PediaChatWidget>
    with TickerProviderStateMixin {
  late PediaChatModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PediaChatModel());

    logFirebaseEvent('screen_view', parameters: {'screen_name': 'pediaChat'});
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().messages = [];
      safeSetState(() {});
      if (widget.oldConversation!) {
        _model.oldMessages = await ConversationMessagesTable().queryRows(
          queryFn: (q) => q
              .eqOrNull(
                'conversation_id',
                widget.conversation?.id,
              )
              .order('created_at', ascending: true),
        );
        for (int loop1Index = 0;
            loop1Index < _model.oldMessages!.length;
            loop1Index++) {
          final currentLoop1Item = _model.oldMessages![loop1Index];
          if (currentLoop1Item.role == 'user') {
            FFAppState().addToMessages(MessageStruct(
              role: 'user',
              messages:
                  functions.convertToStringList(currentLoop1Item.content!),
              createdAt: currentLoop1Item.createdAt,
              isHistory: true,
            ));
            safeSetState(() {});
          } else {
            FFAppState().addToMessages(MessageStruct(
              role: 'assistant',
              messages:
                  functions.convertToStringList(currentLoop1Item.content!),
              createdAt: currentLoop1Item.createdAt,
              isHistory: true,
            ));
            safeSetState(() {});
          }
        }
        _model.chatVisible = true;
        _model.firstMessage = false;
        _model.previousRespnseId = _model.oldMessages
            ?.where((e) => e.role == 'assistant')
            .toList()
            .lastOrNull
            ?.openaiPreviousResponseId;
        _model.conversationId = widget.conversation?.id;
        _model.conversationTitle = widget.conversation!.title!;
        safeSetState(() {});
      }
    });

    _model.userMessageTextController ??= TextEditingController();
    _model.userMessageFocusNode ??= FocusNode();

    animationsMap.addAll({
      'iconOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          ScaleEffect(
            curve: Curves.linear,
            delay: 0.0.ms,
            duration: 200.0.ms,
            begin: Offset(1.0, 1.0),
            end: Offset(1.2, 1.2),
          ),
          ScaleEffect(
            curve: Curves.linear,
            delay: 200.0.ms,
            duration: 200.0.ms,
            begin: Offset(1.2, 1.2),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
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
                      'reason': 'evangelismpedia',
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
                FFAppState().messages = [];
                safeSetState(() {});
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
                }

                context.goNamed(ToolsWidget.routeName);

                safeSetState(() {});
              },
              child: Icon(
                Icons.arrow_back,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 25.0,
              ),
            ),
          ),
          title: Text(
            _model.conversationTitle,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight:
                        FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: _model.conversationTitle == 'Untitled'
                      ? FlutterFlowTheme.of(context).primaryBackground
                      : FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                  FFAppState().messages = [];
                  safeSetState(() {});

                  context.goNamed(ChatHistoryWidget.routeName);
                },
                child: Icon(
                  Icons.history,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 32.0,
                ),
              ),
            ),
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 80.0),
                child: SingleChildScrollView(
                  controller: _model.columnChatScrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (_model.chatVisible)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 16.0, 0.0),
                          child: Builder(
                            builder: (context) {
                              final messageItem =
                                  FFAppState().messages.toList();

                              return ListView.separated(
                                padding: EdgeInsets.fromLTRB(
                                  0,
                                  18.0,
                                  0,
                                  0,
                                ),
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: messageItem.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 2.0),
                                itemBuilder: (context, messageItemIndex) {
                                  final messageItemItem =
                                      messageItem[messageItemIndex];
                                  return Container(
                                    alignment: AlignmentDirectional(0.0, 1.0),
                                    child: wrapWithModel(
                                      model:
                                          _model.chatItemStreamModels.getModel(
                                        _model.conversationId!,
                                        messageItemIndex,
                                      ),
                                      updateCallback: () => safeSetState(() {}),
                                      child: ChatItemStreamWidget(
                                        key: Key(
                                          'Keyw0f_${_model.conversationId!}',
                                        ),
                                        message: messageItemItem,
                                      ),
                                    ),
                                  );
                                },
                                controller: _model.listViewChatScrollController,
                              );
                            },
                          ),
                        ),
                      if (_model.isThinking)
                        Align(
                          alignment: AlignmentDirectional(0.0, -1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.bolt,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 14.0,
                                ).animateOnPageLoad(
                                    animationsMap['iconOnPageLoadAnimation']!),
                                Text(
                                  'Thinking...',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.inter(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ].divide(SizedBox(width: 6.0)),
                            ),
                          ),
                        ),
                    ].addToEnd(SizedBox(height: 120.0)),
                  ),
                ),
              ),
              if (!_model.chatVisible)
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 200.0),
                    child: Text(
                      'What\'s on your mind?',
                      textAlign: TextAlign.center,
                      style:
                          FlutterFlowTheme.of(context).headlineLarge.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 30.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineLarge
                                    .fontStyle,
                              ),
                    ),
                  ),
                ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 80.0,
                  ),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_model.chatVisible)
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 12.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _model.rowController,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    safeSetState(() {
                                      _model.userMessageTextController?.text =
                                          'Is baptism the same as being born again?';
                                    });
                                    HapticFeedback.lightImpact();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Is baptism the',
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
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            'same as being born again?',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ],
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
                                    safeSetState(() {
                                      _model.userMessageTextController?.text =
                                          'Is healing still for today?';
                                    });
                                    HapticFeedback.lightImpact();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Is healing',
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
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            'still for today?',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ],
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
                                    safeSetState(() {
                                      _model.userMessageTextController?.text =
                                          'How can I lead someone in a prayer of salvation?';
                                    });
                                    HapticFeedback.lightImpact();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'How can I lead someone',
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
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            'in a prayer of salvation?',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ],
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
                                    safeSetState(() {
                                      _model.userMessageTextController?.text =
                                          'Is Jesus the only way to God?';
                                    });
                                    HapticFeedback.lightImpact();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12.0, 12.0, 12.0, 12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Is Jesus',
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
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            'the only way to God?',
                                            textAlign: TextAlign.start,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                                  .divide(SizedBox(width: 16.0))
                                  .addToStart(SizedBox(width: 16.0))
                                  .addToEnd(SizedBox(width: 16.0)),
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 12.0, 16.0, 12.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            borderRadius: BorderRadius.circular(50.0),
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).alternate,
                              width: 1.0,
                            ),
                          ),
                          child: Form(
                            key: _model.formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 0.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          _model.userMessageTextController,
                                      focusNode: _model.userMessageFocusNode,
                                      autofocus: false,
                                      textInputAction: TextInputAction.done,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        hintText:
                                            'Ask me anything about evangelism',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.normal,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
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
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      maxLines: null,
                                      maxLength: 350,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      buildCounter: (context,
                                              {required currentLength,
                                              required isFocused,
                                              maxLength}) =>
                                          null,
                                      validator: _model
                                          .userMessageTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 3.0, 0.0),
                                    child: FlutterFlowIconButton(
                                      borderColor: Colors.transparent,
                                      borderRadius: 20.0,
                                      borderWidth: 1.0,
                                      buttonSize: 40.0,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .blackWhite,
                                      icon: Icon(
                                        Icons.arrow_upward_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        size: 20.0,
                                      ),
                                      onPressed: () async {
                                        var _shouldSetState = false;
                                        _model.chatVisible = true;
                                        safeSetState(() {});
                                        if (_model.userMessageTextController
                                                    .text !=
                                                '') {
                                          if (_model.firstMessage) {
                                            _model.newConversation =
                                                await ConversationsTable()
                                                    .insert({
                                              'user_id': currentUserUid,
                                              'title': 'Untitled',
                                              'last_message_at':
                                                  supaSerialize<DateTime>(
                                                      getCurrentTimestamp),
                                            });
                                            _shouldSetState = true;
                                            FFAppState()
                                                .clearChatHistoryCache();
                                            _model.conversationId =
                                                _model.newConversation?.id;
                                            safeSetState(() {});
                                          }
                                          await Future.wait([
                                            Future(() async {
                                              _model.newMessage = true;
                                              _model.stillStreaming = true;
                                              _model.userMessage = _model
                                                  .userMessageTextController
                                                  .text;
                                              _model.isThinking = true;
                                              safeSetState(() {});
                                              safeSetState(() {
                                                _model.userMessageTextController
                                                    ?.clear();
                                              });
                                              await actions.hideKeyboard();
                                              FFAppState()
                                                  .addToMessages(MessageStruct(
                                                role: 'user',
                                                messages: functions
                                                    .convertToStringList(
                                                        _model.userMessage!),
                                                id: random_data
                                                    .randomInteger(0, 10)
                                                    .toString(),
                                                createdAt: getCurrentTimestamp,
                                              ));
                                              safeSetState(() {});
                                              unawaited(
                                                () async {
                                                  await _model
                                                      .columnChatScrollController
                                                      ?.animateTo(
                                                    _model
                                                        .columnChatScrollController!
                                                        .position
                                                        .maxScrollExtent,
                                                    duration: Duration(
                                                        milliseconds: 100),
                                                    curve: Curves.ease,
                                                  );
                                                }(),
                                              );
                                              unawaited(
                                                () async {
                                                  await ConversationMessagesTable()
                                                      .insert({
                                                    'conversation_id':
                                                        _model.conversationId,
                                                    'content':
                                                        _model.userMessage,
                                                    'role': 'user',
                                                  });
                                                }(),
                                              );
                                              if (_model.firstMessage) {
                                                _model.apiResulth8u =
                                                    await EvangelismpediaFirstCall
                                                        .call(
                                                  token:
                                                      FFAppState().openaiApiKey,
                                                  userText: _model.userMessage,
                                                );
                                                if (_model.apiResulth8u
                                                        ?.succeeded ??
                                                    true) {
                                                  final streamSubscription = _model
                                                      .apiResulth8u
                                                      ?.streamedResponse
                                                      ?.stream
                                                      .transform(utf8.decoder)
                                                      .transform(
                                                          const LineSplitter())
                                                      .transform(
                                                          ServerSentEventLineTransformer())
                                                      .map((m) =>
                                                          ResponseStreamMessage(
                                                              message: m))
                                                      .listen(
                                                    (onMessageInput) async {
                                                      if (_model.newMessage) {
                                                        _model.newMessage =
                                                            false;
                                                        _model.previousRespnseId =
                                                            ResponseStruct.maybeFromMap(
                                                                    onMessageInput
                                                                        .serverSentEvent
                                                                        .jsonData)
                                                                ?.response
                                                                .id;
                                                        _model.isThinking =
                                                            false;
                                                        safeSetState(() {});
                                                        FFAppState()
                                                            .addToMessages(
                                                                MessageStruct(
                                                          id: ResponseStruct.maybeFromMap(
                                                                  onMessageInput
                                                                      .serverSentEvent
                                                                      .jsonData)
                                                              ?.itemId,
                                                          role: 'assistant',
                                                          messages: functions
                                                              .convertToStringList(
                                                                  ResponseStruct.maybeFromMap(onMessageInput
                                                                          .serverSentEvent
                                                                          .jsonData)!
                                                                      .delta),
                                                          createdAt:
                                                              getCurrentTimestamp,
                                                        ));
                                                        safeSetState(() {});
                                                      } else {
                                                        FFAppState()
                                                            .updateMessagesAtIndex(
                                                          functions
                                                              .lastListOfMessages(
                                                                  FFAppState()
                                                                      .messages
                                                                      .toList())!,
                                                          (e) => e
                                                            ..updateMessages(
                                                              (e) => e.add(ResponseStruct.maybeFromMap(
                                                                      onMessageInput
                                                                          .serverSentEvent
                                                                          .jsonData)!
                                                                  .delta),
                                                            )
                                                            ..role = 'assistant'
                                                            ..id = ResponseStruct.maybeFromMap(
                                                                    onMessageInput
                                                                        .serverSentEvent
                                                                        .jsonData)
                                                                ?.itemId
                                                            ..createdAt =
                                                                getCurrentTimestamp,
                                                        );
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    onError:
                                                        (onErrorInput) async {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Something wrong happened, please try later',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .info,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                        ),
                                                      );
                                                      _model.stillStreaming =
                                                          false;
                                                      safeSetState(() {});
                                                    },
                                                    onDone: () async {
                                                      unawaited(
                                                        () async {
                                                          await ConversationsTable()
                                                              .update(
                                                            data: {
                                                              'last_message_at':
                                                                  supaSerialize<
                                                                          DateTime>(
                                                                      getCurrentTimestamp),
                                                            },
                                                            matchingRows:
                                                                (rows) => rows
                                                                    .eqOrNull(
                                                                      'id',
                                                                      _model
                                                                          .conversationId,
                                                                    )
                                                                    .eqOrNull(
                                                                      'user_id',
                                                                      currentUserUid,
                                                                    ),
                                                          );
                                                        }(),
                                                      );
                                                      unawaited(
                                                        () async {
                                                          await ConversationMessagesTable()
                                                              .insert({
                                                            'conversation_id':
                                                                _model
                                                                    .conversationId,
                                                            'content': functions
                                                                .convertListtoString(
                                                                    FFAppState()
                                                                        .messages
                                                                        .lastOrNull!
                                                                        .messages
                                                                        .toList()),
                                                            'role': FFAppState()
                                                                .messages
                                                                .lastOrNull
                                                                ?.role,
                                                          });
                                                        }(),
                                                      );
                                                      _model.firstMessage =
                                                          false;
                                                    },
                                                  );
                                                }

                                                _shouldSetState = true;
                                                if (!(_model.apiResulth8u
                                                        ?.succeeded ??
                                                    true)) {
                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                  return;
                                                }
                                              } else {
                                                _model.apiResulthNext =
                                                    await EvangelismpediaNextMessageCall
                                                        .call(
                                                  token:
                                                      FFAppState().openaiApiKey,
                                                  userText: _model.userMessage,
                                                  previousResponseId:
                                                      _model.previousRespnseId,
                                                );
                                                if (_model.apiResulthNext
                                                        ?.succeeded ??
                                                    true) {
                                                  final streamSubscription = _model
                                                      .apiResulthNext
                                                      ?.streamedResponse
                                                      ?.stream
                                                      .transform(utf8.decoder)
                                                      .transform(
                                                          const LineSplitter())
                                                      .transform(
                                                          ServerSentEventLineTransformer())
                                                      .map((m) =>
                                                          ResponseStreamMessage(
                                                              message: m))
                                                      .listen(
                                                    (onMessageInput) async {
                                                      if (_model.newMessage) {
                                                        _model.previousRespnseId =
                                                            ResponseStruct.maybeFromMap(
                                                                    onMessageInput
                                                                        .serverSentEvent
                                                                        .jsonData)
                                                                ?.response
                                                                .id;
                                                        _model.newMessage =
                                                            false;
                                                        _model.isThinking =
                                                            false;
                                                        safeSetState(() {});
                                                        FFAppState()
                                                            .addToMessages(
                                                                MessageStruct(
                                                          id: ResponseStruct.maybeFromMap(
                                                                  onMessageInput
                                                                      .serverSentEvent
                                                                      .jsonData)
                                                              ?.itemId,
                                                          role: 'assistant',
                                                          messages: functions
                                                              .convertToStringList(
                                                                  ResponseStruct.maybeFromMap(onMessageInput
                                                                          .serverSentEvent
                                                                          .jsonData)!
                                                                      .delta),
                                                          createdAt:
                                                              getCurrentTimestamp,
                                                        ));
                                                        safeSetState(() {});
                                                      } else {
                                                        FFAppState()
                                                            .updateMessagesAtIndex(
                                                          functions
                                                              .lastListOfMessages(
                                                                  FFAppState()
                                                                      .messages
                                                                      .toList())!,
                                                          (e) => e
                                                            ..updateMessages(
                                                              (e) => e.add(ResponseStruct.maybeFromMap(
                                                                      onMessageInput
                                                                          .serverSentEvent
                                                                          .jsonData)!
                                                                  .delta),
                                                            )
                                                            ..role = 'assistant'
                                                            ..id = ResponseStruct.maybeFromMap(
                                                                    onMessageInput
                                                                        .serverSentEvent
                                                                        .jsonData)
                                                                ?.itemId
                                                            ..createdAt =
                                                                getCurrentTimestamp,
                                                        );
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    onError:
                                                        (onErrorInput) async {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Something wrong happened, please try later',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .info,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .error,
                                                        ),
                                                      );
                                                      _model.stillStreaming =
                                                          false;
                                                      safeSetState(() {});
                                                    },
                                                    onDone: () async {
                                                      unawaited(
                                                        () async {
                                                          await ConversationsTable()
                                                              .update(
                                                            data: {
                                                              'last_message_at':
                                                                  supaSerialize<
                                                                          DateTime>(
                                                                      getCurrentTimestamp),
                                                            },
                                                            matchingRows:
                                                                (rows) => rows
                                                                    .eqOrNull(
                                                                      'id',
                                                                      _model
                                                                          .conversationId,
                                                                    )
                                                                    .eqOrNull(
                                                                      'user_id',
                                                                      currentUserUid,
                                                                    ),
                                                          );
                                                        }(),
                                                      );
                                                      unawaited(
                                                        () async {
                                                          await ConversationMessagesTable()
                                                              .insert({
                                                            'conversation_id':
                                                                _model
                                                                    .conversationId,
                                                            'content': functions
                                                                .convertListtoString(
                                                                    FFAppState()
                                                                        .messages
                                                                        .lastOrNull!
                                                                        .messages
                                                                        .toList()),
                                                            'role': FFAppState()
                                                                .messages
                                                                .lastOrNull
                                                                ?.role,
                                                            'openai_previous_response_id':
                                                                _model
                                                                    .previousRespnseId,
                                                          });
                                                        }(),
                                                      );
                                                    },
                                                  );
                                                }

                                                _shouldSetState = true;
                                                if (!(_model.apiResulthNext
                                                        ?.succeeded ??
                                                    true)) {
                                                  if (_shouldSetState)
                                                    safeSetState(() {});
                                                  return;
                                                }
                                              }
                                            }),
                                            Future(() async {
                                              if (_model.firstMessage) {
                                                await callAiAgent(
                                                  context: context,
                                                  prompt:
                                                      valueOrDefault<String>(
                                                    _model.userMessage,
                                                    'Untitled',
                                                  ),
                                                  threadId: random_data
                                                      .randomInteger(0, 10)
                                                      .toString(),
                                                  agentCloudFunctionName:
                                                      'coachTitleCreator',
                                                  provider: 'OPENAI',
                                                  agentJson: null,
                                                  responseType: 'PLAINTEXT',
                                                ).then((generatedText) {
                                                  safeSetState(() =>
                                                      _model.newTitle =
                                                          generatedText);
                                                });

                                                _shouldSetState = true;
                                                await ConversationsTable()
                                                    .update(
                                                  data: {
                                                    'title': _model.newTitle,
                                                  },
                                                  matchingRows: (rows) => rows
                                                      .eqOrNull(
                                                        'id',
                                                        _model.conversationId,
                                                      )
                                                      .eqOrNull(
                                                        'user_id',
                                                        currentUserUid,
                                                      ),
                                                );
                                                _model.conversationTitle =
                                                    _model.newTitle!;
                                                safeSetState(() {});
                                              }
                                            }),
                                          ]);
                                        } else {
                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        }

                                        if (_shouldSetState)
                                          safeSetState(() {});
                                      },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
