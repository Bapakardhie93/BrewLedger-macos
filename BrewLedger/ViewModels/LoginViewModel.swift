import Foundation
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let authService = AuthService()

    func login(session: SessionManager) async {
        guard !username.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter username and password"
            return
        }
        
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let response = try await authService.login(
                username: username,
                password: password
            )

            session.login(
                token: response.token,
                role: response.role
            )

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
