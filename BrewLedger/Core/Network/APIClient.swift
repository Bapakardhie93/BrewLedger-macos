//
//  APIClient.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation

final class APIClient {

    static let shared = APIClient()

    private init() {}

    func get<T: Decodable>(
        endpoint: String,
        responseType: T.Type
    ) async throws -> T {

        guard let url = URL(
            string: AppConfig.baseURL + endpoint
        ) else {
            throw HTTPError.invalidURL
        }

        var request =
            URLRequest(url: url)

        request.httpMethod = "GET"

        if let token =
            TokenManager.shared.getToken() {

            request.setValue(
                "Bearer \(token)",
                forHTTPHeaderField: "Authorization"
            )
        }

        let (data, response) =
            try await URLSession.shared
                .data(for: request)

        guard let httpResponse =
            response as? HTTPURLResponse
        else {
            throw HTTPError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode
        else {
            throw HTTPError.serverError(
                httpResponse.statusCode
            )
        }

        do {

            return try JSONDecoder()
                .decode(
                    T.self,
                    from: data
                )

        } catch {

            throw HTTPError.decodingError
        }
    }
    
    func login(
        username: String,
        password: String
    ) async throws -> LoginResponse {

        guard let url =
            URL(
                string:
                "\(AppConfig.baseURL)/api/auth/login"
            )
        else {
            throw HTTPError.invalidURL
        }

        var request =
            URLRequest(url: url)

        request.httpMethod = "POST"

        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let body =
            LoginRequest(
                username: username,
                password: password
            )

        request.httpBody =
            try JSONEncoder()
                .encode(body)

        let (data, response) =
            try await URLSession.shared
                .data(for: request)

        guard let httpResponse =
            response as? HTTPURLResponse
        else {
            throw HTTPError.invalidResponse
        }

        guard httpResponse.statusCode == 200
        else {
            throw HTTPError.serverError(
                httpResponse.statusCode
            )
        }

        return try JSONDecoder()
            .decode(
                LoginResponse.self,
                from: data
            )
    }
}
