//
//  ContainerViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 08.01.22.
//

import UIKit

class ContainerViewController: BaseViewController {
    
    private var menuState: MenuState = .closed
    
    let MainVC = MainViewController()
    let menuVC = MenuViewController()
    var navVC: UINavigationController?
    
    var authenticationSelected: ((Bool) -> (Void))?
    var passwordChangeSelected: (() -> (Void))?
    var logoutSelected: (() -> (Void))?
    var userToken: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        MainVC.userToken = userToken
        if userToken != nil {
            menuVC.isNewUser = false
        } else {
            menuVC.isNewUser = true
        }
        
        menuVC.delegate = self
        view.backgroundColor = UIColor.red
        self.navigationController?.isNavigationBarHidden = true
        addChildVCs()
        
    }
    
    private func addChildVCs() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        MainVC.delegate = self
        let navVC = UINavigationController(rootViewController: MainVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}

extension ContainerViewController: MainViewControllerDelegate {
    func didTapSideMenuButton() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
//                self.navVC?.view.frame.origin.x = self.MainVC.view.frame.size.width - 200
                self.navVC?.view.frame.origin.x = self.MainVC.view.frame.size.width - (Constants.sideMenuCellWidth / 2)
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                }
            }
        }
    }
}

extension ContainerViewController: sideMenuDelegate {
    func registerPressed() {
        authenticationSelected?(true)
    }
    
    func loginPressed() {
        authenticationSelected?(false)
    }
    
    func changePasswordPressed() {
        passwordChangeSelected?()
    }
    
    func logoutPressed() {
        logoutSelected?()
    }
}
