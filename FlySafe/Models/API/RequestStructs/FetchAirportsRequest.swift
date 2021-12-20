//
//  FetchAirportsRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct FetchAirportsRequest: DataRequest {
    
    var url: String { "http://covid-restrictions-api.noxtton.com/v1/airport" }
    var method: HTTPMethod = .get
    typealias Response = FetchAirportsResponse
    
}
