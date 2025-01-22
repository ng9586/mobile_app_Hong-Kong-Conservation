import Foundation

class GPTNetwork {
    private let APIKey = "your-api-key" // 請替換為您的實際 API 密鑰
    private let url = "https://api.chatanywhere.tech/v1/chat/completions"
    
    func getGPTResponse(messages: [[String: String]]) async throws -> String {
        guard let apiUrl = URL(string: url) else {
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(APIKey)", forHTTPHeaderField: "Authorization")
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "temperature": 0.7
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "APIError", code: (response as? HTTPURLResponse)?.statusCode ?? 0, userInfo: nil)
        }
        
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        guard let choices = jsonResponse?["choices"] as? [[String: Any]],
              let message = choices.first?["message"] as? [String: Any],
              let content = message["content"] as? String else {
            throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
        }
        
        return content
    }
}
