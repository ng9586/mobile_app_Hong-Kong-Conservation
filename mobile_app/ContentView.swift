import SwiftUI
import FirebaseAuth
import MapKit

struct ContentView: View {
    @StateObject private var locationViewModel = LocationViewModel() // Create an instance of the ViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingRegistration = false
    @State private var loginMessage: String = ""
    @State private var showMessage: Bool = false
    @State private var isLoggedIn = false
    @State private var isLoading = false // State to track loading status

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if isLoggedIn {
                    HomeView(isLoggedIn: $isLoggedIn, locationViewModel: locationViewModel) // Pass the ViewModel and binding for login state
                } else {
                    loginForm // Show login form if not logged in
                }
            }
            .padding()
            .navigationTitle(isLoggedIn ? "" : "Login")
            .sheet(isPresented: $showingRegistration) {
                RegistrationView(isAuthenticated: $isLoggedIn)
            }
        }
    }

    private var loginForm: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocorrectionDisabled(true)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocorrectionDisabled(true)

            Button(action: login) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isLoading) // Disable button while loading
            
            Button(action: authenticateWithFaceID) {
                Text("Login with Face ID")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isLoading) // Disable button while loading

            if showMessage {
                Text(loginMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: { showingRegistration.toggle() }) {
                Text("Don't have an account? Register")
                    .foregroundColor(.blue)
            }
        }
    }

    func login() {
        guard isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return
        }

        guard password.count >= 6 else {
            showAlert(message: "Password must be at least 6 characters long.")
            return
        }

        isLoading = true // Start loading

        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async { // Ensure UI updates happen on the main thread
                isLoading = false // Stop loading
                
                if let error = error {
                    showAlert(message: "Login failed: \(error.localizedDescription)")
                    return
                }
                
                loginMessage = "Login successful!"
                showMessage = true
                isLoggedIn = true
            }
        }
    }

    func authenticateWithFaceID() {
        BiometricAuthService.authenticate { success, errorMessage in
            if success {
                self.isLoggedIn = true
                self.loginMessage = "Face ID authentication successful!"
                self.showMessage = true
            } else {
                self.loginMessage = errorMessage ?? "Face ID authentication failed."
                self.showMessage = true
            }
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    private func showAlert(message: String) {
        loginMessage = message
        showMessage = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LocationViewModel()) // Provide a mock ViewModel for previews
    }
}
