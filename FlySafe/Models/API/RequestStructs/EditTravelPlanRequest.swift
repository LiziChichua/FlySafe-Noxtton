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
    var bodyItems: [String : Any] = [:]
    
    init(token: String, travelPlan: TravelPlan) {
        url = ""
        if let id = travelPlan.id {
            url = "http://covid-restrictions-api.noxtton.com/v1_private/travelplan/\(id)"
        }
        
        headers["x-session-id"] = token
        
        if let flight = try? travelPlan.allProperties() {
            flight.forEach { (key: String, value: Any) in
                if key != "user" && key != "id"{
                    self.bodyItems[key] = "\(value)"
                }
            }
        }
    }
}
