//
//  FetchNationalitiesRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct FetchNationalitiesRequest: DataRequest {
    
    var url: String { "http://covid-restrictions-api.noxtton.com/v1/nationality" }
    var method: HTTPMethod = .get
    typealias Response = FetchNationalitiesResponse
    
}
