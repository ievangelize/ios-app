import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/form_item/form_item_widget.dart';
import '/components/large_btn/large_btn_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/actions/actions.dart' as action_blocks;
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'new_encounter_campaign_model.dart';
export 'new_encounter_campaign_model.dart';

class NewEncounterCampaignWidget extends StatefulWidget {
  const NewEncounterCampaignWidget({
    super.key,
    required this.campaign,
  });

  final CampaignsRow? campaign;

  static String routeName = 'newEncounterCampaign';
  static String routePath = 'newEncounterCampaign';

  @override
  State<NewEncounterCampaignWidget> createState() =>
      _NewEncounterCampaignWidgetState();
}

class _NewEncounterCampaignWidgetState
    extends State<NewEncounterCampaignWidget> {
  late NewEncounterCampaignModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription<bool> _keyboardVisibilitySubscription;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NewEncounterCampaignModel());

    logFirebaseEvent('screen_view',
        parameters: {'screen_name': 'newEncounterCampaign'});
    if (!isWeb) {
      _keyboardVisibilitySubscription =
          KeyboardVisibilityController().onChange.listen((bool visible) {
        safeSetState(() {
          _isKeyboardVisible = visible;
        });
      });
    }

    _model.encounterNumberTextController ??= TextEditingController();
    _model.encounterNumberFocusNode ??= FocusNode();
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
    context.watch<FFAppState>();

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
        List<FormsRow> newEncounterCampaignFormsRowList = snapshot.data!;

        final newEncounterCampaignFormsRow =
            newEncounterCampaignFormsRowList.isNotEmpty
                ? newEncounterCampaignFormsRowList.first
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
                  if (_model.pageViewCurrentIndex == 0) {
                    context.safePop();
                  } else if (_model.pageViewCurrentIndex == 1) {
                    await _model.pageViewController?.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  } else if (_model.pageViewCurrentIndex == 2) {
                    await _model.pageViewController?.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  } else {
                    await _model.pageViewController?.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
              title: Text(
                'Record an Ecounter',
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
              actions: [],
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
                        newEncounterCampaignFormsRow?.id,
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
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'How many people did you share\nthe Gospel with?',
                                            textAlign: TextAlign.center,
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
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Form(
                                              key: _model.formKey,
                                              autovalidateMode:
                                                  AutovalidateMode.disabled,
                                              child: Container(
                                                width: 300.0,
                                                child: TextFormField(
                                                  controller: _model
                                                      .encounterNumberTextController,
                                                  focusNode: _model
                                                      .encounterNumberFocusNode,
                                                  autofocus: false,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: false,
                                                    alignLabelWithHint: true,
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .blackWhite,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .blackWhite,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    errorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.0),
                                                    ),
                                                  ),
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
                                                        fontSize: 26.0,
                                                        letterSpacing: 5.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                  maxLength: 7,
                                                  maxLengthEnforcement:
                                                      MaxLengthEnforcement
                                                          .enforced,
                                                  buildCounter: (context,
                                                          {required currentLength,
                                                          required isFocused,
                                                          maxLength}) =>
                                                      null,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: _model
                                                      .encounterNumberTextControllerValidator
                                                      .asValidator(context),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp('[0-9]'))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                                formFieldItems.length,
                                                (formFieldItemsIndex) {
                                              final formFieldItemsItem =
                                                  formFieldItems[
                                                      formFieldItemsIndex];
                                              return wrapWithModel(
                                                model: _model.formItemModels
                                                    .getModel(
                                                  formFieldItemsItem.id!,
                                                  formFieldItemsIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: FormItemWidget(
                                                  key: Key(
                                                    'Key14d_${formFieldItemsItem.id!}',
                                                  ),
                                                  formField: formFieldItemsItem,
                                                ),
                                              );
                                            }).divide(SizedBox(height: 16.0)),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Would you like to be reminded to follow-up on this person?',
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
                                        Text(
                                          'Make sure youre notifcations are turned on',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                        ),
                                        FlutterFlowRadioButton(
                                          options: ['Yes', 'No'].toList(),
                                          onChanged: (val) async {
                                            safeSetState(() {});
                                            if (_model.radioButtonPrayValue ==
                                                'Yes') {
                                              await actions.setFCMToken();
                                              await UsersTable().update(
                                                data: {
                                                  'fcm_token':
                                                      FFAppState().fcmToken,
                                                },
                                                matchingRows: (rows) =>
                                                    rows.eqOrNull(
                                                  'id',
                                                  currentUserUid,
                                                ),
                                              );
                                            }
                                          },
                                          controller: _model
                                                  .radioButtonPrayValueController ??=
                                              FormFieldController<String>('No'),
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 30.0, 0.0, 0.0),
                                          child: Text(
                                            'Days',
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 0.0),
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 2.0),
                                                  child: FlutterFlowChoiceChips(
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
                                                        safeSetState(() => _model
                                                                .choiceChipsDayValues =
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .info,
                                                                fontSize: 16.0,
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
                                                          BorderRadius.circular(
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
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 16.0,
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
                                                          BorderRadius.circular(
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
                                              ].addToEnd(SizedBox(width: 12.0)),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 26.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Flexible(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Time',
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
                                                    InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        final _datePickedTime =
                                                            await showTimePicker(
                                                          context: context,
                                                          initialTime: TimeOfDay
                                                              .fromDateTime(
                                                                  getCurrentTimestamp),
                                                          builder:
                                                              (context, child) {
                                                            return wrapInMaterialTimePickerTheme(
                                                              context,
                                                              child!,
                                                              headerBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              headerForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                              headerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineLarge
                                                                              .fontStyle,
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
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              pickerForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              selectedDateTimeBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              selectedDateTimeForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                              actionButtonForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              iconSize: 24.0,
                                                            );
                                                          },
                                                        );
                                                        if (_datePickedTime !=
                                                            null) {
                                                          safeSetState(() {
                                                            _model.datePicked =
                                                                DateTime(
                                                              getCurrentTimestamp
                                                                  .year,
                                                              getCurrentTimestamp
                                                                  .month,
                                                              getCurrentTimestamp
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
                                                          safeSetState(() {
                                                            _model.datePicked =
                                                                getCurrentTimestamp;
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 50.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.0),
                                                          border: Border.all(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
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
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
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
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  dateTimeFormat(
                                                                    "jm",
                                                                    _model
                                                                        .datePicked,
                                                                    locale: FFLocalizations.of(
                                                                            context)
                                                                        .languageCode,
                                                                  ),
                                                                  '11:10 PM',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
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
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 10.0)),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 16.0)),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    await _model.pageViewController?.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                    if (_shouldSetState) safeSetState(() {});
                                    return;
                                  } else if (_model.pageViewCurrentIndex == 1) {
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
                                            (_model.formItemModels
                                                        .getValueForKey(
                                                      currentLoop1Item.id!,
                                                      (m) => m
                                                          .shortAnswerTextController
                                                          .text,
                                                    ) ==
                                                    null ||
                                                _model.formItemModels
                                                        .getValueForKey(
                                                      currentLoop1Item.id!,
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
                                          'longtext') {
                                        if (currentLoop1Item.isRequired! &&
                                            (_model.formItemModels
                                                        .getValueForKey(
                                                      currentLoop1Item.id!,
                                                      (m) => m
                                                          .paragraphTextController
                                                          .text,
                                                    ) ==
                                                    null ||
                                                _model.formItemModels
                                                        .getValueForKey(
                                                      currentLoop1Item.id!,
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
                                            !(_model.formItemModels
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
                                    await _model.pageViewController?.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                    if (_shouldSetState) safeSetState(() {});
                                    return;
                                  } else if (_model.pageViewCurrentIndex == 2) {
                                    if (_model.radioButtonPrayValue == 'No'
                                        ? true
                                        : false) {
                                      _model.addNotification = false;
                                      safeSetState(() {});
                                    } else {
                                      _model.pushAllowed =
                                          await actions.checkPushPermission();
                                      _shouldSetState = true;
                                      if (_model.pushAllowed!) {
                                        await _model.pageViewController
                                            ?.nextPage(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.ease,
                                        );
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      } else {
                                        safeSetState(() {
                                          _model.radioButtonPrayValueController
                                              ?.value = 'No';
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'You need to allow push notifications',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .info,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );
                                        if (_shouldSetState)
                                          safeSetState(() {});
                                        return;
                                      }
                                    }
                                  } else {
                                    _model.addNotification = true;
                                    safeSetState(() {});
                                  }

                                  _model.encounter =
                                      await ReachedTable().insert({
                                    'created_by': currentUserUid,
                                    'campaign_id': widget.campaign?.id,
                                    'group_id': widget.campaign?.groupId,
                                  });
                                  _shouldSetState = true;
                                  if (_model.addNotification) {
                                    _model.deviceTimeZone =
                                        await actions.getTimeZone();
                                    _shouldSetState = true;
                                    await ScheduledNotificationsTable().insert({
                                      'reached_id': _model.encounter?.id,
                                      'user_id': currentUserUid,
                                      'title': 'Prayer Reminder',
                                      'body':
                                          'Pray for ${_model.encounter?.name}',
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
                                      'wednesday': _model.choiceChipsDayValues!
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
                                              .contains('Sat')
                                          ? true
                                          : false,
                                      'sunday': _model.choiceChipsDayValues!
                                              .contains('Sun')
                                          ? true
                                          : false,
                                    });
                                    await ReachedTable().update(
                                      data: {
                                        'pray_reminder': true,
                                      },
                                      matchingRows: (rows) => rows.eqOrNull(
                                        'id',
                                        _model.encounter?.id,
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
                                      _model.newEncounter2 =
                                          await EncounterFieldValuesTable()
                                              .insert({
                                        'encounter_id': _model.encounter?.id,
                                        'form_field_id': currentLoop2Item.id,
                                        'value_text': _model.formItemModels
                                            .getValueForKey(
                                          currentLoop2Item.id!,
                                          (m) =>
                                              m.shortAnswerTextController.text,
                                        ),
                                      });
                                      _shouldSetState = true;
                                      if (currentLoop2Item.isPrimaryDisplay!) {
                                        await ReachedTable().update(
                                          data: {
                                            'Name':
                                                _model.newEncounter2?.valueText,
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            _model.encounter?.id,
                                          ),
                                        );
                                      }
                                    } else if (currentLoop2Item.fieldType ==
                                        'longtext') {
                                      _model.newEncounter3 =
                                          await EncounterFieldValuesTable()
                                              .insert({
                                        'encounter_id': _model.encounter?.id,
                                        'form_field_id': currentLoop2Item.id,
                                        'value_text': _model.formItemModels
                                            .getValueForKey(
                                          currentLoop2Item.id!,
                                          (m) => m.paragraphTextController.text,
                                        ),
                                      });
                                      _shouldSetState = true;
                                      if (currentLoop2Item.isPrimaryDisplay!) {
                                        await ReachedTable().update(
                                          data: {
                                            'Name':
                                                _model.newEncounter3?.valueText,
                                          },
                                          matchingRows: (rows) => rows.eqOrNull(
                                            'id',
                                            _model.encounter?.id,
                                          ),
                                        );
                                      }
                                    } else if (currentLoop2Item.fieldType ==
                                        'multi-select') {
                                      _model.newEncounter1 =
                                          await EncounterFieldValuesTable()
                                              .insert({
                                        'encounter_id': _model.encounter?.id,
                                        'form_field_id': currentLoop2Item.id,
                                      });
                                      _shouldSetState = true;
                                      for (int loop3Index = 0;
                                          loop3Index <
                                              _model.formItemModels
                                                  .getValueForKey(
                                                    currentLoop2Item.id!,
                                                    (m) => m.dropDownValue,
                                                  )!
                                                  .length;
                                          loop3Index++) {
                                        final currentLoop3Item = _model
                                            .formItemModels
                                            .getValueForKey(
                                          currentLoop2Item.id!,
                                          (m) => m.dropDownValue,
                                        )![loop3Index];
                                        await EncounterFieldValueOptionsTable()
                                            .insert({
                                          'encounter_field_value_id':
                                              _model.newEncounter1?.id,
                                          'field_option_id': currentLoop3Item,
                                        });
                                      }
                                    } else {
                                      await EncounterFieldValuesTable().insert({
                                        'encounter_id': _model.encounter?.id,
                                        'form_field_id': currentLoop2Item.id,
                                        'value_boolean': _model.formItemModels
                                            .getValueForKey(
                                          currentLoop2Item.id!,
                                          (m) => m.switchValue,
                                        ),
                                      });
                                    }
                                  }
                                  FFAppState().clearEncountersCache();
                                  unawaited(
                                    () async {
                                      await XpEventsTable().insert({
                                        'user_id': currentUserUid,
                                        'delta': 50,
                                        'reason': 'new encounter',
                                        'idempotency_key': _model.encounter?.id,
                                        'share_with_friends': true,
                                      });
                                    }(),
                                  );
                                  unawaited(
                                    () async {
                                      await action_blocks
                                          .sendFriendNotification(
                                        context,
                                        eventType: 'new encounter',
                                      );
                                    }(),
                                  );
                                  await action_blocks.calculateStreak(context);

                                  context.goNamed(
                                    EncounterCompleteWidget.routeName,
                                    queryParameters: {
                                      'encounterXp': serializeParam(
                                        50,
                                        ParamType.int,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      '__transition_info__': TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 0),
                                      ),
                                    },
                                  );

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
