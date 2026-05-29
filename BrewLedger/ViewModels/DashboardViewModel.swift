//
//  DashboardViewModel.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation
import Combine

@MainActor
final class DashboardViewModel: ObservableObject {

    @Published var dashboard: DashboardResponse?

    @Published var isLoading = false

    @Published var errorMessage: String?

    func loadDashboard() async {

        isLoading = true
        errorMessage = nil

        do {

            dashboard =
            try await APIClient.shared.get(
                endpoint: "/api/dashboard",
                responseType: DashboardResponse.self
            )

        } catch {

            errorMessage =
            error.localizedDescription
        }

        isLoading = false
    }
}
