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
    
    init(token: String, travelPlan: TravelPlan) {
        headers["x-session-id"] = token
        if let plan = try? travelPlan.allProperties() {
            
            plan.forEach { (key: String, value: Any) in
                if key != "user" && key != "id"{
                    self.bodyItems[key] = "\(value)"
                }
            }
        }
    }
    
}
