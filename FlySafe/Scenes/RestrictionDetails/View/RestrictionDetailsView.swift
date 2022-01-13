//
//  RestrictionDetailsView.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class RestrictionDetailsView: UIView {
    
    var restrictions: [String : Restrictions]?
    
    var isSaveButtonEnabled: Bool? {
        didSet {
            if let buttonEnabled = isSaveButtonEnabled {
                if buttonEnabled {
                    savePlanButton.isHidden = false
                }
            }
        }
    }
    
    //Button to save plan
    let savePlanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Save plan  ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.titleLabel?.textColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = UIColor(hex: "10A5F9")
        button.layer.cornerRadius = Constants.cornerRadius
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        button.isHidden = true
        return button
    }()
    
    //Back button
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
    
    //Restriction Information label
    let restrictionInformationLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "Restriction Information"
        return label
    }()
    
    //Frame View
    let frameView: FrameView = {
        let frame = FrameView()
        frame.translatesAutoresizingMaskIntoConstraints = false
        frame.frameTableView.register(RestrictionTableViewCell.self, forCellReuseIdentifier: "RestrictionTableViewCell")
        return frame
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Set background color
        self.backgroundColor = .white
        
        //Add subviews
        //self.addSubview(menuButton)
        self.addSubview(backButton)
        self.addSubview(restrictionInformationLabel)
        self.addSubview(frameView)
        self.addSubview(savePlanButton)
        
        //Frame View DataSource & Delegate
        frameView.frameTableView.delegate = self
        frameView.frameTableView.dataSource = self
        
        //Constraints
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            
            savePlanButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            savePlanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            savePlanButton.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            savePlanButton.heightAnchor.constraint(equalToConstant: 25),
            
//            restrictionInformationLabel.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 15),
            restrictionInformationLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 15),
            restrictionInformationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            restrictionInformationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            restrictionInformationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            frameView.topAnchor.constraint(equalTo: restrictionInformationLabel.bottomAnchor, constant: 20),
            frameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            frameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            frameView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}


extension RestrictionDetailsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension RestrictionDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestrictionTableViewCell", for: indexPath) as! RestrictionTableViewCell
        cell.restrictions = restrictions
        return cell
    }
    
}


