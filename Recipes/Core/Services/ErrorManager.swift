//
//  ErrorManager.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//


import Combine
import Foundation

final class ErrorManager: ObservableObject {
    static let shared = ErrorManager()
    
    @Published var currentError: AppError?
    
    init() {
        self.currentError = nil
    }

    func handleError(_ error: AppError) {
        DispatchQueue.main.async {
         self.currentError = error
        }
    }

    func clearError() {
        DispatchQueue.main.async {
         self.currentError = nil
        }
    }
}

enum AppError: Identifiable, Error {
    case badResponse
    case networkError
    case unknownError
    case decodingError
 
    var id: String {
        return "\(self)"
    }

    var title: String {
        switch self {
        case .badResponse:
            return "Bad Response"
        case .networkError:
            return "Network Error"
        case .unknownError:
            return "Unknown Error"
        case .decodingError:
            return "Decoding Error"
        }
    }

    var message: String {
        switch self {
        case .badResponse:
            return "The server returned an invalid response. Please try again later."
        case .networkError:
            return "There was a problem connecting to the network. Please check your connection."
        case .unknownError:
            return "An unknown error occurred. Please try again later."
        case .decodingError:
            return "There was a problem decoding the response. Please try again later."
        }
    }
}
