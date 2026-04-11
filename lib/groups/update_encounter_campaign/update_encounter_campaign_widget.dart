import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/form_item_options/form_item_options_widget.dart';
import '/components/form_item_update/form_item_update_widget.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'update_encounter_campaign_model.dart';
export 'update_encounter_campaign_model.dart';

class UpdateEncounterCampaignWidget extends StatefulWidget {
  const UpdateEncounterCampaignWidget({
    super.key,
    required this.campaign,
    required this.encounter,
  });

  final CampaignsRow? campaign;
  final ReachedRow? encounter;

  static String routeName = 'updateEncounterCampaign';
  static String routePath = 'updateEncounterCampaign';

  @override
  State<UpdateEncounterCampaignWidget> createState() =>
      _UpdateEncounterCampaignWidgetState();
}

class _UpdateEncounterCampaignWidgetState
    extends State<UpdateEncounterCampaignWidget> {
  late UpdateEncounterCampaignModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UpdateEncounterCampaignModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'updateEncounterCampaign'});
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
    _model.dispose();

    if (!isWeb) {
      _keyboardVisibilitySubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FormsRow>>(
      future: FormsTable().querySingleRow(
        queryFn: (q) => q.eqOrNull(
          'campaign_id',
          widget.campaign?.id,
        ),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: SpinKitFadingCircle(
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 20.0,
                ),
              ),
            ),
          );
        }
        List<FormsRow> updateEncounterCampaignFormsRowList = snapshot.data!;

        final updateEncounterCampaignFormsRow =
            updateEncounterCampaignFormsRowList.isNotEmpty
                ? updateEncounterCampaignFormsRowList.first
                : null;

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
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 25.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
              title: Text(
                'Update an Ecounter',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                        _model.response =
                            await actions.cupertinoConfirmationDialog(
                          context,
                          'Delete encounter?',
                          'This can\'t be undone.',
                          'Cancel',
                          'Delete',
                          FlutterFlowTheme.of(context).error,
                          FlutterFlowTheme.of(context).secondary,
                        );
                        if (_model.response!) {
                          await ReachedTable().delete(
                            matchingRows: (rows) => rows.eqOrNull(
                              'id',
                              widget.encounter?.id,
                            ),
                          );
                          FFAppState().clearEncountersCache();

                          context.goNamed(
                            EncountersListWidget.routeName,
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
                                  title: Text('Delete encounter?'),
                                  content: Text('This can\'t be undone.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, false),
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          alertDialogContext, true),
                                      child: Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;
                        if (confirmDialogResponse) {
                          await ReachedTable().delete(
                            matchingRows: (rows) => rows.eqOrNull(
                              'id',
                              widget.encounter?.id,
                            ),
                          );
                          FFAppState().clearEncountersCache();

                          context.goNamed(
                            EncountersListWidget.routeName,
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
                      FontAwesomeIcons.trashAlt,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 25.0,
                    ),
                  ),
                ),
              ],
              centerTitle: true,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: FutureBuilder<List<FormFieldsRow>>(
                future: FormFieldsTable().queryRows(
                  queryFn: (q) => q
                      .eqOrNull(
                        'form_id',
                        updateEncounterCampaignFormsRow?.id,
                      )
                      .order('sort_order', ascending: true),
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: SpinKitFadingCircle(
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                      ),
                    );
                  }
                  List<FormFieldsRow> containerFormFieldsRowList =
                      snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 50.0),
                              child: PageView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: _model.pageViewController ??=
                                    PageController(initialPage: 0),
                                onPageChanged: (_) => safeSetState(() {}),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 38.0, 16.0, 0.0),
                                    child: Builder(
                                      builder: (context) {
                                        final formFieldItems =
                                            containerFormFieldsRowList.toList();

                                        return SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: List.generate(
                                                formFieldItems.length,
                                                (formFieldItemsIndex) {
                                              final formFieldItemsItem =
                                                  formFieldItems[
                                                      formFieldItemsIndex];
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (formFieldItemsItem
                                                          .fieldType !=
                                                      'multi-select')
                                                    Expanded(
                                                      child: wrapWithModel(
                                                        model: _model
                                                            .formItemUpdateModels
                                                            .getModel(
                                                          formFieldItemsItem.id,
                                                          formFieldItemsIndex,
                                                        ),
                                                        updateCallback: () =>
                                                            safeSetState(() {}),
                                                        child:
                                                            FormItemUpdateWidget(
                                                          key: Key(
                                                            'Keyvl4_${formFieldItemsItem.id}',
                                                          ),
                                                          formField:
                                                              formFieldItemsItem,
                                                          encounter: widget
                                                              .encounter!,
                                                        ),
                                                      ),
                                                    ),
                                                  if (formFieldItemsItem
                                                          .fieldType ==
                                                      'multi-select')
                                                    wrapWithModel(
                                                      model: _model
                                                          .formItemOptionsModels
                                                          .getModel(
                                                        formFieldItemsItem.id,
                                                        formFieldItemsIndex,
                                                      ),
                                                      updateCallback: () =>
                                                          safeSetState(() {}),
                                                      child:
                                                          FormItemOptionsWidget(
                                                        key: Key(
                                                          'Keyx2u_${formFieldItemsItem.id}',
                                                        ),
                                                        formField:
                                                            formFieldItemsItem,
                                                        encounter:
                                                            widget.encounter!,
                                                        changePageState:
                                                            (fieldOptionIDs) async {},
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Would you like to be reminded to pray for this person?',
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
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        FlutterFlowRadioButton(
                                          options: ['Yes', 'No'].toList(),
                                          onChanged: (val) async {
                                            safeSetState(() {});
                                            if (_model.radioButtonPrayValue ==
                                                'Yes') {
                                              await actions.setFCMToken();
                                              _model.pushAllowed = await actions
                                                  .checkPushPermission();
                                              if (!_model.pushAllowed!) {
                                                safeSetState(() {
                                                  _model
                                                      .radioButtonPrayValueController
                                                      ?.value = 'No';
                                                });
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'You need to allow push notifications',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                          controller: _model
                                                  .radioButtonPrayValueController ??=
                                              FormFieldController<String>(
                                                  widget.encounter!
                                                          .prayReminder!
                                                      ? 'Yes'
                                                      : 'No'),
                                          optionHeight: 32.0,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                          selectedTextStyle: FlutterFlowTheme
                                                  .of(context)
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
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                          buttonPosition:
                                              RadioButtonPosition.left,
                                          direction: Axis.vertical,
                                          radioButtonColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          inactiveRadioButtonColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          toggleable: false,
                                          horizontalAlignment:
                                              WrapAlignment.start,
                                          verticalAlignment:
                                              WrapCrossAlignment.start,
                                        ),
                                      ].divide(SizedBox(height: 16.0)),
                                    ),
                                  ),
                                  FutureBuilder<
                                      List<ScheduledNotificationsRow>>(
                                    future: ScheduledNotificationsTable()
                                        .querySingleRow(
                                      queryFn: (q) => q
                                          .eqOrNull(
                                            'user_id',
                                            currentUserUid,
                                          )
                                          .eqOrNull(
                                            'reached_id',
                                            widget.encounter?.id,
                                          ),
                                    ),
                                    builder: (context, snapshot) {
                                      // Customize what your widget looks like when it's loading.
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: SizedBox(
                                            width: 20.0,
                                            height: 20.0,
                                            child: SpinKitFadingCircle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 20.0,
                                            ),
                                          ),
                                        );
                                      }
                                      List<ScheduledNotificationsRow>
                                          containerScheduledNotificationsRowList =
                                          snapshot.data!;

                                      // Return an empty Container when the item does not exist.
                                      if (snapshot.data!.isEmpty) {
                                        return Container();
                                      }
                                      final containerScheduledNotificationsRow =
                                          containerScheduledNotificationsRowList
                                                  .isNotEmpty
                                              ? containerScheduledNotificationsRowList
                                                  .first
                                              : null;

                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                textScaler:
                                                    MediaQuery.of(context)
                                                        .textScaler,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Currently:    ',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            fontSize: 14.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        containerScheduledNotificationsRow!
                                                                .monday!
                                                            ? 'Mon, '
                                                            : '',
                                                        'Mon, ',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        containerScheduledNotificationsRow
                                                                .tuesday!
                                                            ? 'Tue, '
                                                            : '',
                                                        'Tue, ',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        containerScheduledNotificationsRow
                                                                .wednesday!
                                                            ? 'Wed, '
                                                            : '',
                                                        'Wed, ',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        containerScheduledNotificationsRow
                                                                .thursday!
                                                            ? 'Thur, '
                                                            : '',
                                                        'Thur, ',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        containerScheduledNotificationsRow
                                                                .friday!
                                                            ? 'Fri, '
                                                            : '',
                                                        'Fri, ',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        containerScheduledNotificationsRow
                                                                .saturday!
                                                            ? 'Sat, '
                                                            : '',
                                                        'Sat, ',
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: valueOrDefault<
                                                          String>(
                                                        containerScheduledNotificationsRow
                                                                .sunday!
                                                            ? 'Sun'
                                                            : '',
                                                        'Sun',
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                      ),
                                                    )
                                                  ],
                                                  style: FlutterFlowTheme.of(
                                                          context)
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
                                                        fontSize: 16.0,
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
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 34.0, 0.0, 0.0),
                                                child: Text(
                                                  'Days',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        fontSize: 18.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  12.0,
                                                                  0.0,
                                                                  0.0),
                                                      child:
                                                          FlutterFlowChoiceChips(
                                                        options: [
                                                          ChipData('Mon'),
                                                          ChipData('Tue'),
                                                          ChipData('Wed'),
                                                          ChipData('Thu'),
                                                          ChipData('Fri'),
                                                          ChipData('Sat'),
                                                          ChipData('Sun')
                                                        ],
                                                        onChanged: (val) =>
                                                            safeSetState(() =>
                                                                _model.choiceChipsDayValues =
                                                                    val),
                                                        selectedChipStyle:
                                                            ChipStyle(
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                          iconColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .info,
                                                          iconSize: 14.0,
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        unselectedChipStyle:
                                                            ChipStyle(
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                          iconColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          iconSize: 16.0,
                                                          elevation: 0.0,
                                                          borderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryText,
                                                          borderWidth: 0.7,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        chipSpacing: 20.0,
                                                        rowSpacing: 12.0,
                                                        multiselect: true,
                                                        initialized: _model
                                                                .choiceChipsDayValues !=
                                                            null,
                                                        alignment: WrapAlignment
                                                            .spaceBetween,
                                                        controller: _model
                                                                .choiceChipsDayValueController ??=
                                                            FormFieldController<
                                                                List<String>>(
                                                          [],
                                                        ),
                                                        wrapped: false,
                                                      ),
                                                    ),
                                                  ].addToEnd(
                                                      SizedBox(width: 12.0)),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 26.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Time',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              final _datePickedTime =
                                                                  await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime: TimeOfDay.fromDateTime(
                                                                    (containerScheduledNotificationsRow
                                                                            .scheduledAt ??
                                                                        DateTime
                                                                            .now())),
                                                                builder:
                                                                    (context,
                                                                        child) {
                                                                  return wrapInMaterialTimePickerTheme(
                                                                    context,
                                                                    child!,
                                                                    headerBackgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    headerForegroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .info,
                                                                    headerTextStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              32.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineLarge
                                                                              .fontStyle,
                                                                        ),
                                                                    pickerBackgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    pickerForegroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    selectedDateTimeBackgroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                    selectedDateTimeForegroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .info,
                                                                    actionButtonForegroundColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                    iconSize:
                                                                        24.0,
                                                                  );
                                                                },
                                                              );
                                                              if (_datePickedTime !=
                                                                  null) {
                                                                safeSetState(
                                                                    () {
                                                                  _model.datePicked =
                                                                      DateTime(
                                                                    (containerScheduledNotificationsRow.scheduledAt ??
                                                                            DateTime.now())
                                                                        .year,
                                                                    (containerScheduledNotificationsRow.scheduledAt ??
                                                                            DateTime.now())
                                                                        .month,
                                                                    (containerScheduledNotificationsRow.scheduledAt ??
                                                                            DateTime.now())
                                                                        .day,
                                                                    _datePickedTime
                                                                        .hour,
                                                                    _datePickedTime
                                                                        .minute,
                                                                  );
                                                                });
                                                              } else if (_model
                                                                      .datePicked !=
                                                                  null) {
                                                                safeSetState(
                                                                    () {
                                                                  _model.datePicked =
                                                                      containerScheduledNotificationsRow
                                                                          .scheduledAt;
                                                                });
                                                              }
                                                            },
                                                            child: Container(
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                border:
                                                                    Border.all(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'Pick a time',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        dateTimeFormat(
                                                                          "jm",
                                                                          _model
                                                                              .datePicked,
                                                                          locale:
                                                                              FFLocalizations.of(context).languageCode,
                                                                        ),
                                                                        '10:30 PM',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.inter(
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 10.0)),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(width: 16.0)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (!(isWeb
                            ? MediaQuery.viewInsetsOf(context).bottom > 0
                            : _isKeyboardVisible))
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 10.0, 16.0, 12.0),
                            child: wrapWithModel(
                              model: _model.largeBtnModel,
                              updateCallback: () => safeSetState(() {}),
                              child: LargeBtnWidget(
                                text: 'Done',
                                color: FlutterFlowTheme.of(context).secondary,
                                textColor: FlutterFlowTheme.of(context).info,
                                action: () async {
                                  var _shouldSetState = false;
                                  if (_model.pageViewCurrentIndex == 0) {
                                    for (int loop1Index = 0;
                                        loop1Index <
                                            containerFormFieldsRowList.length;
                                        loop1Index++) {
                                      final currentLoop1Item =
                                          containerFormFieldsRowList[
                                              loop1Index];
                                      if (currentLoop1Item.fieldType ==
                                          'text') {
                                        if (currentLoop1Item.isRequired! &&
                                            (_model.formItemUpdateModels
                                                        .getValueForKey(
                                                      currentLoop1Item.id,
                                                      (m) => m
                                                          .shortAnswerTextController
                                                          .text,
                                                    ) ==
                                                    null ||
                                                _model.formItemUpdateModels
                                                        .getValueForKey(
                                                      currentLoop1Item.id,
                                                      (m) => m
                                                          .shortAnswerTextController
                                                          .text,
                                                    ) ==
                                                    '')) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'You\'re missing some fields',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        }
                                      } else if (currentLoop1Item.fieldType ==
                                          'text') {
                                        if (currentLoop1Item.isRequired! &&
                                            (_model.formItemUpdateModels
                                                        .getValueForKey(
                                                      currentLoop1Item.id,
                                                      (m) => m
                                                          .paragraphTextController
                                                          .text,
                                                    ) ==
                                                    null ||
                                                _model.formItemUpdateModels
                                                        .getValueForKey(
                                                      currentLoop1Item.id,
                                                      (m) => m
                                                          .paragraphTextController
                                                          .text,
                                                    ) ==
                                                    '')) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'You\'re missing some fields',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        }
                                      } else {
                                        if (currentLoop1Item.isRequired! &&
                                            !(_model.formItemOptionsModels
                                                .getValues(
                                                  (m) => m.dropDownValue,
                                                )
                                                .isNotEmpty)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'You\'re missing some fields',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                          if (_shouldSetState)
                                            safeSetState(() {});
                                          return;
                                        }
                                      }
                                    }
                                    await actions.hideKeyboard();
                                    if (widget.encounter?.prayReminder == true
                                        ? true
                                        : false) {
                                      await _model.pageViewController?.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                  } else if (_model.pageViewCurrentIndex == 1) {
                                    await actions.hideKeyboard();
                                    if (_model.radioButtonPrayValue == 'No'
                                        ? true
                                        : false) {
                                      await ReachedTable().update(
                                        data: {
                                          'pray_reminder': false,
                                        },
                                        matchingRows: (rows) => rows
                                            .eqOrNull(
                                              'id',
                                              widget.encounter?.id,
                                            )
                                            .eqOrNull(
                                              'created_by',
                                              currentUserUid,
                                            ),
                                      );
                                    } else {
                                      await _model.pageViewController?.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                      if (_shouldSetState) safeSetState(() {});
                                      return;
                                    }
                                  } else {
                                    _model.deviceTimeZone =
                                        await actions.getTimeZone();
                                    _shouldSetState = true;
                                    await ScheduledNotificationsTable().update(
                                      data: {
                                        'user_id': currentUserUid,
                                        'title': 'Prayer reminder',
                                        'body':
                                            'Hey, remeber to pray for ${widget.encounter?.name}',
                                        'timezone': _model.deviceTimeZone,
                                        'scheduled_at': supaSerialize<DateTime>(
                                            _model.datePicked),
                                        'monday': _model.choiceChipsDayValues!
                                                .contains('Mon')
                                            ? true
                                            : false,
                                        'tuesday': _model.choiceChipsDayValues!
                                                .contains('Tue')
                                            ? true
                                            : false,
                                        'wednesday': _model
                                                .choiceChipsDayValues!
                                                .contains('Wed')
                                            ? true
                                            : false,
                                        'thursday': _model.choiceChipsDayValues!
                                                .contains('Thur')
                                            ? true
                                            : false,
                                        'friday': _model.choiceChipsDayValues!
                                                .contains('Fri')
                                            ? true
                                            : false,
                                        'saturday': _model.choiceChipsDayValues!
                                                .contains('Fri')
                                            ? true
                                            : false,
                                        'sunday': _model.choiceChipsDayValues!
                                                .contains('Sun')
                                            ? true
                                            : false,
                                      },
                                      matchingRows: (rows) => rows.eqOrNull(
                                        'reached_id',
                                        widget.encounter?.id,
                                      ),
                                    );
                                  }

                                  for (int loop2Index = 0;
                                      loop2Index <
                                          containerFormFieldsRowList.length;
                                      loop2Index++) {
                                    final currentLoop2Item =
                                        containerFormFieldsRowList[loop2Index];
                                    if (currentLoop2Item.fieldType == 'text') {
                                      await EncounterFieldValuesTable().update(
                                        data: {
                                          'value_text': _model
                                              .formItemUpdateModels
                                              .getValueForKey(
                                            currentLoop2Item.id,
                                            (m) => m
                                                .shortAnswerTextController.text,
                                          ),
                                        },
                                        matchingRows: (rows) => rows
                                            .eqOrNull(
                                              'encounter_id',
                                              widget.encounter?.id,
                                            )
                                            .eqOrNull(
                                              'form_field_id',
                                              currentLoop2Item.id,
                                            ),
                                      );
                                      _shouldSetState = true;
                                      if (currentLoop2Item.isPrimaryDisplay) {
                                        await ReachedTable().update(
                                          data: {
                                            'Name': _model.updatedEncounter1
                                                ?.firstOrNull?.valueText,
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            widget.encounter?.id,
                                          ),
                                        );
                                      }
                                    } else if (currentLoop2Item.fieldType ==
                                        'text') {
                                      await EncounterFieldValuesTable().update(
                                        data: {
                                          'value_text': _model
                                              .formItemUpdateModels
                                              .getValueForKey(
                                            currentLoop2Item.id,
                                            (m) =>
                                                m.paragraphTextController.text,
                                          ),
                                        },
                                        matchingRows: (rows) => rows
                                            .eqOrNull(
                                              'encounter_id',
                                              widget.encounter?.id,
                                            )
                                            .eqOrNull(
                                              'form_field_id',
                                              currentLoop2Item.id,
                                            ),
                                      );
                                      _shouldSetState = true;
                                      if (currentLoop2Item.isPrimaryDisplay) {
                                        await ReachedTable().update(
                                          data: {
                                            'Name': _model.updatedEncounter2
                                                ?.firstOrNull?.valueText,
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            widget.encounter?.id,
                                          ),
                                        );
                                      }
                                    } else if (currentLoop2Item.fieldType ==
                                        'multi-select') {
                                      _model.encounterField =
                                          await EncounterFieldValuesTable()
                                              .queryRows(
                                        queryFn: (q) => q
                                            .eqOrNull(
                                              'encounter_id',
                                              widget.encounter?.id,
                                            )
                                            .eqOrNull(
                                              'form_field_id',
                                              currentLoop2Item.id,
                                            ),
                                      );
                                      _shouldSetState = true;
                                      await EncounterFieldValueOptionsTable()
                                          .delete(
                                        matchingRows: (rows) => rows.eqOrNull(
                                          'encounter_field_value_id',
                                          _model
                                              .encounterField?.firstOrNull?.id,
                                        ),
                                      );
                                      for (int loop3Index = 0;
                                          loop3Index <
                                              _model.formItemOptionsModels
                                                  .getValueForKey(
                                                    currentLoop2Item.id,
                                                    (m) => m.dropDownValue,
                                                  )!
                                                  .length;
                                          loop3Index++) {
                                        final currentLoop3Item = _model
                                            .formItemOptionsModels
                                            .getValueForKey(
                                          currentLoop2Item.id,
                                          (m) => m.dropDownValue,
                                        )![loop3Index];
                                        await EncounterFieldValueOptionsTable()
                                            .insert({
                                          'encounter_field_value_id': _model
                                              .encounterField?.firstOrNull?.id,
                                          'field_option_id': currentLoop3Item,
                                        });
                                      }
                                    } else {
                                      await EncounterFieldValuesTable().update(
                                        data: {
                                          'value_boolean': _model
                                              .formItemUpdateModels
                                              .getValueForKey(
                                            currentLoop2Item.id,
                                            (m) => m.switchValue,
                                          ),
                                        },
                                        matchingRows: (rows) => rows
                                            .eqOrNull(
                                              'encounter_id',
                                              widget.encounter?.id,
                                            )
                                            .eqOrNull(
                                              'form_field_id',
                                              currentLoop2Item.id,
                                            ),
                                      );
                                    }
                                  }
                                  await ReachedTable().update(
                                    data: {
                                      'updated_at': supaSerialize<DateTime>(
                                          getCurrentTimestamp),
                                    },
                                    matchingRows: (rows) => rows.eqOrNull(
                                      'id',
                                      widget.encounter?.id,
                                    ),
                                  );

                                  context
                                      .goNamed(EncountersListWidget.routeName);

                                  if (_shouldSetState) safeSetState(() {});
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
