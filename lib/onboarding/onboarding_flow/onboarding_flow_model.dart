import '/components/onboarding_asnwer/onboarding_asnwer_widget.dart';
import '/components/onboaring_btn/onboaring_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'onboarding_flow_widget.dart' show OnboardingFlowWidget;
import 'package:flutter/material.dart';

class OnboardingFlowModel extends FlutterFlowModel<OnboardingFlowWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel1;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel2;
  // State field(s) for Name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel3;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel4;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel5;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel6;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel7;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel8;
  // Model for onboaringBtn component.
  late OnboaringBtnModel onboaringBtnModel;

  @override
  void initState(BuildContext context) {
    onboardingAsnwerModel1 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel2 =
        createModel(context, () => OnboardingAsnwerModel());
    nameTextControllerValidator = _nameTextControllerValidator;
    onboardingAsnwerModel3 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel4 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel5 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel6 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel7 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel8 =
        createModel(context, () => OnboardingAsnwerModel());
    onboaringBtnModel = createModel(context, () => OnboaringBtnModel());
  }

  @override
  void dispose() {
    onboardingAsnwerModel1.dispose();
    onboardingAsnwerModel2.dispose();
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    onboardingAsnwerModel3.dispose();
    onboardingAsnwerModel4.dispose();
    onboardingAsnwerModel5.dispose();
    onboardingAsnwerModel6.dispose();
    onboardingAsnwerModel7.dispose();
    onboardingAsnwerModel8.dispose();
    onboaringBtnModel.dispose();
  }
}
