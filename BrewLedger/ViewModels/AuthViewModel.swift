import Foundation
import SwiftUI
internal import Combine

@MainActor
class AuthViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let authService = AuthService()
    
    init() {}
    
    func login() {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter username and password"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let response = try await authService.login(username: username, password: password)
                UserDefaults.standard.set(response.token, forKey: "jwt_token")
                UserDefaults.standard.set(response.role, forKey: "user_role")
                self.isLoading = false
            } catch {
                self.isLoading = false
                self.errorMessage = "Username atau password salah"
                print("Login error: \(error)")
            }
        }
    }
    
    func logout() {
        UserDefaults.standard.set("", forKey: "jwt_token")
        UserDefaults.standard.set("", forKey: "user_role")
    }
}
