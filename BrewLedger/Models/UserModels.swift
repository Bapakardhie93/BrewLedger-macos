import Foundation

struct UserResponse: Codable, Identifiable {
    let id: Int
    let fullName: String
    let username: String
    let active: Bool
    let mustChangePassword: Bool
    let lastLogin: String?
    let role: RoleResponse
}

struct RoleResponse: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
}

struct CreateUserRequest: Codable {
    let fullName: String
    let username: String
    let password: String
    let roleId: Int
}

struct UpdateUserRequest: Codable {
    let fullName: String
    let username: String
    let password: String?
    let roleId: Int
}
