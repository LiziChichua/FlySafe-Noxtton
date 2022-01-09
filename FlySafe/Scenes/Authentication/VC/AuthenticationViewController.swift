//
//  RegistrationViewController.swift
//  FlySafe
//
//  Created by Nika Topuria on 09.01.22.
//

import UIKit

class AuthenticationViewController: BaseViewController {
    
    var authenticationView = AuthenticationView()
    var isNewUser: Bool?
    
    override func loadView() {
        view = authenticationView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
        
    }

}
