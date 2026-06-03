import Foundation

class AuthService {
    func login(username: String, password: String) async throws -> AuthResponse {
        let body: [String: String] = [
            "username": username,
            "password": password
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: body)
        
        let response: AuthResponse = try await NetworkClient.shared.request(
            endpoint: "/api/auth/login",
            method: "POST",
            body: jsonData,
            requiresAuth: false
        )
        
        return response
    }
}
