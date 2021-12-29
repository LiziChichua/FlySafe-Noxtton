//
//  FetchTravelPlansResponse.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct FetchTravelPlansResponse: Codable {
    let success: Bool
    let travelPlans: [TravelPlan]
}
