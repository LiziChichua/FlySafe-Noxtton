//
//  WeatherRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 30.01.22.
//

import Foundation


struct WeatherRequest: DataRequest {
    
    typealias Response = WeatherResponse
    var method: HTTPMethod = .get
    var url: String { "https://api.weatherapi.com/v1/current.json" }
    var queryItems: [String : String] = [:]
    
    init(latitude: Double, longitude: Double) {
        queryItems["key"] = "ca3b29ef1f454c40ad7150622221601"
        queryItems["q"] = "\(latitude),\(longitude)"
    }
}
