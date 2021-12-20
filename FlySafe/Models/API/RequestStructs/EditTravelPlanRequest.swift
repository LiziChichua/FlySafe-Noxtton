//
//  EditTravelPlanRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct EditTravelPlanRequest: DataRequest {
    
    var method: HTTPMethod = .put
    typealias Response = AddTravelPlanResponse
    var url: String
    var headers: [String : String] = [:]
    var queryItems: [String : String] = [:]
    
    init(token: String, flightInfo: Flight, flightID: String) {
        url = "http://covid-restrictions-api.noxtton.com/v1_private/travelplan/\(flightID)"
        
        headers["x-session-id"] = token
        if let flight = try? flightInfo.allProperties() {
            flight.forEach { (key: String, value: Any) in
                self.queryItems[key] = "\(value)"
            }
        }
    }
    
}
