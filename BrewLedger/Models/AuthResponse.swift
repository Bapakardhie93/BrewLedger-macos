import Foundation

struct AuthResponse: Codable {
    let token: String
    let type: String?
    let username: String
    let role: String
}
