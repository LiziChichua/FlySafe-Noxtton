//
//  TravelPlan.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct TravelPlan: Codable {
    let source, destination, date, user: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case source, destination, date, user
        case id = "_id"
    }
}
