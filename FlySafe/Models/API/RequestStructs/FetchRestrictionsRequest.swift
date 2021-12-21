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
    typealias Response = FetchRestrictionsResponse
    
    init(nationality: String?, vaccine: String?, transfer: String?) {
        if let Nationality = nationality {
            print (Nationality)
        }
        if let Vaccine = vaccine {
            print (Vaccine)
        }
        if let Transfer = transfer {
            print (Transfer)
        }
    }
    
}
