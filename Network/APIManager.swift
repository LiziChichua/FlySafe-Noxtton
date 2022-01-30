//
//  APIManager.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation
import UIKit


class APIManager {
    
    private let networkService: NetworkService
    var onError: ((Error) -> Void)?
    
    init(with service: NetworkService) {
        self.networkService = service
    }
    
    //Create new user
    func createUser(userEmail: String, userPassword: String, isNewUser: Bool = true, userData: UserData?, completion: @escaping (AuthResponse?) -> Void) {
        let request = AuthRequest(userEmail: userEmail, userPassword: userPassword, isNewUser: isNewUser, userData: userData)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Authenticate existing user
    func logInUser(userEmail: String, userPassword: String, isNewUser: Bool = false, completion: @escaping (AuthResponse?) -> Void) {
        let request = AuthRequest(userEmail: userEmail, userPassword: userPassword, isNewUser: isNewUser, userData: nil)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Fetch user data using his token
    func fetchSelf(token: String, completion: @escaping (FetchSelfResponse?) -> Void) {
        let request = SelfRequest(token: token)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Create new travel plan
    func addTravelPlan(token: String, travelPlan: TravelPlan, completion: @escaping (AddTravelPlanResponse?) -> Void ) {
        let request = AddTravelPlanRequest(token: token, travelPlan: travelPlan)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
        
    }
    
    //Fetch user travel plans
    func fetchTravelPlans(token: String, completion: @escaping (FetchTravelPlansResponse?) -> Void) {
        let request = FetchTravelPlansRequest(token: token)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Update existing travel plan
    func editTravelPlan(token: String, travelPlan: TravelPlan, completion: @escaping (AddTravelPlanResponse?) -> Void) {
        let request = EditTravelPlanRequest(token: token, travelPlan: travelPlan)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Remove existing travel plan
    func deleteTravelPlan(token: String, flightID: String, completion: @escaping (DeleteResponse?) -> Void) {
        let request = DeleteTravelPlanRequest(token: token, flightID: flightID)
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Fetch airports list
    func fetchAirports(completion: @escaping (FetchAirportsResponse?) -> Void) {
        let request = FetchAirportsRequest()
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Fetch available vaccine list
    func fetchVaccines(completion: @escaping (FetchVaccinesResponse?) -> Void) {
        let request = FetchVaccinesRequest()
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Fetch nationalities list
    func fetchNationalities(completion: @escaping (FetchNationalitiesResponse?) -> Void) {
        let request = FetchNationalitiesRequest()
        
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    //Fetch restrictions for given travel information
    func fetchRestrictions(travelPlan: TravelPlan, nationality: String?, vaccine: String?, completion: @escaping (FetchRestrictionsResponse?) -> Void) {
        let request = FetchRestrictionsRequest(travelPlan: travelPlan, nationality: nationality, vaccine: vaccine)

        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse) -> Void) {
        let request = WeatherRequest(latitude: latitude, longitude: longitude)
        
        networkService.request(request, completion: { [weak self] result in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(let error):
                self?.onError?(error)
            }
            
        })
    }
    
}
