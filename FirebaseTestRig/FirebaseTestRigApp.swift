// FirebaseTestRig
// Side-by-side test app for Firebase Crashlytics, Sessions, and Data Collection.

import SwiftUI
import FirebaseCore

@main
struct FirebaseTestRigApp: App {
  init() {
    FirebaseApp.configure()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
