//
//  AddTravelPlanResponse.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct AddTravelPlanResponse: Codable {
    let success: Bool
    let travelPlan: TravelPlan
}
