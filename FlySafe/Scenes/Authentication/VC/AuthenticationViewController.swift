//
//  RegistrationViewController.swift
//  FlySafe
//
//  Created by Nika Topuria on 09.01.22.
//

import UIKit

class AuthenticationViewController: BaseViewController {
    
    var authenticationView = AuthenticationView()
    var viewModel = AuthenticationViewModel()
    var switchStatus: ((Bool) -> (Void))?
    var userDidAuthenticate: ((User, String) -> (Void))?
    var isNewUser: Bool?
    
    override func loadView() {
        view = authenticationView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
        
        authenticationView.isNewUser = isNewUser
        
        authenticationView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        authenticationView.loginButton.addTarget(self, action: #selector(authenticationButtonPressed), for: .touchUpInside)
        
        authenticationView.switchAuthenticationStatus.addTarget(self, action: #selector(switchUserStatus), for: .touchUpInside)
        
        
        viewModel.didFetchSelf = { [weak self] user in
            
        }
        
        viewModel.userDidAuthenticate = { [weak self] user, token in
            self?.userDidAuthenticate?(user, token)
        }
        
        
        
    }
    
    @objc func switchUserStatus() {
        if let isNewUser = isNewUser {
            navigationController?.popViewController(animated: true)
            switchStatus?(!isNewUser)
            
        }
    }
    
    @objc func authenticationButtonPressed() {
        if let isNewUser = isNewUser {
            if isNewUser {
                guard let name = authenticationView.nameField.text else { return }
                guard let surname = authenticationView.surnameField.text else { return }
                guard let nationality = authenticationView.nationalityList.text else { return }
                guard let vaccine = authenticationView.vaccineList.text else { return }
                guard let email = authenticationView.emailField.text else { return }
                guard let password = authenticationView.passwordField.text else { return }
                
                let userData = UserData(name: name, surname: surname, nationality: nationality, vaccine: vaccine)
                
                viewModel.authenticateUser(email: email, password: password, userData: userData)
            } else {
                guard let email = authenticationView.emailField.text else { return }
                guard let password = authenticationView.passwordField.text else { return }
                
                viewModel.authenticateUser(email: email, password: password, userData: nil)
            }
        }
        
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
}
