//
//  MainView.swift
//  FlySafe
//
//  Created by Nika Topuria on 29.12.21.
//

import UIKit

class MainView: UIView {
    
    var authorisedUser: Bool
    
    //Side menu button
    let menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .black
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        return button
    }()
    
    //Greeting label
    let greetingLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "Hello "
        return label
    }()
    
    
    //Create main table view
    let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.clear
        return tableView
    }()
    



override init(frame: CGRect) {
    authorisedUser = true
    super.init(frame: frame)
    
    //Set background color
    self.backgroundColor = .white
    
    //Add subviews
    self.addSubview(menuButton)
    self.addSubview(greetingLabel)
    self.addSubview(homeTableView)
    
    
    menuButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 60).isActive = true
    menuButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    menuButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
    menuButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    greetingLabel.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 15).isActive = true
    greetingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.gap).isActive = true
    greetingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.gap).isActive = true
    greetingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

    homeTableView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor).isActive = true
    homeTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    homeTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    homeTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.gap).isActive = true
    
}

required init?(coder: NSCoder) {
    fatalError()
}

}
