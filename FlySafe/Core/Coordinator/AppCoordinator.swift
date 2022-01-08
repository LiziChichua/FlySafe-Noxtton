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
        let vc = MainViewController()
        vc.coordinator = self
        vc.gotoRestrictionsVC = { [weak self] restrictions in
            self?.gotoRestrictionsVC(restrictions: restrictions)
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
}
