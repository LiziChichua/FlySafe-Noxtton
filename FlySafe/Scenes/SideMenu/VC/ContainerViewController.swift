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
    //let homeVC = HomeViewController()
    var navVC: UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        addChildVCs()
        
    }
    
    private func addChildVCs() {
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
//        homeVC.delegate = self
//        let navVC = UINavigationController(rootViewController: homeVC)
//        addChild(navVC)
//        view.addSubview(navVC.view)
//        navVC.didMove(toParent: self)
//        self.navVC = navVC
        
        MainVC.delegate = self
        let navVC = UINavigationController(rootViewController: MainVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }

}


//extension ContainerViewController: HomeViewControllerDelegate {
//    func didTapMenuButton() {
//        switch menuState {
//        case .closed:
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
////                self.homeVC.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
//                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
//            } completion: { [weak self] done in
//                if done {
//                    self?.menuState = .opened
//                }
//            }
//
//        case .opened:
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
//                self.navVC?.view.frame.origin.x = 0
//            } completion: { [weak self] done in
//                if done {
//                    self?.menuState = .closed
//                }
//            }
//        }
//    }
//}

extension ContainerViewController: MainViewControllerDelegate {
    func didTapMenuButton() {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.MainVC.view.frame.size.width - 100
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
