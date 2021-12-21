//
//  AuthRequest.swift
//  FlySafe
//
//  Created by Nika Topuria on 20.12.21.
//

import Foundation


struct AuthRequest: DataRequest {
    
    var url: String
    var email: String
    var password: String
    var bodyItems: [String : Any] = [:]
    var userData: UserData?
    var method: HTTPMethod {.post}
    typealias Response = AuthResponse
    
    init(userEmail: String, userPassword: String, isNewUser: Bool, userData: UserData?) {
        self.email = userEmail
        self.password = userPassword
        self.userData = userData
        self.bodyItems = [
            "email": email,
            "password": password
        ]
        if isNewUser {
            self.url = "http://covid-restrictions-api.noxtton.com/v1/signup"
            var tempDict: [String : Any] = [:]
            if let data = userData {
                if let userDataProperties = try? data.allProperties() {
                    userDataProperties.forEach { (key: String, value: Any) in
                        tempDict[key] = "\(value)"
                    }
                    bodyItems["data"] = tempDict
                }
            }
        } else {
            self.url = "http://covid-restrictions-api.noxtton.com/v1/login"
        }
    }
}
