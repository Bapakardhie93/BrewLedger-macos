//
//  HTTPError.swift
//  BrewLedger
//
//  Created by Bapakardhie Pacarnya Yaya on 02/06/26.
//

import Foundation

enum HTTPError: LocalizedError {

    case invalidURL
    case invalidResponse
    case serverError(Int)
    case decodingError
    case unknown

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "URL tidak valid"

        case .invalidResponse:
            return "Response tidak valid"

        case .serverError(let code):
            return "Server Error (\(code))"

        case .decodingError:
            return "Gagal membaca data"

        case .unknown:
            return "Terjadi kesalahan"
        }
    }
}
