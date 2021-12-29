//
//  FetchVaccinesRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct FetchVaccinesRequest: DataRequest {
    
    var url: String { "http://covid-restrictions-api.noxtton.com/v1/vaccine" }
    var method: HTTPMethod = .get
    typealias Response = FetchVaccinesResponse
    
}
