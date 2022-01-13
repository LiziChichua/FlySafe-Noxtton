//
//  MainViewModel.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import Foundation


class MainViewModel {
    
    private let networkService = DefaultNetworkService()
    private let apiManager: APIManager
    var userToken: String? {
        didSet {
            if let token = userToken {
                fetchTravelPlans(token: token)
            }
        }
    }
    var airportsDidFetch: (([Airport]) -> (Void))?
    var restrictionsDidFetch: (([String : Restrictions], TravelPlan?, Bool) -> (Void))?
    var travelPlanDidRemove: ((Bool) -> (Void))?
    var travelPlanDidEdit: ((Bool) -> (Void))?
    var travelPlansDidFetch: (([TravelPlan]) -> (Void))?
    
    
    init() {
        apiManager = APIManager(with: networkService)
        apiManager.onError = { error in
            print (error)
        }
        
        fetchAirports()
        
    }
    
    //Fetch available airports
    func fetchAirports() {
        apiManager.fetchAirports { [weak self] result in
            if let response = result {
                self?.airportsDidFetch?(response.airports)
            }
        }
    }
    
    //Fetch restrictions
    func fetchRestrictions(travelPlan: TravelPlan, nationality: String?, vaccine: String?, saveButtonEnabled: Bool) {
        apiManager.fetchRestrictions(travelPlan: travelPlan, nationality: nationality, vaccine: vaccine) { [weak self] result in
            if let response = result {
                if let restrictions = response.restricions {
                    self?.restrictionsDidFetch?(restrictions, travelPlan, saveButtonEnabled)
                }
            }
        }
    }
    
    func fetchTravelPlans(token: String) {
        apiManager.fetchTravelPlans(token: token) { [weak self] result in
            if let response = result {
                print (response.success)
                self?.travelPlansDidFetch?(response.travelPlans)
            }
        }
    }
    
    
    //Remove existing travel plan
    func deleteTravelPlan(token: String, flightID: String) {
        apiManager.deleteTravelPlan(token: token, flightID: flightID) { [weak self] result in
            if let response = result {
                self?.travelPlanDidRemove?(response.success)
            }
        }
    }
    
    //Edit travel plan
    func editTravelPlan(token: String, travelPlan: TravelPlan) {
        apiManager.editTravelPlan(token: token, travelPlan: travelPlan) { [weak self] result in
            if let response = result {
                self?.travelPlanDidEdit?(response.success)
            }
        }
    }
}

