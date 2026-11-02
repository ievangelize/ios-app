import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:scroll_to/scroll_to.dart';

class GlobalScrollService {
  static ScrollToController? controller;
  static final ValueNotifier<ScrollToController?> controllerNotifier =
      ValueNotifier(null);

  // ✅ Manual position registry
  static final Map<String, GlobalKey> keyRegistry = {};

  static void setController(ScrollToController c) {
    controller = c;
    controllerNotifier.value = c;
  }

  static void registerKey(String id, GlobalKey key) {
    keyRegistry[id] = key;
  }

  static void unregisterKey(String id) {
    keyRegistry.remove(id);
  }
}
