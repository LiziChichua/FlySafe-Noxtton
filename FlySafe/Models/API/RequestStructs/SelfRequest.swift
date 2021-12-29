//
//  SelfRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct SelfRequest: DataRequest {
    
    var method: HTTPMethod = .get
    typealias Response = FetchSelfResponse
    var url: String { "http://covid-restrictions-api.noxtton.com/v1_private/self"}
    var headers: [String : String] = [:]

    init(token: String) {
        headers["x-session-id"] = token
    }

}
