import SwiftUI

struct SessionsTab: View {
  static let forcingNewSession = """
  Sessions roll automatically when the app is backgrounded for the configured \
  timeout (default 30 minutes). To exercise this quickly, add the key \
  FirebaseSessionsSessionTimeout (Number, in minutes) to Info.plist with a small \
  value such as 1, reinstall, then background the app for that long and foreground.

  After foregrounding, look for a new 'Session Id changed' line and confirm it \
  differs from the previous launch.
  """

  var body: some View {
    NavigationStack {
      List {
        Section("On cold launch, console should show") {
          Text("• [FirebaseSessions] Version <version>")
          Text("• [FirebaseSessions] Registering Sessions SDK subscriber...")
          Text("• [FirebasePerformance] Session Id changed - <uuid>")
          Text("• [FirebaseSessions] Successfully logged Session Start event to GoogleDataTransport")
        }
        .font(.footnote)

        Section("Forcing a new session") {
          Text(Self.forcingNewSession)
            .font(.footnote)
        }

        Section("FirebaseSessions does not expose the current session ID via a public Swift API.") {
          Text("Verification is console-based. Filter on 'FirebaseSessions' or 'Session Id'.")
            .font(.footnote)
        }
      }
      .navigationTitle("Sessions")
    }
  }
}

#Preview {
  SessionsTab()
}
