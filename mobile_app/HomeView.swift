import SwiftUI

struct HomeView: View {
    @Binding var isLoggedIn: Bool
    @ObservedObject var locationViewModel: LocationViewModel // Use ObservedObject to access ViewModel

    var body: some View {
        TabView {
            Homepage()
                .tabItem { Label("Home", systemImage: "house") }
            
            ListPage()
                .tabItem { Label("List", systemImage: "list.bullet") }
            
            LocationView() // Assuming LocationView uses locationViewModel for map data
                .tabItem { Label("Location", systemImage: "location") }

            CameraView() // Implement this view as needed
                .tabItem { Label("Camera", systemImage: "camera") }

            ChatView() // Implement this view as needed
                .tabItem { Label("Chat", systemImage: "message") }

            SettingsView(onSignOut: {
                isLoggedIn = false // Handle sign-out logic by updating the binding variable
            })
            .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}
