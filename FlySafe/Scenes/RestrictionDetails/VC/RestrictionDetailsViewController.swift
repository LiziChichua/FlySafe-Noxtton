//
//  RestrictionDetailsViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class RestrictionDetailsViewController: BaseViewController {

    var restrictionDetailsView = RestrictionDetailsView()
    
    override func loadView() {
        view = restrictionDetailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        restrictionDetailsView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

}
