//
//  TravelPlan.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct TravelPlan: Codable, Loopable {
    var source, destination, date : String
    var transfer: String
    var user: String?
    var id: String?

    enum CodingKeys: String, CodingKey {
        case source, destination, date, user, transfer
        case id = "_id"
    }
}
