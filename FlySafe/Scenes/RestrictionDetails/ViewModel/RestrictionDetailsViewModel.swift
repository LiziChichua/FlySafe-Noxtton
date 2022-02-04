//
//  RestrictionDetailsViewModel.swift
//  FlySafe
//
//  Created by Nika Topuria on 13.01.22.
//

import Foundation


class RestrictionDetailsViewModel {
    
    private let networkService = DefaultNetworkService()
    private let apiManager: APIManager
    private let storageManager = OfflineStorageManager()
    
    var travelPlanDidAdd: ((Bool) -> (Void))?
    var airportsDidFetch: (([Airport]) -> (Void))?
    
    
    //Add new travel plan
    func addTravelPlan(token: String, flightInfo: TravelPlan) {
        apiManager.addTravelPlan(token: token, travelPlan: flightInfo) { [weak self] result in
            if let response = result {
                self?.travelPlanDidAdd?(response.success)
            }
        }
    }
    
    func fetchLocalAirports() {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: "airports") {
            if let airports = try? JSONDecoder().decode([Airport].self, from: data) {
                self.airportsDidFetch?(airports)
            }
        }
    }
    
    
    init() {
        apiManager = APIManager(with: networkService)
        apiManager.onError = { error in
            print (error)
        }
        
    }
    
}
