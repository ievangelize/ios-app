import UIKit
import Flutter
import AVFoundation
import FamilyControls
import ManagedSettings
import DeviceActivity
import SwiftUI

@main
@objc class AppDelegate: FlutterAppDelegate {
  
  // ================================
  // App Picker (required by Apple)
  // ================================
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
    
    // Check if prayer lock is active
    if UserDefaults.standard.bool(forKey: "PrayerLockActive") {
      FocusBlocker.shared.blockApps()
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
    
    // --- Flutter plugins ---
    GeneratedPluginRegistrant.register(with: self)
    
    // ================================
    // 🔒 SCREEN TIME METHOD CHANNEL
    // ================================
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
    
    // ================================
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
