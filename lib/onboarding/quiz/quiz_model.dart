import '/components/onboarding_asnwer/onboarding_asnwer_widget.dart';
import '/components/onboarding_asnwer_multi/onboarding_asnwer_multi_widget.dart';
import '/components/onboaring_btn/onboaring_btn_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'quiz_widget.dart' show QuizWidget;
import 'package:flutter/material.dart';

class QuizModel extends FlutterFlowModel<QuizWidget> {
  ///  Local state fields for this page.

  List<int> pagesNumbers = [
    1,
    2,
    4,
    5,
    6,
    7,
    9,
    10,
    12,
    13,
    14,
    15,
    16,
    18,
    19,
    20
  ];
  void addToPagesNumbers(int item) => pagesNumbers.add(item);
  void removeFromPagesNumbers(int item) => pagesNumbers.remove(item);
  void removeAtIndexFromPagesNumbers(int index) => pagesNumbers.removeAt(index);
  void insertAtIndexInPagesNumbers(int index, int item) =>
      pagesNumbers.insert(index, item);
  void updatePagesNumbersAtIndex(int index, Function(int) updateFn) =>
      pagesNumbers[index] = updateFn(pagesNumbers[index]);

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
  late OnboardingAsnwerModel onboardingAsnwerModel2;
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
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel9;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel10;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel11;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel12;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel13;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel14;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel15;
  // Model for onboardingAsnwerMulti component.
  late OnboardingAsnwerMultiModel onboardingAsnwerMultiModel;
  // Model for onboardingAsnwer component.
  late OnboardingAsnwerModel onboardingAsnwerModel16;
  // Model for onboaringBtn component.
  late OnboaringBtnModel onboaringBtnModel;

  @override
  void initState(BuildContext context) {
    onboardingAsnwerModel1 =
        createModel(context, () => OnboardingAsnwerModel());
    nameTextControllerValidator = _nameTextControllerValidator;
    onboardingAsnwerModel2 =
        createModel(context, () => OnboardingAsnwerModel());
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
    onboardingAsnwerModel9 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel10 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel11 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel12 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel13 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel14 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerModel15 =
        createModel(context, () => OnboardingAsnwerModel());
    onboardingAsnwerMultiModel =
        createModel(context, () => OnboardingAsnwerMultiModel());
    onboardingAsnwerModel16 =
        createModel(context, () => OnboardingAsnwerModel());
    onboaringBtnModel = createModel(context, () => OnboaringBtnModel());
  }

  @override
  void dispose() {
    onboardingAsnwerModel1.dispose();
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    onboardingAsnwerModel2.dispose();
    onboardingAsnwerModel3.dispose();
    onboardingAsnwerModel4.dispose();
    onboardingAsnwerModel5.dispose();
    onboardingAsnwerModel6.dispose();
    onboardingAsnwerModel7.dispose();
    onboardingAsnwerModel8.dispose();
    onboardingAsnwerModel9.dispose();
    onboardingAsnwerModel10.dispose();
    onboardingAsnwerModel11.dispose();
    onboardingAsnwerModel12.dispose();
    onboardingAsnwerModel13.dispose();
    onboardingAsnwerModel14.dispose();
    onboardingAsnwerModel15.dispose();
    onboardingAsnwerMultiModel.dispose();
    onboardingAsnwerModel16.dispose();
    onboaringBtnModel.dispose();
  }
}
