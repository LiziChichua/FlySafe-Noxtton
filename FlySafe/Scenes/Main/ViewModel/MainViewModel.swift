//
//  MainViewModel.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import Foundation
import CoreLocation
import Network

class MainViewModel: NSObject {
    
    private let networkService = DefaultNetworkService()
    private let apiManager: APIManager
    private var locationManager = LocationManager()
    private let storageManager = OfflineStorageManager()
    
    var userToken: String? {
        didSet {
            if let token = userToken {
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
    var didFetchWeather: ((WeatherResponse) -> (Void))?
    var didFetchLocation: ((CLLocation) -> (Void))?
    var didLoseNetworkConnection: (() -> (Void))?
    var didConnectToNetwork: (() -> (Void))?
    
    
    override init() {
        apiManager = APIManager(with: networkService)
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
                let defaults = UserDefaults.standard
                if let data = self?.storageManager.convertToJson(info: response.airports) {
                    defaults.set(data, forKey: "airports")
                    self?.airportsDidFetch?(response.airports)
                }
            }
        }
    }
    
    //Update user location
    func updateLocation() {
        locationManager.updateLocation()
    }
    
    //Fetches restrictions data for all user travel plans and returns combined offlineItem array
    func fetchAllRestrictions(userData: UserData, travelPlans: [TravelPlan]){
        var allOfflineItems: [OfflineItem] = []
        travelPlans.forEach ({ plan in
            apiManager.fetchRestrictions(travelPlan: plan, nationality: userData.nationality, vaccine: userData.vaccine) { [weak self] result in
                if let response = result {
                    if let restrictions = response.restricions {
                        allOfflineItems.append(OfflineItem(travelPlan: plan, restrictions: restrictions))
                        if travelPlans.count == allOfflineItems.count {
                            self?.saveOfflineItemsToDisk(offlineItems: allOfflineItems)
                            print ("Save command executed")
                        }
                    }
                }
            }
        })
    }
    
    
    //Save offlineItem array to disk
    private func saveOfflineItemsToDisk(offlineItems: [OfflineItem]) {
        if let data = storageManager.convertToJson(info: offlineItems) {
            storageManager.saveJsonToFile(data: data)
        } else {
            debugPrint("Error saving offline items to disk")
        }
    }
    
    //Start network monitoring
    func startNetworkMonitor() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.didConnectToNetwork?()
            } else {
                self?.didLoseNetworkConnection?()
            }
        }
        monitor.start(queue: queue)
    }
    
    //Load offlineItems from disk
    func readOfflineItemsFromDisk() -> [OfflineItem]? {
        if let data = storageManager.readFromJsonFile() {
            if let offlineItems = storageManager.decodeFromRawData(data: data) {
                return offlineItems
            }
        }
        return nil
    }
    
    //Fetch restrictions for given travelPlan
    func fetchRestrictions(travelPlan: TravelPlan, nationality: String?, vaccine: String?, saveButtonEnabled: Bool) {
        apiManager.fetchRestrictions(travelPlan: travelPlan, nationality: nationality, vaccine: vaccine) { [weak self] result in
            if let response = result {
                if let restrictions = response.restricions {
                    self?.restrictionsDidFetch?(restrictions, travelPlan, saveButtonEnabled)
                }
            }
        }
    }
    
    //Fetch travel plans from API
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
    func fetchWeatherInfo(lat: Double, lon: Double) {
        apiManager.fetchWeather(latitude: lat, longitude: lon, completion: { [weak self] result in
            self?.didFetchWeather?(result)
        })
    }
    
}

