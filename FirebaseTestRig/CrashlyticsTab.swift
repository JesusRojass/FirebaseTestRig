import SwiftUI
import FirebaseCrashlytics

struct CrashlyticsTab: View {
  static let howToVerify = """
  Crashlytics uploads pending reports on the next launch after a crash. \
  Trigger one of the buttons below, the app will terminate, then cold-launch \
  from Xcode again. Watch the console for 'Reporting unsent reports' followed \
  by a confirmation that the report uploaded.

  In the Firebase console, the crash should appear under \
  Crashlytics → Issues for this app.
  """

  var body: some View {
    NavigationStack {
      List {
        Section("How to verify") {
          Text(Self.howToVerify)
            .font(.footnote)
        }

        Section("Trigger crash (terminates the app)") {
          Button("NSException — uncaught Objective-C", role: .destructive) {
            Crashlytics.crashlytics().setCustomValue("nsexception", forKey: "test_type")
            NSException(
              name: .genericException,
              reason: "FirebaseTestRig manual NSException",
              userInfo: nil
            ).raise()
          }
          Button("Null pointer dereference — SIGSEGV", role: .destructive) {
            Crashlytics.crashlytics().setCustomValue("sigsegv", forKey: "test_type")
            let p: UnsafeMutablePointer<Int>? = nil
            p!.pointee = 42
          }
          Button("Swift fatalError", role: .destructive) {
            Crashlytics.crashlytics().setCustomValue("fatalError", forKey: "test_type")
            fatalError("FirebaseTestRig manual fatalError")
          }
        }

        Section("Non-fatal") {
          Button("Record NSError (non-fatal)") {
            let err = NSError(
              domain: "FirebaseTestRig",
              code: 99,
              userInfo: [NSLocalizedDescriptionKey: "Manually recorded non-fatal"]
            )
            Crashlytics.crashlytics().record(error: err)
          }
          Button("Log breadcrumb") {
            Crashlytics.crashlytics().log("FirebaseTestRig breadcrumb at \(Date())")
          }
        }
      }
      .navigationTitle("Crashlytics")
    }
  }
}

#Preview {
  CrashlyticsTab()
}
