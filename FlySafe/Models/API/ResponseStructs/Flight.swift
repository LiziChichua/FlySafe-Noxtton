//
//  Flight.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct Flight: Codable, Loopable {
    var source: String
    var transfer: String?
    var destination: String
    var date: String
}
