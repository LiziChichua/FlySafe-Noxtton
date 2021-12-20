//
//  DeleteTravelPlanRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct DeleteTravelPlanRequest: DataRequest{
    
    var method: HTTPMethod = .delete
    typealias Response = DeleteResponse
    var url: String
    var headers: [String : String] = [:]
    
    init(token: String, flightID: String) {
        url = "http://covid-restrictions-api.noxtton.com/v1_private/travelplan/\(flightID)"
        
        headers["x-session-id"] = token
    }
}
