//
//  MenuTableViewCell.swift
//  FlySafe
//
//  Created by LiziChichua on 08.01.22.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    //Menu Options Label
    let menuOptionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Menu Options Label"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .left
        label.sizeToFit()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.addSubview(menuOptionsLabel)
        
        //Constraints
        NSLayoutConstraint.activate([
            menuOptionsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            menuOptionsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            menuOptionsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            menuOptionsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 15)
        
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
