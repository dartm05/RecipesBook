//
//  NetworkMonitor.swift
//  Recipes
//
//  Created by Daniella Arteaga on 20/11/24.
//


import Network
import Combine

final class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private var errorManager: ErrorManager?
    
    init(errorManager: ErrorManager = .shared) {
        self.errorManager = errorManager
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            if(path.status != .satisfied){
                self?.handleNoInternetConnection()
            }
        }
        monitor.start(queue: queue)
    }
    
    private func handleNoInternetConnection() {
        DispatchQueue.main.async {
            self.errorManager?.handleError(
                AppError(title: "No Internet Connection", message: "Please check your conection and try again.")
            )
        }
    }
    
    private func stopMonitoring() {
        monitor.cancel()
    }
}
