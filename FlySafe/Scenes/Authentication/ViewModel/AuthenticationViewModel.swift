//
//  RegistrationViewModel.swift
//  FlySafe
//
//  Created by Nika Topuria on 09.01.22.
//

import Foundation


class AuthenticationViewModel {
    
    private let networkService = DefaultNetworkService()
    private let apiManager: APIManager
    
    var userDidAuthenticate: ((User, String) -> (Void))?
    var didFetchSelf: ((User) -> (Void))?
    
    
    init() {
        apiManager = APIManager(with: networkService)
        apiManager.onError = { error in
            print (error)
        }
        
    }
    
    //Create new user
    func authenticateUser(email: String, password: String, userData: UserData?) {
        if let userData = userData {
            apiManager.createUser(userEmail: email, userPassword: password, userData: userData) { [weak self] result in
                if let response = result {
                    if let user = response.user, let token = response.token {
                        self?.userDidAuthenticate?(user, token)
                    }
                }
            }
        } else {
            apiManager.logInUser(userEmail: email, userPassword: password) { [weak self] result in
                if let response = result {
                    if let user = response.user, let token = response.token {
                        self?.userDidAuthenticate?(user, token)
                    }
                }
            }
        }
    }
    
    func fetchUser(token: String) {
        apiManager.fetchSelf(token: token) { [weak self] result in
            if let response = result{
                self?.didFetchSelf?(response.user)
            }
        }
    }
    
}

//Works
//        apiManager.fetchVaccines { vaccines in
//            print (vaccines)
//        }
