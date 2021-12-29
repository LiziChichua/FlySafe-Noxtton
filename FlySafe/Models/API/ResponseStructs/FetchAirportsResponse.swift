//
//  FetchAirports.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct FetchAirportsResponse: Codable {
    let success: Bool
    let airports: [Airport]
}

