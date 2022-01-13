//
//  RestrictionDetailsViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class RestrictionDetailsViewController: BaseViewController {

    var restrictionDetailsView = RestrictionDetailsView()
    var isSaveButtonEnabled: Bool?
    var travelPlan: TravelPlan?
    var userToken: String?
    let viewmodel = RestrictionDetailsViewModel()

    var restrictions: [String : Restrictions]?
    
    override func loadView() {
        view = restrictionDetailsView
        restrictionDetailsView.isSaveButtonEnabled = isSaveButtonEnabled
        restrictionDetailsView.restrictions = restrictions
        restrictionDetailsView.savePlanButton.addTarget(self, action: #selector(buttonTriger), for: .touchUpInside)
        
        
        viewmodel.travelPlanDidAdd = { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    let nc = NotificationCenter.default
                    nc.post(name: Notification.Name("TravelPlanAdded"), object: nil)
                    let alert = UIAlertController(title: "Success", message: "Travel plan succesfylly added", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self?.present(alert, animated: true)
                } else {
                    let alert = UIAlertController(title: "Failure", message: "Travel plan couldn't be added", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func buttonTriger() {
        if let flightInfo = travelPlan, let userToken = userToken {
            viewmodel.addTravelPlan(token: userToken, flightInfo: flightInfo)
        }
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
