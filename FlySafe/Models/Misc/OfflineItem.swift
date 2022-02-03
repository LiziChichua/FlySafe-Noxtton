//
//  OfflineItem.swift
//  FlySafe
//
//  Created by Nika Topuria on 03.02.22.
//

import Foundation


struct OfflineItem: Codable, Loopable {
    let travelPlan: TravelPlan
    let restrictions: [String : Restrictions]
}
