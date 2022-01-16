//
//  FetchRestrictionsRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct FetchRestrictionsRequest: DataRequest {
    
    var url: String = "http://covid-restrictions-api.noxtton.com/v1/restriction/"
    var method: HTTPMethod = .get
    var queryItems: [String : String] = [:]
    typealias Response = FetchRestrictionsResponse
    
    init(travelPlan: TravelPlan, nationality: String?, vaccine: String?) {
        let tempURL = "\(url)\(travelPlan.source)/\(travelPlan.destination)"
        url = tempURL
        if let nationalityInfo = nationality {
            queryItems["nationality"] = nationalityInfo
        }
        if let vaccineInfo = vaccine {
            queryItems["vaccine"] = vaccineInfo
        }
        queryItems["transfer"] = travelPlan.transfer
    }
}
