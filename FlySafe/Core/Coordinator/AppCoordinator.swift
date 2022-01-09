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
    
    func start() {
        let vc = ContainerViewController()
        vc.coordinator = self
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

        navigationController?.pushViewController(vc, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func gotoRestrictionsVC(restrictions: [String : Restrictions]) {
        DispatchQueue.main.async {
            let vc = RestrictionDetailsViewController()
            vc.restrictions = restrictions
            vc.coordinator = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    func gotoAuthenticationVC(isNewUser: Bool) {
        let vc = AuthenticationViewController()
        vc.coordinator = self
        vc.isNewUser = isNewUser
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func userDidAuthenticate() {
        
    }
    
    func gotoPasswordChangeVC() {
        
    }
    
    func userDidLogout() {
        
    }

}
