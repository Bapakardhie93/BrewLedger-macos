//
//  SessionManager.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation
import Combine

final class SessionManager: ObservableObject {

    @Published
    var isLoggedIn: Bool

    init() {

        TokenManager.shared.clearToken()

        self.isLoggedIn = false
    }

    func login(
        token: String
    ) {

        TokenManager.shared
            .saveToken(token)

        isLoggedIn = true
    }

    func logout() {

        TokenManager.shared
            .clearToken()

        isLoggedIn = false
    }
}
