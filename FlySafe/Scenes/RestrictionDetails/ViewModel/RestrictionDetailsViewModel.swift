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
    
    func fetchAirports() {
        apiManager.fetchAirports { [weak self] result in
            if let response = result {
                self?.airportsDidFetch?(response.airports)
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
