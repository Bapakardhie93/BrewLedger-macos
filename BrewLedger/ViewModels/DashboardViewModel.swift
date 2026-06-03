import Foundation
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published var dashboard: DashboardStats?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let dashboardService = DashboardService()

    func loadDashboard() async {
        isLoading = true
        errorMessage = nil

        do {
            dashboard = try await dashboardService.getStats()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
