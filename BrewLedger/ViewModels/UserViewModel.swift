import Foundation
import Combine
import SwiftUI

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [UserResponse] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func fetchUsers() async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await UserService.shared.getAllUsers()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func deleteUser(id: Int) async {
        do {
            try await UserService.shared.deleteUser(id: id)
            await fetchUsers()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func toggleUserStatus(user: UserResponse) async {
        do {
            if user.active {
                try await UserService.shared.deactivateUser(id: user.id)
            } else {
                try await UserService.shared.activateUser(id: user.id)
            }
            await fetchUsers()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
