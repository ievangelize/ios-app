import UIKit
import Flutter
import AVFoundation
import FamilyControls
import ManagedSettings
import DeviceActivity
import SwiftUI
import BackgroundTasks

// ================================
// FocusBlocker Class - Enhanced with Timer
// ================================
@available(iOS 15.0, *)
class FocusBlocker {
  static let shared = FocusBlocker()
  let store = ManagedSettingsStore()
  var selection = FamilyActivitySelection()
  
  // UserDefaults keys
  private let lockActiveKey = "PrayerLockActive"
  private let unlockUntilKey = "UnlockUntilTimestamp"
  
  private init() {}
  
  // MARK: - Permission
  @available(iOS 16.0, *)
  func requestPermission(completion: @escaping (Bool) -> Void) {
    Task {
      do {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
        completion(true)
      } catch {
        print("❌ Permission denied: \(error)")
        completion(false)
      }
    }
  }
  
  // MARK: - Lock Apps (Permanent until unlocked)
  func blockApps() {
    DispatchQueue.main.async {
      guard !self.selection.applicationTokens.isEmpty else {
        print("⚠️ No apps selected to block")
        return
      }
      
      // Apply shield
      self.store.shield.applications = self.selection.applicationTokens
      
      // Save state
      UserDefaults.standard.set(true, forKey: self.lockActiveKey)
      UserDefaults.standard.removeObject(forKey: self.unlockUntilKey)
      
      // Cancel any pending background tasks
      BGTaskScheduler.shared.cancel(taskRequestWithIdentifier: "com.tinochiwara.ievangelize.relock")
      
      print("🔒 Apps locked permanently")
    }
  }
  
  // MARK: - Unlock Temporarily (with timer)
  func unlockTemporarily(durationMinutes: Int) {
    DispatchQueue.main.async {
      // Remove shield
      self.store.shield.applications = nil
      
      // Calculate unlock expiration time
      let unlockUntil = Date().addingTimeInterval(TimeInterval(durationMinutes * 60))
      
      // Save state
      UserDefaults.standard.set(false, forKey: self.lockActiveKey)
      UserDefaults.standard.set(unlockUntil.timeIntervalSince1970, forKey: self.unlockUntilKey)
      
      print("🔓 Apps unlocked for \(durationMinutes) minutes (until \(unlockUntil))")
      
      // Schedule background task to re-lock
      self.scheduleRelockTask(at: unlockUntil)
    }
  }
  
  // MARK: - Check if unlock period expired and re-lock if needed
  func checkAndRelockIfNeeded() {
    guard let unlockTimestamp = UserDefaults.standard.object(forKey: unlockUntilKey) as? TimeInterval else {
      // No unlock period set, check if should be locked
      if UserDefaults.standard.bool(forKey: lockActiveKey) {
        blockAppsWithoutSavingState() // Re-apply shield on app launch
      }
      return
    }
    
    let unlockUntil = Date(timeIntervalSince1970: unlockTimestamp)
    let now = Date()
    
    if now >= unlockUntil {
      // Unlock period expired, re-lock
      print("⏰ Unlock period expired, re-locking apps")
      blockApps()
    } else {
      // Still within unlock period, keep apps unlocked
      let remaining = Int(unlockUntil.timeIntervalSince(now) / 60)
      print("✅ Apps still unlocked for \(remaining) more minutes")
      
      // Re-schedule background task in case it was cancelled
      scheduleRelockTask(at: unlockUntil)
    }
  }
  
  // MARK: - Get remaining unlock time (in minutes)
  func getRemainingUnlockTime() -> Int? {
    guard let unlockTimestamp = UserDefaults.standard.object(forKey: unlockUntilKey) as? TimeInterval else {
      return nil // Currently locked
    }
    
    let unlockUntil = Date(timeIntervalSince1970: unlockTimestamp)
    let now = Date()
    
    if now >= unlockUntil {
      return 0 // Expired
    }
    
    let remainingSeconds = unlockUntil.timeIntervalSince(now)
    return Int(ceil(remainingSeconds / 60)) // Round up to nearest minute
  }
  
  // MARK: - Is currently locked?
  func isLocked() -> Bool {
    // If there's an unlock timer, check if it's expired
    if let unlockTimestamp = UserDefaults.standard.object(forKey: unlockUntilKey) as? TimeInterval {
      let unlockUntil = Date(timeIntervalSince1970: unlockTimestamp)
      return Date() >= unlockUntil
    }
    
    // Otherwise check the lock flag
    return UserDefaults.standard.bool(forKey: lockActiveKey)
  }
  
  // MARK: - Helper: Apply shield without changing saved state
  private func blockAppsWithoutSavingState() {
    guard !selection.applicationTokens.isEmpty else { return }
    store.shield.applications = selection.applicationTokens
    print("🔒 Shield re-applied")
  }
  
  // MARK: - Schedule Background Task
  private func scheduleRelockTask(at date: Date) {
    let request = BGProcessingTaskRequest(identifier: "com.tinochiwara.ievangelize.relock")
    request.earliestBeginDate = date
    request.requiresNetworkConnectivity = false
    request.requiresExternalPower = false
    
    do {
      try BGTaskScheduler.shared.submit(request)
      print("📅 Background relock task scheduled for \(date)")
    } catch {
      print("❌ Failed to schedule background task: \(error)")
    }
  }
}

// ================================
// AppDelegate - Enhanced with Background Tasks
// ================================
@main
@objc class AppDelegate: FlutterAppDelegate {
  
// MARK: - App Picker
@available(iOS 15.0, *)
func presentAppPicker() {
  let picker = FamilyActivityPicker(
    selection: Binding(
      get: { FocusBlocker.shared.selection },
      set: { 
        FocusBlocker.shared.selection = $0
        print("📱 Selection updated: \($0.applicationTokens.count) apps selected")
      }
    )
  )
  
  let hostingController = UIHostingController(rootView: picker)
  
  // Wrap in navigation controller
  let navigationController = UINavigationController(rootViewController: hostingController)
  
  // Set title
  hostingController.title = "Choose Activities"
  
  // Add Cancel button (left side)
  hostingController.navigationItem.leftBarButtonItem = UIBarButtonItem(
    barButtonSystemItem: .cancel,
    target: self,
    action: #selector(cancelPicker)
  )
  
  // Add Done button (right side)
  hostingController.navigationItem.rightBarButtonItem = UIBarButtonItem(
    barButtonSystemItem: .done,
    target: self,
    action: #selector(dismissPicker)
  )
  
  window?.rootViewController?.present(navigationController, animated: true)
}

@objc func cancelPicker() {
  // Dismiss without saving changes (selection reverts)
  window?.rootViewController?.dismiss(animated: true) {
    print("❌ App picker cancelled")
  }
}

@objc func dismissPicker() {
  // Dismiss and keep selection
  window?.rootViewController?.dismiss(animated: true) {
    print("✅ App picker dismissed")
    print("📊 Total apps selected: \(FocusBlocker.shared.selection.applicationTokens.count)")
  }
}
  
  // MARK: - App Launch
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Register background task handler
    registerBackgroundTasks()
    
    // Check if unlock period expired and re-lock if needed
    if #available(iOS 15.0, *) {
      FocusBlocker.shared.checkAndRelockIfNeeded()
    }
    
    // --- AUDIO SESSION SETUP ---
    do {
      let session = AVAudioSession.sharedInstance()
      try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
      try session.setMode(.spokenAudio)
      try session.setActive(true)
    } catch {
      print("⚠️ AVAudioSession setup failed: \(error)")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    
    // Setup method channel
    setupMethodChannel()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // MARK: - Register Background Tasks
  private func registerBackgroundTasks() {
    BGTaskScheduler.shared.register(
      forTaskWithIdentifier: "com.tinochiwara.ievangelize.relock",
      using: nil
    ) { task in
      self.handleRelockTask(task: task as! BGProcessingTask)
    }
    print("✅ Background task registered")
  }
  
  // MARK: - Handle Background Task
  private func handleRelockTask(task: BGProcessingTask) {
    print("🔄 Background task fired")
    
    task.expirationHandler = {
      print("⚠️ Background task expired")
      task.setTaskCompleted(success: false)
    }
    
    if #available(iOS 15.0, *) {
      FocusBlocker.shared.checkAndRelockIfNeeded()
    }
    
    task.setTaskCompleted(success: true)
    print("✅ Background task completed")
  }
  
  // MARK: - Setup Method Channel
  private func setupMethodChannel() {
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("RootViewController is not FlutterViewController")
    }
    
    let channel = FlutterMethodChannel(
      name: "focus_blocker",
      binaryMessenger: controller.binaryMessenger
    )
    
    channel.setMethodCallHandler { call, result in
      if #available(iOS 15.0, *) {
        switch call.method {
          
        case "requestPermission":
          if #available(iOS 16.0, *) {
            FocusBlocker.shared.requestPermission { success in
              DispatchQueue.main.async {
                result(success)
              }
            }
          } else {
            result(FlutterError(code: "UNAVAILABLE", message: "Requires iOS 16.0+", details: nil))
          }
          
        case "showAppPicker":
          DispatchQueue.main.async {
            self.presentAppPicker()
            result(true)
          }
          
        case "startBlocking":
          FocusBlocker.shared.blockApps()
          result(true)
          
        case "unlockTemporarily":
          // Get duration from arguments (default 30 minutes)
          let durationMinutes = (call.arguments as? Int) ?? 30
          FocusBlocker.shared.unlockTemporarily(durationMinutes: durationMinutes)
          result(true)
          
        case "isLocked":
          result(FocusBlocker.shared.isLocked())
          
        case "getRemainingTime":
          result(FocusBlocker.shared.getRemainingUnlockTime())
          
        case "recheckStatus":
          FocusBlocker.shared.checkAndRelockIfNeeded()
          result(true)
          
        default:
          result(FlutterMethodNotImplemented)
        }
      } else {
        result(FlutterError(code: "UNAVAILABLE", message: "Family Controls requires iOS 15.0+", details: nil))
      }
    }
  }
}
