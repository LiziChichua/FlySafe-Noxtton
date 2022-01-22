//
//  MainViewModel.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import Foundation
import CoreLocation

class MainViewModel: NSObject {
    
    private let networkService = DefaultNetworkService()
    private var weatherManager: WeatherManagerProtocol
    private let apiManager: APIManager
    private var locationManager = LocationManager()
    
    var userToken: String? {
        didSet {
            if let token = userToken {
                fetchTravelPlans(token: token)
                fetchUser(token: token)
            }
        }
    }
    var airportsDidFetch: (([Airport]) -> (Void))?
    var restrictionsDidFetch: (([String : Restrictions], TravelPlan?, Bool) -> (Void))?
    var travelPlanDidRemove: ((Bool) -> (Void))?
    var travelPlanDidEdit: ((Bool) -> (Void))?
    var travelPlansDidFetch: (([TravelPlan]) -> (Void))?
    var didFetchUserData: ((User) -> (Void))?
    var didFetchWeather: ((Weather) -> (Void))?
    var didFetchLocation: ((CLLocation) -> (Void))?
    
    override init() {
        apiManager = APIManager(with: networkService)
        weatherManager = WeatherManager()
        apiManager.onError = { error in
            print (error)
        }
        super.init()
        fetchAirports()
        locationManager.didGetLocation = { [weak self] location in
            self?.didFetchLocation?(location)
        }
        locationManager.configureManager()
        locationManager.updateLocation()
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
    
    //Fetch user data
    func fetchUser(token: String) {
        apiManager.fetchSelf(token: token) { [weak self] result in
            if let response = result{
                self?.didFetchUserData?(response.user)
            }
        }
    }
    
    
    //Fetch weather info
    func fetchWeather(lat: Double, lon: Double) {
        weatherManager.fetchWeather(lat: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let weather):
                guard let self = self else { return }
                    self.didFetchWeather?(weather)
            case .failure(let err):
                print(err)
            }
        }
    }
    
}

