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
    var couldNotAuthenticate: (() -> (Void))?
    var vaccinesDidFetch: (([String]) -> (Void))?
    var didfetchNationalities: (([String]) -> (Void))?
    
    init() {
        apiManager = APIManager(with: networkService)
        apiManager.onError = { error in
            print (error)
        }
        
    }
    
    //Create or login new user
    func authenticateUser(email: String, password: String, userData: UserData?) {
        if let userData = userData {
            apiManager.createUser(userEmail: email, userPassword: password, userData: userData) { [weak self] result in
                if let response = result {
                    if let user = response.user, let token = response.token {
                        self?.saveUserTokenToUserDefaults(token: token)
                        self?.userDidAuthenticate?(user, token)
                    } else {
                        self?.couldNotAuthenticate?()
                    }
                }
            }
        } else {
            apiManager.logInUser(userEmail: email, userPassword: password) { [weak self] result in
                if let response = result {
                    if let user = response.user, let token = response.token {
                        self?.saveUserTokenToUserDefaults(token: token)
                        self?.userDidAuthenticate?(user, token)
                    } else {
                        self?.couldNotAuthenticate?()
                    }
                }
            }
        }
    }
    
    func saveUserTokenToUserDefaults(token: String) {
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "UserToken")
    }
    
    
    func fetchVaccines() {
        apiManager.fetchVaccines { [weak self] result in
            if let response = result {
                self?.vaccinesDidFetch?(response.vaccines)
            }
        }
    }
    
    func fetchNationalities() {
        apiManager.fetchNationalities(completion: { [weak self] result in
            if let response = result {
                self?.didfetchNationalities?(response.nationalities)
            }
            
        })
        
    }
    
}


