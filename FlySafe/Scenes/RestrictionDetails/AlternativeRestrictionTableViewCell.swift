//
//  RestrictionTableViewCell.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class AlternativeRestrictionTableViewCell: UITableViewCell {
    
    var restrictions: [String : Restrictions]?
    
    let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        return stack
    }()
    
    func boldLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height + 15).isActive = true
        return label
    }
    
    func secondaryLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height + 10).isActive = true
        return label
    }
    
    func semiboldLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakStrategy = .standard
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.sizeToFit()
        label.heightAnchor.constraint(equalToConstant: label.intrinsicContentSize.height + 5).isActive = true
        return label
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(verticalStack)
        
        verticalStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.gap).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30).isActive = true
        
        guard let restrictions = restrictions else { return }

            let mapped = restrictions.compactMap({ value in
                value
            })
            print (mapped)
        
        
        
        
        verticalStack.addArrangedSubview(boldLabel(text: "TBS to BER"))
        verticalStack.addArrangedSubview(secondaryLabel(text: "General Restrictions:"))
        verticalStack.addArrangedSubview(semiboldLabel(text: "Some restrictions!!!!!: afsufgailugfalieurfgaiergfaiurgf"))
        
        
        
        
//
//            dashedLineView.topAnchor.constraint(equalTo: locatorFormRequiredLabel.bottomAnchor, constant: 15),
//            dashedLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            dashedLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            dashedLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
//        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
