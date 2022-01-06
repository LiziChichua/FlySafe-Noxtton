//
//  CheckResstrictionsButton.swift
//  FlySafe
//
//  Created by Nika Topuria on 06.01.22.
//

import UIKit

class CheckResstrictionsButton: UITableViewCell {
    
    var delegate: CheckRestrictionsDelegate?
    
    //Create CheckRestrictions button
    let checkRestrictions: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Check Restrictions", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.titleLabel?.textColor = .white
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = UIColor(hex: "10A5F9")
        button.layer.cornerRadius = 54/2
        button.addTarget(self, action: #selector(buttonTriger), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.isEnabled = true
        return button
    }()
    
    @objc func buttonTriger() {
        delegate?.checkRestrictionsPressed()
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.contentView.addSubview(checkRestrictions)
        
        
        checkRestrictions.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constants.gap*1.5).isActive = true
        checkRestrictions.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        checkRestrictions.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        checkRestrictions.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.gap).isActive = true
        checkRestrictions.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

protocol CheckRestrictionsDelegate {
    func checkRestrictionsPressed()
}
