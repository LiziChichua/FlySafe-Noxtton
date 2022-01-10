//
//  AppCoordinator.swift
//  FlySafe
//
//  Created by LiziChichua on 19.12.21.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {

    //MARK: - Private Properties
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
    }
    
    //Starts application with main view present
    func start() {
        var vc: UIViewController
        if let token = checkForSavedToken() {
            vc = loadMainVC(userToken: token)
        } else {
            vc = loadMainVC(userToken: nil)
        }

        navigationController?.pushViewController(vc, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    
    //Loads main VC
    func loadMainVC(userToken: String?) -> UIViewController {
        let vc = ContainerViewController()
        vc.coordinator = self
        vc.userToken = userToken
        
        vc.MainVC.gotoRestrictionsVC = { [weak self] restrictions in
            self?.gotoRestrictionsVC(restrictions: restrictions)
        }
        
        vc.authenticationSelected = { [weak self] isNewUser in
            if isNewUser {
                self?.gotoAuthenticationVC(isNewUser: true)
            } else {
                self?.gotoAuthenticationVC(isNewUser: false)
            }
        }
        
        vc.passwordChangeSelected = { [weak self] in
            self?.gotoPasswordChangeVC()
        }
        
        vc.logoutSelected = { [weak self] in
            self?.userDidLogout()
        }
        
        return vc
    }
    
    
    //Check if user has saved token
    func checkForSavedToken() -> String? {
        let defaults = UserDefaults.standard
        if let token = defaults.string(forKey: "UserToken") {
            return token
        } else {
            return nil
        }
    }
    
    
    //Goes to restriction details view
    func gotoRestrictionsVC(restrictions: [String : Restrictions]) {
        DispatchQueue.main.async {
            let vc = RestrictionDetailsViewController()
            vc.restrictions = restrictions
            vc.coordinator = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    //Goes to authentication view
    func gotoAuthenticationVC(isNewUser: Bool) {
        let vc = AuthenticationViewController()
        vc.coordinator = self
        vc.isNewUser = isNewUser
        vc.switchStatus = { [weak self] isNewUser in
            self?.gotoAuthenticationVC(isNewUser: isNewUser)
        }
        
        vc.userDidAuthenticate = { [weak self] user, token in
            DispatchQueue.main.async {
                if let vc = self?.loadMainVC(userToken: token) {
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func removeUserToken() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "UserToken")
    }
    
    func userDidAuthenticate() {
        
    }
    
    func gotoPasswordChangeVC() {
        
    }
    
    func userDidLogout() {
        removeUserToken()
        
        let vc = loadMainVC(userToken: nil)
        navigationController?.pushViewController(vc, animated: true)
    }

}
