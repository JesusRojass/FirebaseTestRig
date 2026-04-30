import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      CrashlyticsTab()
        .tabItem { Label("Crashlytics", systemImage: "exclamationmark.triangle") }
      SessionsTab()
        .tabItem { Label("Sessions", systemImage: "clock.arrow.circlepath") }
      DataCollectionTab()
        .tabItem { Label("Data Collection", systemImage: "switch.2") }
    }
  }
}

#Preview {
  ContentView()
}
