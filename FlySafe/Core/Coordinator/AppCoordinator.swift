//
//  AppCoordinator.swift
//  FlySafe
//
//  Created by LiziChichua on 19.12.21.
//

import UIKit
import CoreLocation

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
        if isThisFirstLaunch() {
            vc = loadOnboardingVC()
        } else {
            if let token = checkForSavedToken() {
                vc = loadMainVC(userToken: token)
            } else {
                vc = loadMainVC(userToken: nil)
            }
        }

        navigationController?.pushViewController(vc, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    //Loads onboarading view
    func loadOnboardingVC() -> UIViewController {
        let vc = OnboardingVC()
        vc.didFinishOnboarding = { [weak self] in
            if let token = self?.checkForSavedToken() {
                guard let vc = self?.loadMainVC(userToken: token) else {return}
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                guard let vc = self?.loadMainVC(userToken: nil) else {return}
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            self?.firstLaunchDidHappen()
        }
        return vc
    }
    
    
    //Loads main VC
    func loadMainVC(userToken: String?) -> UIViewController {
        let vc = ContainerViewController()
        vc.coordinator = self
        vc.userToken = userToken
        
        vc.MainVC.gotoRestrictionsVC = { [weak self] restrictions, travelPlan, saveButtonEnabled in
            self?.gotoRestrictionsVC(restrictions: restrictions, travelPlan: travelPlan, saveButtonEnabled: saveButtonEnabled)
        }
        
        vc.authenticationSelected = { [weak self] isNewUser in
            if isNewUser {
                self?.gotoAuthenticationVC(isNewUser: true)
            } else {
                self?.gotoAuthenticationVC(isNewUser: false)
            }
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
    func gotoRestrictionsVC(restrictions: [String : Restrictions], travelPlan: TravelPlan?, saveButtonEnabled: Bool) {
        DispatchQueue.main.async { [weak self] in
            let vc = RestrictionDetailsViewController()
            vc.restrictions = restrictions
            vc.travelPlan = travelPlan
            vc.userToken = self?.checkForSavedToken()
            if (self?.checkForSavedToken()) != nil && travelPlan != nil && saveButtonEnabled == true{
                vc.isSaveButtonEnabled = true
            }
            vc.coordinator = self
            self?.navigationController?.pushViewController(vc, animated: true)
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
                    self?.navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //Removes user token from userdefaults
    func removeUserToken() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "UserToken")
    }
    
    //Save flag that first launch has already happened
    func firstLaunchDidHappen() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "firstLaunchDidHappen")
    }
    
    //Check if this is the very first launch of app
    func isThisFirstLaunch() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "firstLaunchDidHappen") == true {
            return false
        } else {
            return true
        }
    }
    
    //Manages user logout
    func userDidLogout() {
        removeUserToken()
        
        let vc = loadMainVC(userToken: nil)
        navigationController?.pushViewController(vc, animated: true)
    }

}
