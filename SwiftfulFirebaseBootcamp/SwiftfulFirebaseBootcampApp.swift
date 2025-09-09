//
//  SwiftfulFirebaseBootcampApp.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by jyotirmoy_halder on 9/9/25.
//

import SwiftUI
import FirebaseCore


@main
struct SwiftfulFirebaseBootcampApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    print("Configured Firebase")
      
    return true
  }
}
