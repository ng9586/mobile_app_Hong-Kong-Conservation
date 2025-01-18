import SwiftUI
import FirebaseAuth // Ensure FirebaseAuth is imported
import FirebaseFirestore // Ensure Firestore is imported

struct RegistrationView: View {
    @Binding var isAuthenticated: Bool // Binding to control main page state
    @Environment(\.presentationMode) var presentationMode
    @State private var nickname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @State private var successMessage: String = "" // New state variable for success message
    @State private var showSuccess: Bool = false // State variable to control visibility of success message

    var body: some View {
        VStack(spacing: 20) {
            TextField("Nickname", text: $nickname)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            if showSuccess { // Show success message if applicable
                Text(successMessage)
                    .foregroundColor(.green) // Change color to indicate success
                    .padding()
            }

            Button(action: {
                registerUser() // Call the registration function
            }) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: {
                presentationMode.wrappedValue.dismiss() // Go back to previous view
            }) {
                Text("Back")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Register New Account")
    }

    func registerUser() {
        errorMessage = ""
        showError = false
        successMessage = "" // Clear previous success message
        showSuccess = false // Hide success message initially
        
        guard isValidEmail(email) else {
            errorMessage = "Please enter a valid email address."
            showError = true
            return
        }

        guard password.count >= 6 else {
            errorMessage = "Password must be at least 6 characters long."
            showError = true
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            showError = true
            return
        }

        // Use Firebase to register the user
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = "Registration failed: \(error.localizedDescription)"
                showError = true
                return
            }
            
            // After successful registration, save user information to Firestore
            let db = Firestore.firestore()
            let userData: [String: Any] = [
                "nickname": nickname,
                "email": email,
                "createdAt": Timestamp(date: Date())
            ]
            
            db.collection("users").document(result!.user.uid).setData(userData) { error in
                if let error = error {
                    errorMessage = "Failed to save user information: \(error.localizedDescription)"
                    showError = true
                    return
                }
                
                // Registration successful and user information saved, update state to show main page
                isAuthenticated = true
                
                // Show success message after registration
                successMessage = "Registration successful! You can now log in."
                showSuccess = true
                
                presentationMode.wrappedValue.dismiss() // Go back to login page or perform other actions
            }
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(isAuthenticated: Binding.constant(false))
    }
}
