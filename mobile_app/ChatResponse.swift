import Foundation

struct ChatResponse: Decodable {
    let choices: [Choice]?
}

struct Choice: Decodable {
    let message: Message
}

struct Message: Decodable {
    let content: String
}
