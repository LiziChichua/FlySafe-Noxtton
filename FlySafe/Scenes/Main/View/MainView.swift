//
//  MainView.swift
//  FlySafe
//
//  Created by Nika Topuria on 29.12.21.
//

import UIKit
import SkeletonView

class MainView: UIView {
    
    var authorisedUser: Bool
    
    //Side menu button
    var menuButton: UIButton = {
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
    
    //Temperature Label
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.textAlignment = .right
        label.text = ""
        return label
    }()
    
    var weatherIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.backgroundColor = .clear
        return image
    }()
    
    //City,Region label
    var locationLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = ""
        return label
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
        tableView.backgroundColor = .clear
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
    self.addSubview(temperatureLabel)
    self.addSubview(locationLabel)
    self.addSubview(weatherIcon)
    self.addSubview(greetingLabel)
    self.addSubview(homeTableView)
    
    temperatureLabel.isSkeletonable = true
    locationLabel.isSkeletonable = true
    
    temperatureLabel.showAnimatedGradientSkeleton()
    locationLabel.showAnimatedGradientSkeleton()
    
    menuButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
    menuButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    menuButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
    menuButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    temperatureLabel.topAnchor.constraint(equalTo: menuButton.bottomAnchor).isActive = true
    temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    temperatureLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
    temperatureLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    weatherIcon.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: -3).isActive = true
    weatherIcon.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor).isActive = true
    weatherIcon.heightAnchor.constraint(equalToConstant: 28).isActive = true
    weatherIcon.widthAnchor.constraint(equalToConstant: 28).isActive = true
    
    locationLabel.bottomAnchor.constraint(equalTo: temperatureLabel.topAnchor, constant: -3).isActive = true
    locationLabel.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor).isActive = true
    locationLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    locationLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    
    greetingLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor).isActive = true
    greetingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.gap).isActive = true
    greetingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.gap).isActive = true
    greetingLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

    homeTableView.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 5).isActive = true
    homeTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    homeTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    homeTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.gap).isActive = true
    
}

required init?(coder: NSCoder) {
    fatalError()
}

}
