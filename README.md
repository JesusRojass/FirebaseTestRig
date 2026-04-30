# FirebaseTestRig

A dedicated test application for validating various Firebase SDK areas, including Crashlytics, Sessions, and Data Collection settings.

Lives outside the canonical `pod gen` outputs so re-running `pod gen` against an SDK podspec will not touch this app.

Bundle ID is `com.google.FIRPerfTestApp`. Uninstall any other app using this Bundle ID before launching FirebaseTestRig to avoid conflicts.

## Setup

```bash
# Copy your GoogleService-Info.plist into the project
cp /path/to/your/GoogleService-Info.plist FirebaseTestRig/
pod install
open FirebaseTestRig.xcworkspace
```

In Xcode:
1. Select the **FirebaseTestRig** target → **Signing & Capabilities** → set your development team.
2. Build and run.

## Areas of Testing

### Crashlytics
Test various crash types (synthetic, NSException, SIGSEGV, Swift fatalError) along with non-fatal recording and breadcrumbs.
1. Trigger a crash.
2. Cold-launch the app.
3. Verify the upload in the Xcode console and Firebase Console.

### Sessions
Verify session lifecycle and initialization.
- Check for `[FirebaseSessions]` registration and event logs in the console on cold launch.
- Test session rolling by backgrounding the app.

### Data Collection
Test runtime toggles for:
- FirebaseApp `dataCollectionDefaultEnabled`
- Performance `dataCollectionEnabled`
- Crashlytics `CrashlyticsCollectionEnabled`

Toggle these settings and trigger events to confirm that data collection is respected.
