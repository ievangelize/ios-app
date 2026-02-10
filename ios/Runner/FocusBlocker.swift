import Foundation
import FamilyControls
import ManagedSettings
import DeviceActivity

class FocusBlocker {

  static let shared = FocusBlocker()

  let store = ManagedSettingsStore()
  var selection = FamilyActivitySelection()

  func requestPermission(completion: @escaping (Bool) -> Void) {
    Task {
      do {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        completion(true)
      } catch {
        completion(false)
      }
    }
  }

  func blockApps() {
    store.shield.applications = selection.applicationTokens
  }

  func unblockApps() {
    store.shield.applications = nil
  }
}
