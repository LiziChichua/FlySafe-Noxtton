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
//        let vc = MainViewController()
//        vc.coordinator = self
//        vc.gotoRestrictionsVC = { [weak self] in
//            self?.gotoRestrictionsVC()
//        }
//        navigationController?.pushViewController(vc, animated: true)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
        
        let vc = ContainerViewController()
        vc.coordinator = self
        vc.MainVC.gotoRestrictionsVC = { [weak self] in
            self?.gotoRestrictionsVC()
        }
        navigationController?.pushViewController(vc, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func gotoRestrictionsVC() {
        let vc = RestrictionDetailsViewController()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
