//
//  AuthResponse.swift
//  FlySafe
//
//  Created by Nika Topuria on 19.12.21.
//

import Foundation


struct AuthResponse: Codable {
    let success: Bool
    let error: String?
    let token: String?
    let user: User?
}
