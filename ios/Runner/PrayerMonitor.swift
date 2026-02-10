import DeviceActivity
import ManagedSettings

class PrayerMonitor: DeviceActivityMonitor {

  let store = ManagedSettingsStore()

  override func intervalDidStart(for activity: DeviceActivityName) {
    store.shield.applications = FocusBlocker.shared.selection.applicationTokens
  }

  override func intervalDidEnd(for activity: DeviceActivityName) {
    store.shield.applications = nil
  }
}
