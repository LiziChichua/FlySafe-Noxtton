//
//  MenuViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 08.01.22.
//

import UIKit

class MenuViewController: UIViewController {
    
    weak var delegate: sideMenuDelegate?
    var isNewUser: Bool?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.isScrollEnabled = false
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        //        table.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: "10A5F9")
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
}


extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let isNewUser = isNewUser {
            if isNewUser{
                return MenuOptionsForNewUser.allCases.count
            }
        }
        return MenuOptionsForRegisteredUser.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let isNewUser = isNewUser {
            if isNewUser {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                cell.backgroundColor = .clear
                cell.textLabel?.textColor = .white
                cell.textLabel?.text = MenuOptionsForNewUser.allCases[indexPath.row].rawValue
                //cell.menuOptionsLabel.text = MenuOptionsForNewUser.allCases[indexPath.row].rawValue
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = MenuOptionsForRegisteredUser.allCases[indexPath.row].rawValue
        //cell.menuOptionsLabel.text = MenuOptionsForRegisteredUser.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //Needs to be more elegant but my brain refuses to work better now ^_^.
        if let isNewUser = isNewUser {
            if isNewUser {
                switch MenuOptionsForNewUser.allCases[indexPath.row] {
                case .RegisterOrSignIn:
                    delegate?.registerPressed()
//                case .newUser:
//                    break
                }
            } else {
                switch MenuOptionsForRegisteredUser.allCases[indexPath.row] {
//                case .UserFullName:
//                    break
//                case .ChangePassword:
//                    break
                case .LogOut:
                    delegate?.logoutPressed()
                }
            }
        } else {
            switch MenuOptionsForRegisteredUser.allCases[indexPath.row] {
//            case .UserFullName:
//                break
//            case .ChangePassword:
//                break
            case .LogOut:
                delegate?.logoutPressed()
            }
        }
    }
    
}

protocol sideMenuDelegate: AnyObject {
    func registerPressed()
    func loginPressed()
    func changePasswordPressed()
    func logoutPressed()
}
