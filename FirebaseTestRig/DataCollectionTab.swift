import SwiftUI
import FirebaseCore
import FirebasePerformance
import FirebaseCrashlytics

struct DataCollectionTab: View {
  static let howToVerify = """
  Flip a toggle off, hit the matching trigger button, watch the Xcode console.

  • Performance off → no 'Logging trace metric' or 'Logging network request trace'.
  • Crashlytics off → recorded non-fatals are dropped; verify by leaving disabled, \
  force-quitting the app, then reopening: no upload should occur.
  • FirebaseApp default off → all SDKs that respect the global default stop logging.

  Re-enable each toggle and confirm events resume.
  """

  @State private var refreshTick = 0

  var body: some View {
    NavigationStack {
      List {
        Section("Per-SDK toggles") {
          Toggle("FirebaseApp dataCollectionDefaultEnabled", isOn: appBinding)
          Toggle("Performance dataCollectionEnabled", isOn: performanceBinding)
          Toggle("Crashlytics CrashlyticsCollectionEnabled", isOn: crashlyticsBinding)
        }

        Section("Trigger one event of each kind") {
          Button("Fire a Performance trace") {
            guard let trace = Performance.startTrace(name: "DataCollectionTest") else { return }
            trace.incrementMetric("test_metric", by: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { trace.stop() }
          }
          Button("Fire a Performance network request") {
            URLSession.shared.dataTask(
              with: URL(string: "https://firebase.google.com/")!
            ) { _, _, _ in }.resume()
          }
          Button("Record a Crashlytics non-fatal") {
            Crashlytics.crashlytics().record(
              error: NSError(domain: "FirebaseTestRig", code: 1, userInfo: nil)
            )
          }
        }

        Section("How to verify") {
          Text(Self.howToVerify)
            .font(.footnote)
        }

        Section {
          Button("Refresh toggle state from SDKs") {
            refreshTick += 1
          }
          .font(.footnote)
        }
      }
      .navigationTitle("Data Collection")
      .id(refreshTick)
    }
  }

  private var appBinding: Binding<Bool> {
    Binding(
      get: { FirebaseApp.app()?.isDataCollectionDefaultEnabled ?? true },
      set: { FirebaseApp.app()?.isDataCollectionDefaultEnabled = $0 }
    )
  }

  private var performanceBinding: Binding<Bool> {
    Binding(
      get: { Performance.sharedInstance().isDataCollectionEnabled },
      set: { Performance.sharedInstance().isDataCollectionEnabled = $0 }
    )
  }

  private var crashlyticsBinding: Binding<Bool> {
    Binding(
      get: { Crashlytics.crashlytics().isCrashlyticsCollectionEnabled() },
      set: { Crashlytics.crashlytics().setCrashlyticsCollectionEnabled($0) }
    )
  }
}

#Preview {
  DataCollectionTab()
}
