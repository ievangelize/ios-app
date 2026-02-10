import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_item_stream_model.dart';
export 'chat_item_stream_model.dart';

class ChatItemStreamWidget extends StatefulWidget {
  const ChatItemStreamWidget({
    super.key,
    this.message,
  });

  final MessageStruct? message;

  @override
  State<ChatItemStreamWidget> createState() => _ChatItemStreamWidgetState();
}

class _ChatItemStreamWidgetState extends State<ChatItemStreamWidget> {
  late ChatItemStreamModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatItemStreamModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.message?.role == 'user')
          Align(
            alignment: AlignmentDirectional(1.0, 0.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondary,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(14.0, 10.0, 14.0, 10.0),
                  child: Builder(
                    builder: (context) {
                      final messages =
                          widget.message?.messages.toList() ?? [];

                      return Wrap(
                        spacing: 0.0,
                        runSpacing: 0.0,
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        direction: Axis.horizontal,
                        runAlignment: WrapAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        clipBehavior: Clip.none,
                        children:
                            List.generate(messages.length, (messagesIndex) {
                          final messagesItem = messages[messagesIndex];
                          return SelectionArea(
                              child: Text(
                            messagesItem,
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
                                  color: FlutterFlowTheme.of(context).info,
                                  fontSize: 16.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                          ));
                        }),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        if ((widget.message?.role == 'assistant') &&
            (widget.message?.isHistory == false))
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
            child: custom_widgets.StreamMarkdown(
              width: double.infinity,
              height: 50.0,
              airesponse: functions
                  .convertListtoString(widget.message!.messages.toList()),
              resetOnNew: true,
            ),
          ),
        if ((widget.message?.role == 'assistant') &&
            (widget.message?.isHistory == true))
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(22.0, 14.0, 0.0, 0.0),
            child: Builder(
              builder: (context) {
                final messages = widget.message?.messages.toList() ?? [];

                return Wrap(
                  spacing: 0.0,
                  runSpacing: 0.0,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  direction: Axis.horizontal,
                  runAlignment: WrapAlignment.start,
                  verticalDirection: VerticalDirection.down,
                  clipBehavior: Clip.none,
                  children: List.generate(messages.length, (messagesIndex) {
                    final messagesItem = messages[messagesIndex];
                    return Container(
                      child: custom_widgets.CustomMarkdown(
                        width: 100.0,
                        height: 30.0,
                        fontSize: 16.0,
                        textColor: FlutterFlowTheme.of(context).primaryText,
                        blockquoteBackground:
                            FlutterFlowTheme.of(context).dfdfdf,
                        blockquoteTextColor:
                            FlutterFlowTheme.of(context).dfdfdf,
                        data: messagesItem,
                      ),
                    );
                  }),
                );
              },
            ),
          ),
      ].divide(SizedBox(height: 1.0)),
    );
  }
}
