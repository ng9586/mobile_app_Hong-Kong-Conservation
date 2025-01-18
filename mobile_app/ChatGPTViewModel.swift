import SwiftUI

@MainActor
class ChatGPTViewModel: ObservableObject {
    @Published var messagesList: [String] = []
    @Published var inputMessage: String = ""
    
    private let gptNetwork = GPTNetwork()
    
    func sendMessage() {
        guard !inputMessage.isEmpty else { return }
        
        let userMessage = "User: \(inputMessage)"
        messagesList.append(userMessage)
        
        let messages = [
            ["role": "system", "content": "You are a helpful assistant."],
            ["role": "user", "content": inputMessage]
        ]
        
        Task {
            do {
                let response = try await gptNetwork.getGPTResponse(messages: messages)
                messagesList.append("AI: \(response)")
                inputMessage = ""
            } catch {
                messagesList.append("Error: \(error.localizedDescription)")
                print("API Error: \(error)")
            }
        }
    }
}
