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
    
    var vaccines: [String]? {
        didSet {
            if let vaccines = vaccines {
                authenticationView.vaccineList.optionArray = vaccines
            }
        }
    }
    
    var nationalities: [String]? {
        didSet {
            if let nationalities = nationalities {
                authenticationView.nationalityList.optionArray = nationalities
            }
        }
    }
    
    override func loadView() {
        view = authenticationView
    }
    
    func initialiseVMClosures() {
        
        viewModel.userDidAuthenticate = { [weak self] user, token in
                self?.userDidAuthenticate?(user, token)
        }
        
        viewModel.vaccinesDidFetch = { [weak self] vaccines in
            DispatchQueue.main.async {
                self?.vaccines = vaccines
            }
        }
        
        viewModel.didfetchNationalities = { [weak self] nationalities in
            DispatchQueue.main.async {
                self?.nationalities = nationalities
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        hideKeyboardWhenTappedAround()
        
        initialiseVMClosures()
        
        viewModel.fetchVaccines()
        viewModel.fetchNationalities()
        
        authenticationView.isNewUser = isNewUser
        
        authenticationView.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        authenticationView.loginButton.addTarget(self, action: #selector(authenticationButtonPressed), for: .touchUpInside)
        
        authenticationView.switchAuthenticationStatus.addTarget(self, action: #selector(switchUserStatus), for: .touchUpInside)

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
                guard let email = authenticationView.emailField.text?.lowercased() else { return }
                guard let password = authenticationView.passwordField.text else { return }
                
                if name.isEmpty || surname.isEmpty || nationality.isEmpty || vaccine.isEmpty || !isValidEmailAddress(emailAddressString: email) || password.isEmpty || password.count < 6 {
                    incompleteFormAlert()
                } else {
                    let userData = UserData(name: name, surname: surname, nationality: nationality, vaccine: vaccine)
                    
                    viewModel.authenticateUser(email: email, password: password, userData: userData)
                }
            } else {
                guard let email = authenticationView.emailField.text?.lowercased() else { return }
                guard let password = authenticationView.passwordField.text else { return }
                if !isValidEmailAddress(emailAddressString: email) || password.isEmpty || password.count < 6 {
                    incompleteFormAlert()
                } else {
                    viewModel.authenticateUser(email: email, password: password, userData: nil)
                }
            }
        }
        
    }
    
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func incompleteFormAlert() {
        let alert = UIAlertController(title: "Missing fields", message: "Please fill all given fields, make sure password is at least 6 characters long.", preferredStyle: .alert)
        alert.addAction(.init(title: "Try again", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.isEmpty
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
}
