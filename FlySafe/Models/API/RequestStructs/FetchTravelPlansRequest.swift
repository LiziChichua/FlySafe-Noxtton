//
//  FetchTravelPlansRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct FetchTravelPlansRequest: DataRequest {
    
    var method: HTTPMethod = .get
    typealias Response = FetchTravelPlansResponse
    var url: String { "http://covid-restrictions-api.noxtton.com/v1_private/travelplan" }
    var headers: [String : String] = [:]
    
    init(token: String) {
        headers["x-session-id"] = token
    }

}
