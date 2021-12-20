//
//  User.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation

// MARK: - User
struct User: Codable {
    let email: String
    let data: UserData
    let id: String

    enum CodingKeys: String, CodingKey {
        case email, data
        case id = "_id"
    }
}

// MARK: - UserData
struct UserData: Codable, Loopable {
    let nationality: String?
    let vaccine: String
}

