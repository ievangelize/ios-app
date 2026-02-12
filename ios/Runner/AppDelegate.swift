import UIKit
import Flutter
import AVFoundation
import FamilyControls
import ManagedSettings
import DeviceActivity
import SwiftUI

// ================================
// FocusBlocker Class (defined here in same file)
// ================================
class FocusBlocker {
  static let shared = FocusBlocker()
  let store = ManagedSettingsStore()
  var selection = FamilyActivitySelection()
  
  private init() {}
  
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
      guard !self.selection.applicationTokens.isEmpty else { return }
      self.store.shield.applications = self.selection.applicationTokens
      UserDefaults.standard.set(true, forKey: "PrayerLockActive")
    }
  }
  
  func unblockApps() {
    DispatchQueue.main.async {
      self.store.shield.applications = nil
      UserDefaults.standard.set(false, forKey: "PrayerLockActive")
    }
  }
}

// ================================
// AppDelegate
// ================================
@main
@objc class AppDelegate: FlutterAppDelegate {
  
  func presentAppPicker() {
    let picker = FamilyActivityPicker(
      selection: Binding(
        get: { FocusBlocker.shared.selection },
        set: { FocusBlocker.shared.selection = $0 }
      )
    )
    let controller = UIHostingController(rootView: picker)
    window?.rootViewController?.present(controller, animated: true)
  }
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    if UserDefaults.standard.bool(forKey: "PrayerLockActive") {
      FocusBlocker.shared.blockApps()
    }
    
    do {
      let session = AVAudioSession.sharedInstance()
      try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
      try session.setMode(.spokenAudio)
      try session.setActive(true)
    } catch {
      print("⚠️ AVAudioSession setup failed: \(error)")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    
    guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("RootViewController is not FlutterViewController")
    }
    
    let channel = FlutterMethodChannel(
      name: "focus_blocker",
      binaryMessenger: controller.binaryMessenger
    )
    
    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "requestPermission":
        FocusBlocker.shared.requestPermission { success in
          DispatchQueue.main.async {
            result(success)
          }
        }
        
      case "showAppPicker":
        DispatchQueue.main.async {
          self.presentAppPicker()
          result(true)
        }
        
      case "startBlocking":
        FocusBlocker.shared.blockApps()
        result(true)
        
      case "stopBlocking":
        FocusBlocker.shared.unblockApps()
        result(true)
        
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
