//
//  RestrictionDetailsView.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class RestrictionDetailsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func createSubviews() {

        self.translatesAutoresizingMaskIntoConstraints = false
        
        //Set background color
        self.backgroundColor = .white
        
        //Back button
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.contentHorizontalAlignment = .left
        backButton.contentVerticalAlignment = .fill
        backButton.tintColor = .black
        backButton.frame = CGRect(x: 20, y: 50, width: 25, height: 20)
        
        //Side menu button
        let menuButton = UIButton()
        menuButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        menuButton.contentHorizontalAlignment = .fill
        menuButton.contentVerticalAlignment = .fill
        menuButton.tintColor = .black
        menuButton.frame = CGRect(x: UIScreen.main.bounds.width - 45, y: 50, width: 25, height: 20)
        
        
        //Restriction Information label
        let restrictionInformationLabel = UILabel()
        restrictionInformationLabel.sizeToFit()
//        restrictionInformationLabel.frame = CGRect(x: Constants.gap, y: menuButton.frame.maxY + 5, width: UIScreen.main.bounds.width-(Constants.gap*2), height: 30)
        restrictionInformationLabel.frame = CGRect(x: 20, y: menuButton.frame.maxY + 20, width: UIScreen.main.bounds.width-(20*2), height: 30)
        restrictionInformationLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        restrictionInformationLabel.textColor = .black
        restrictionInformationLabel.numberOfLines = 1
        restrictionInformationLabel.textAlignment = .left
        restrictionInformationLabel.text = "Restriction Information"
        
        //Frame View
        let frameView = FrameView()
        frameView.frame = CGRect(x: 20, y: restrictionInformationLabel.frame.maxY + 20, width: UIScreen.main.bounds.width-(20*2), height: UIScreen.main.bounds.height - 200)
        frameView.frameTableView.register(RestrictionTableViewCell.self, forCellReuseIdentifier: "RestrictionTableViewCell")
        frameView.frameTableView.delegate = self
        frameView.frameTableView.dataSource = self
        
        //Add subviews
        self.addSubview(menuButton)
        self.addSubview(backButton)
        self.addSubview(restrictionInformationLabel)
        self.addSubview(frameView)
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
