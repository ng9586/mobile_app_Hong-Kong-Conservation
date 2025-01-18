import SwiftUI
import FirebaseAuth // Ensure FirebaseAuth is imported

struct SettingsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel = SettingsViewModel()
    
    @State private var showingSignOutAlert = false // Control showing sign out confirmation alert
    var onSignOut: () -> Void // Closure to handle sign out action
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                // APPEARANCE SECTION
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $viewModel.isDarkMode) {
                        Text("Dark Mode")
                    }
                }
                
                // ABOUT SECTION
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                    }
                }
                
                // SIGN OUT SECTION
                Section {
                    Button(action: {
                        showingSignOutAlert = true // Show sign out confirmation alert
                    }) {
                        Text("Sign Out")
                            .foregroundColor(.red) // Set text color to red
                            .frame(maxWidth: .infinity, alignment: .center) // Make button full width
                            .padding()
                            .background(Color.red.opacity(0.1)) // Button background color
                            .cornerRadius(10) // Rounded corners
                    }
                }
                
            }
            .navigationTitle("Settings")
            .alert(isPresented: $showingSignOutAlert) { // Show confirmation alert
                Alert(
                    title: Text("Confirm Sign Out"),
                    message: Text("Are you sure you want to sign out?"),
                    primaryButton: .destructive(Text("Yes")) {
                        signOut() // Confirm sign out action
                    },
                    secondaryButton: .cancel() // Cancel button action
                )
            }
        }
        .onAppear {
            viewModel.isDarkMode = (colorScheme == .dark)
        }
        
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // Use Firebase to sign out user
            print("User signed out successfully") // Handle successful sign out logic
            
            onSignOut() // Call the closure to notify about sign out
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError) // Handle sign out error
        }
    }
}

#Preview {
    SettingsView(onSignOut: {})
}
