import Foundation

class UserService {
    static let shared = UserService()
    
    func getAllUsers() async throws -> [UserResponse] {
        return try await NetworkClient.shared.request(
            endpoint: "/api/users",
            method: "GET",
            requiresAuth: true
        )
    }
    
    func getUserById(id: Int) async throws -> UserResponse {
        return try await NetworkClient.shared.request(
            endpoint: "/api/users/\(id)",
            method: "GET",
            requiresAuth: true
        )
    }
    
    func createUser(request: CreateUserRequest) async throws -> UserResponse {
        let jsonData = try JSONEncoder().encode(request)
        return try await NetworkClient.shared.request(
            endpoint: "/api/users",
            method: "POST",
            body: jsonData,
            requiresAuth: true
        )
    }
    
    func updateUser(id: Int, request: UpdateUserRequest) async throws -> UserResponse {
        let jsonData = try JSONEncoder().encode(request)
        return try await NetworkClient.shared.request(
            endpoint: "/api/users/\(id)",
            method: "PUT",
            body: jsonData,
            requiresAuth: true
        )
    }
    
    func deleteUser(id: Int) async throws {
        try await NetworkClient.shared.requestVoid(
            endpoint: "/api/users/\(id)",
            method: "DELETE",
            requiresAuth: true
        )
    }
    
    func activateUser(id: Int) async throws {
        try await NetworkClient.shared.requestVoid(
            endpoint: "/api/users/\(id)/activate",
            method: "PATCH",
            requiresAuth: true
        )
    }
    
    func deactivateUser(id: Int) async throws {
        try await NetworkClient.shared.requestVoid(
            endpoint: "/api/users/\(id)/deactivate",
            method: "PATCH",
            requiresAuth: true
        )
    }
}
