import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case unauthorized
}

class NetworkClient {
    static let shared = NetworkClient()
    
    // We'll manage token using AppStorage or pass it explicitly.
    // For simplicity, we can fetch it directly from UserDefaults since AppStorage uses UserDefaults under the hood.
    var token: String? {
        UserDefaults.standard.string(forKey: "jwt_token")
    }
    
    func request<T: Codable>(endpoint: String, method: String = "GET", body: Data? = nil, requiresAuth: Bool = true) async throws -> T {
        guard let url = URL(string: Constants.baseURL + endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth {
            guard let token = token else {
                throw APIError.unauthorized
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError(statusCode: 0)
        }
        
        if httpResponse.statusCode == 401 {
            throw APIError.unauthorized
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
    
    func requestVoid(endpoint: String, method: String = "GET", body: Data? = nil, requiresAuth: Bool = true) async throws {
        guard let url = URL(string: Constants.baseURL + endpoint) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requiresAuth {
            guard let token = token else {
                throw APIError.unauthorized
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpBody = body
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.serverError(statusCode: 0)
        }
        
        if httpResponse.statusCode == 401 {
            throw APIError.unauthorized
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
    }
}
