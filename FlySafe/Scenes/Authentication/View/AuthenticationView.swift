//
//  RegistrationView.swift
//  FlySafe
//
//  Created by Nika Topuria on 09.01.22.
//

import UIKit

class AuthenticationView: UIView {
    
    var isNewUser: Bool? {
        didSet {
            if !isNewUser! {
                greetingLabel.text = "Welcome Back"
                loginButton.setTitle("Log In", for: .normal)
                nameField.isHidden = true
                surnameField.isHidden = true
                vaccineList.isHidden = true
                nationalityList.isHidden = true
                verticalStack.subviews.first?.isHidden = true
                verticalStack.subviews.forEach({
                    $0.removeFromSuperview()
                })
                verticalStack.addArrangedSubview(emailField)
                verticalStack.addArrangedSubview(lineView())
                verticalStack.addArrangedSubview(passwordField)
                verticalStack.addArrangedSubview(lineView())
                switchAuthenticationStatus.setTitle("Don't have an account?", for: .normal)
                verticalStack.addArrangedSubview(switchAuthenticationStatus)
                verticalStack.heightAnchor.constraint(equalToConstant: CGFloat(3 * 50)).isActive = true
                
            }
        }
    }
    
    //Side menu button
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .fill
        button.tintColor = .black
        button.isUserInteractionEnabled = true
        return button
    }()
    
    
    //Greeting label
    var greetingLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "Welcome Aboard :)"
        return label
    }()
    
    let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()
    
    //Name field
    let nameField: UITextField = {
        let textField = UITextField()
        textField.sizeToFit()
        textField.placeholder = "Name"
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .black
        return textField
    }()
    
    //Surname field
    let surnameField: UITextField = {
        let textField = UITextField()
        textField.sizeToFit()
        textField.placeholder = "Surname(s)"
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .black
        return textField
    }()
    
    //Vaccine field
    let vaccineList: DropDown = {
        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.placeholder = "Vaccine received"
        dropDown.optionArray = ["No Data"]
        return dropDown
    }()
    
    //Nationality field
    let nationalityList: DropDown = {
        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.placeholder = "Nationality"
        dropDown.optionArray = ["No Data"]
        return dropDown
    }()
    
    //Email field
    let emailField: UITextField = {
        let textField = UITextField()
        textField.sizeToFit()
        textField.placeholder = "Email address"
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .black
        return textField
    }()
    
    //Password field
    let passwordField: UITextField = {
        let textField = UITextField()
        textField.sizeToFit()
        textField.placeholder = "Password (more than 6 characters)"
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .black
        textField.isSecureTextEntry = true
        return textField
    }()
    
    func lineView() -> UIView {
       let line = UIView()
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.backgroundColor = .black
        return line
    }
    
    var switchAuthenticationStatus: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Already have an account?", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create User", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.titleLabel?.textColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = UIColor(hex: "10A5F9")
        button.layer.cornerRadius = 54/2
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        return button
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Set background color
        self.backgroundColor = .white
        
        //Add subviews
        self.addSubview(backButton)
        self.addSubview(greetingLabel)
        self.addSubview(verticalStack)
        self.addSubview(loginButton)
        verticalStack.addArrangedSubview(nameField)
        verticalStack.addArrangedSubview(lineView())
        verticalStack.addArrangedSubview(surnameField)
        verticalStack.addArrangedSubview(lineView())
        verticalStack.addArrangedSubview(nationalityList)
        verticalStack.addArrangedSubview(lineView())
        verticalStack.addArrangedSubview(vaccineList)
        verticalStack.addArrangedSubview(lineView())
        verticalStack.addArrangedSubview(emailField)
        verticalStack.addArrangedSubview(lineView())
        verticalStack.addArrangedSubview(passwordField)
        verticalStack.addArrangedSubview(lineView())
        verticalStack.addArrangedSubview(switchAuthenticationStatus)
        
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
        greetingLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 10).isActive = true
        greetingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.gap).isActive = true
        greetingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.gap).isActive = true
        greetingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        verticalStack.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: Constants.gap).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: greetingLabel.leadingAnchor).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: greetingLabel.trailingAnchor).isActive = true
        verticalStack.heightAnchor.constraint(equalToConstant: CGFloat(verticalStack.subviews.count/2 * 50)).isActive = true
        
        loginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: greetingLabel.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: greetingLabel.trailingAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}
