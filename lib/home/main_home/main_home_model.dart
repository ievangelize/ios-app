import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/appbar_home/appbar_home_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/index.dart';
import 'main_home_widget.dart' show MainHomeWidget;
import 'package:flutter/material.dart';

class MainHomeModel extends FlutterFlowModel<MainHomeWidget> {
  ///  Local state fields for this page.

  List<String> lockedLessonIds = [];
  void addToLockedLessonIds(String item) => lockedLessonIds.add(item);
  void removeFromLockedLessonIds(String item) => lockedLessonIds.remove(item);
  void removeAtIndexFromLockedLessonIds(int index) =>
      lockedLessonIds.removeAt(index);
  void insertAtIndexInLockedLessonIds(int index, String item) =>
      lockedLessonIds.insert(index, item);
  void updateLockedLessonIdsAtIndex(int index, Function(String) updateFn) =>
      lockedLessonIds[index] = updateFn(lockedLessonIds[index]);

  List<String> lessonIds = [];
  void addToLessonIds(String item) => lessonIds.add(item);
  void removeFromLessonIds(String item) => lessonIds.remove(item);
  void removeAtIndexFromLessonIds(int index) => lessonIds.removeAt(index);
  void insertAtIndexInLessonIds(int index, String item) =>
      lessonIds.insert(index, item);
  void updateLessonIdsAtIndex(int index, Function(String) updateFn) =>
      lessonIds[index] = updateFn(lessonIds[index]);

  List<String> ulpIds = [];
  void addToUlpIds(String item) => ulpIds.add(item);
  void removeFromUlpIds(String item) => ulpIds.remove(item);
  void removeAtIndexFromUlpIds(int index) => ulpIds.removeAt(index);
  void insertAtIndexInUlpIds(int index, String item) =>
      ulpIds.insert(index, item);
  void updateUlpIdsAtIndex(int index, Function(String) updateFn) =>
      ulpIds[index] = updateFn(ulpIds[index]);

  List<String> completedLessonIds = [];
  void addToCompletedLessonIds(String item) => completedLessonIds.add(item);
  void removeFromCompletedLessonIds(String item) =>
      completedLessonIds.remove(item);
  void removeAtIndexFromCompletedLessonIds(int index) =>
      completedLessonIds.removeAt(index);
  void insertAtIndexInCompletedLessonIds(int index, String item) =>
      completedLessonIds.insert(index, item);
  void updateCompletedLessonIdsAtIndex(int index, Function(String) updateFn) =>
      completedLessonIds[index] = updateFn(completedLessonIds[index]);

  String? scrollToCourseId;

  String? tags = 'all';

  bool recentActivity = false;

  bool friendList = false;

  String status = 'accepted';

  int tabIndex = 0;

  String shareMessage =
      'Hey, check out this evangelism app I’ve been using, iEvangelize. When you join, use my code so we can become friends on the app and grow together in evangelism.\n\nMy code: ';

  String downloadMessage =
      '\nDownload link: https://link.ievangelize.app/aFij/download';

  String prayerList = 'personal';

  String? encounterType;

  String? campaignID;

  ///  State fields for stateful widgets in this page.

  Stream<List<UsersRow>>? mainHomeSupabaseStream;
  // Stores action output result for [Backend Call - Query Rows] action in mainHome widget.
  List<FriendsRow>? friends;
  // Stores action output result for [Backend Call - Query Rows] action in mainHome widget.
  List<UserCampaignsRow>? campaigns;
  // Stores action output result for [Backend Call - Query Rows] action in mainHome widget.
  List<UserCourseProgressRow>? ucp;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for appbarHome component.
  late AppbarHomeModel appbarHomeModel;
  // State field(s) for encountersSearch widget.
  FocusNode? encountersSearchFocusNode;
  TextEditingController? encountersSearchTextController;
  String? Function(BuildContext, String?)?
      encountersSearchTextControllerValidator;
  // State field(s) for encounterChoiceChips widget.
  FormFieldController<List<String>>? encounterChoiceChipsValueController;
  String? get encounterChoiceChipsValue =>
      encounterChoiceChipsValueController?.value?.firstOrNull;
  set encounterChoiceChipsValue(String? val) =>
      encounterChoiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Custom Action - checkPushPermission] action in Container widget.
  bool? pushAllowed2;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController1;
  String? get choiceChipsValue1 =>
      choiceChipsValueController1?.value?.firstOrNull;
  set choiceChipsValue1(String? val) =>
      choiceChipsValueController1?.value = val != null ? [val] : [];
  // Stores action output result for [Custom Action - cupertinoConfirmationDialog] action in Container widget.
  bool? response;
  // Stores action output result for [Backend Call - API (Send Push Notification)] action in Button widget.
  ApiCallResponse? apiResultztj;
  // State field(s) for Search widget.
  FocusNode? searchFocusNode1;
  TextEditingController? searchTextController1;
  String? Function(BuildContext, String?)? searchTextController1Validator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController2;
  String? get choiceChipsValue2 =>
      choiceChipsValueController2?.value?.firstOrNull;
  set choiceChipsValue2(String? val) =>
      choiceChipsValueController2?.value = val != null ? [val] : [];
  // State field(s) for Search widget.
  FocusNode? searchFocusNode2;
  TextEditingController? searchTextController2;
  String? Function(BuildContext, String?)? searchTextController2Validator;
  // State field(s) for Search widget.
  FocusNode? searchFocusNode3;
  TextEditingController? searchTextController3;
  String? Function(BuildContext, String?)? searchTextController3Validator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController3;
  String? get choiceChipsValue3 =>
      choiceChipsValueController3?.value?.firstOrNull;
  set choiceChipsValue3(String? val) =>
      choiceChipsValueController3?.value = val != null ? [val] : [];
  // Stores action output result for [Custom Action - checkPushPermission] action in Container widget.
  bool? pushallowed;

  @override
  void initState(BuildContext context) {
    appbarHomeModel = createModel(context, () => AppbarHomeModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    appbarHomeModel.dispose();
    encountersSearchFocusNode?.dispose();
    encountersSearchTextController?.dispose();

    searchFocusNode1?.dispose();
    searchTextController1?.dispose();

    searchFocusNode2?.dispose();
    searchTextController2?.dispose();

    searchFocusNode3?.dispose();
    searchTextController3?.dispose();
  }
}
