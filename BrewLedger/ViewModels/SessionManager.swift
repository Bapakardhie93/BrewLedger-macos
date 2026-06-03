import Foundation
import Combine

final class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var role: String = ""

    init() {
        let savedToken = UserDefaults.standard.string(forKey: "jwt_token") ?? ""
        let savedRole = UserDefaults.standard.string(forKey: "user_role") ?? ""
        
        self.isLoggedIn = !savedToken.isEmpty
        self.role = savedRole
    }

    func login(token: String, role: String) {
        UserDefaults.standard.set(token, forKey: "jwt_token")
        UserDefaults.standard.set(role, forKey: "user_role")
        
        self.role = role
        self.isLoggedIn = true
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "jwt_token")
        UserDefaults.standard.removeObject(forKey: "user_role")
        
        self.role = ""
        self.isLoggedIn = false
    }
}
