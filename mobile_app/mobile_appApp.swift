import SwiftUI

@main
struct mobile_appApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // Connect the AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView() // Your main view
                .environmentObject(LocationViewModel()) // Provide LocationViewModel as needed
        }
    }
}
