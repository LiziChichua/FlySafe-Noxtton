//
//  TravelPlan.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct TravelPlan: Codable, Loopable {
    let source, destination, date : String
    let transfer: String
    let user: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case source, destination, date, user, transfer
        case id = "_id"
    }
}
