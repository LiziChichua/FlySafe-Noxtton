//
//  RestrictionDetailsView.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class RestrictionDetailsView: UIView {
    
    //Side menu button
    let menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .black
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
        self.addSubview(menuButton)
        self.addSubview(backButton)
        self.addSubview(restrictionInformationLabel)
        self.addSubview(frameView)
        
        //Frame View DataSource & Delegate
        frameView.frameTableView.delegate = self
        frameView.frameTableView.dataSource = self
        
        //Constraints
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            menuButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            menuButton.widthAnchor.constraint(equalToConstant: 25),
            menuButton.heightAnchor.constraint(equalToConstant: 20),
            
            backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            
            restrictionInformationLabel.topAnchor.constraint(equalTo: menuButton.bottomAnchor, constant: 15),
            restrictionInformationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            restrictionInformationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            restrictionInformationLabel.heightAnchor.constraint(equalToConstant: 30),
            
            frameView.topAnchor.constraint(equalTo: restrictionInformationLabel.bottomAnchor, constant: 20),
            frameView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            frameView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            frameView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
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
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestrictionTableViewCell", for: indexPath)
        return cell
    }
    
}
