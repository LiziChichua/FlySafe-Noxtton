//
//  MenuViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 08.01.22.
//

import UIKit

//This Variable is Temporary - Only for testing UI
var isNewUser = false

class MenuViewController: UIViewController {
    
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

        view.backgroundColor = UIColor.systemGray2
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
        if isNewUser {
            return MenuOptionsForNewUser.allCases.count
        }
        return MenuOptionsForRegisteredUser.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNewUser {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .clear
            cell.textLabel?.text = MenuOptionsForNewUser.allCases[indexPath.row].rawValue
            //cell.menuOptionsLabel.text = MenuOptionsForNewUser.allCases[indexPath.row].rawValue
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = MenuOptionsForRegisteredUser.allCases[indexPath.row].rawValue
        //cell.menuOptionsLabel.text = MenuOptionsForRegisteredUser.allCases[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
