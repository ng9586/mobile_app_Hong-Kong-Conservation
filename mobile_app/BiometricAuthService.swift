import LocalAuthentication

class BiometricAuthService {
    static func authenticate(completion: @escaping (Bool, String?) -> Void) {
        let context = LAContext()
        var error: NSError?

        // Check if the device supports biometric authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate to access your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true, nil) // Successful authentication
                    } else {
                        completion(false, authenticationError?.localizedDescription) // Authentication failed
                    }
                }
            }
        } else {
            completion(false, error?.localizedDescription) // Not available
        }
    }
}
