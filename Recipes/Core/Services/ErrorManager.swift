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

struct AppError: Identifiable, Equatable, CustomStringConvertible {
    let id = UUID()
    let title: String
    let message: String

    var description: String {
        return "\(title): \(message)"
    }

    static func == (lhs: AppError, rhs: AppError) -> Bool {
        lhs.id == rhs.id
    }
}
