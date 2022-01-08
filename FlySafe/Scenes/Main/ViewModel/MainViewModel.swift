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
    var airportsDidFetch: (([Airport]) -> (Void))?
    var restrictionsDidFetch: (([String : Restrictions]) -> (Void))?
    var travelPlanDidAdd: ((Bool) -> (Void))?
    var travelPlanDidRemove: ((Bool) -> (Void))?
    var travelPlanDidEdit: ((Bool) -> (Void))?
    var travelPlansDidFetch: (([TravelPlan]) -> (Void))?
    
    init() {
        apiManager = APIManager(with: networkService)
        apiManager.onError = { error in
            print (error)
        }
        
        fetchAirports()
        fetchTravelPlans(token: "3146379b-9e2d-4d5b-9410-18589cc10c80")
        
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
    func fetchRestrictions(flightInfo: Flight, nationality: String?, vaccine: String?, transfer: String?) {
        apiManager.fetchRestrictions(flightInfo: flightInfo, nationality: nationality, vaccine: vaccine, transfer: transfer) { [weak self] result in
            if let response = result {
                if let restrictions = response.restricions {
                    self?.restrictionsDidFetch?(restrictions)
                }
            }
        }
    }
    
    func fetchTravelPlans(token: String) {
        apiManager.fetchTravelPlans(token: token) { [weak self] result in
            if let response = result {
                self?.travelPlansDidFetch?(response.travelPlans)
            }
        }
    }
    
    //Add new travel plan
    func addTravelPlan(token: String, flightInfo: Flight) {
        apiManager.addTravelPlan(token: token, flightInfo: flightInfo) { [weak self] result in
            if let response = result {
                self?.travelPlanDidAdd?(response.success)
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
    func editTravelPlan(token: String, flightInfo: Flight, flightID: String) {
        apiManager.editTravelPlan(token: token, flightInfo: flightInfo, flightID: flightID) { [weak self] result in
            if let response = result {
                self?.travelPlanDidEdit?(response.success)
            }
        }
    }
    
    
    
}



//Works
//        apiManager.fetchSelf(token: "ad7ddf1f-1960-4599-be6e-c76d74798c17") { Response in
//            if let response = Response{
//                print (response.user)
//            }
//        }

//Works
//        apiManager.createUser(userEmail: "nicolas45@gmail.com", userPassword: "123", userData: UserData(nationality: "Georgian", vaccine: "pfizer")) { response in
//            print (response)
//            }

//Works
//        apiManager.logInUser(userEmail: "nika@example.com", userPassword: "123") { response in
//            print (response)
//        }

//Works
//        apiManager.fetchVaccines { vaccines in
//            print (vaccines)
//        }

