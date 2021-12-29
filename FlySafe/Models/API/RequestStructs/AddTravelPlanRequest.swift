//
//  AddTravelPlanRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct AddTravelPlanRequest: DataRequest{
    
    var method: HTTPMethod = .post
    typealias Response = AddTravelPlanResponse
    var url: String { "http://covid-restrictions-api.noxtton.com/v1_private/travelplan" }
    var headers: [String : String] = [:]
    var bodyItems: [String : Any] = [:]
    
    init(token: String, flightInfo: Flight) {
        headers["x-session-id"] = token
        if let flight = try? flightInfo.allProperties() {
            flight.forEach { (key: String, value: Any) in
                self.bodyItems[key] = "\(value)"
            }
        }
    }
    
}
