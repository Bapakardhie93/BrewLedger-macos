import Foundation

class DashboardService {
    func getStats() async throws -> DashboardStats {
        let response: DashboardStats = try await NetworkClient.shared.request(
            endpoint: "/api/dashboard",
            method: "GET",
            requiresAuth: true
        )
        return response
    }
}
