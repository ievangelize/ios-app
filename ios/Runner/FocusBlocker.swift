import Foundation
import FamilyControls
import ManagedSettings

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
    DispatchQueue.main.async {
      // Defensive: don't try to block if nothing selected
      guard !self.selection.applicationTokens.isEmpty else { return }
      self.store.shield.applications = self.selection.applicationTokens
    }
  }

  func unblockApps() {
    DispatchQueue.main.async {
      self.store.shield.applications = nil
    }
  }
}
