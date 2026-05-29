//
//  LoginViewModel.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation
import Combine

@MainActor
final class LoginViewModel:
ObservableObject {

    @Published var username = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var errorMessage: String?

    func login(
        session: SessionManager
    ) async {

        isLoading = true

        defer {
            isLoading = false
        }

        do {

            let response =
                try await APIClient.shared.login(
                    username: username,
                    password: password
                )

            session.login(
                token: response.token
            )

        } catch {

            errorMessage =
                error.localizedDescription
        }
    }
}
