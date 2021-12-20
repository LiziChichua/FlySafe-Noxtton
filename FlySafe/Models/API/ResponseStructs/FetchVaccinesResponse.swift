//
//  FetchVaccinesResponse.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct FetchVaccinesResponse: Codable {
    let success: Bool
    let vaccines: [String]
}
