//
//  StudySpotsApp.swift
//  StudySpots
//
//  Created by Milan Canty on 4/22/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct StudySpotsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var RoomVM = RoomViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(RoomVM)
        }
    }
}
