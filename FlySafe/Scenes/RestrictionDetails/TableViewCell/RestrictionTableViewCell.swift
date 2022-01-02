//
//  RestrictionTableViewCell.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class RestrictionTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubviews()
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
    
    func createSubviews() {
        
        //Source to Destination Label
        let sourceToDestinationLabel: UILabel = {
            let label = UILabel()
            label.text = "TBS to SAW"
            label.font = .systemFont(ofSize: 18, weight: .bold)
            label.sizeToFit()
            label.frame = CGRect(x: 20, y: self.bounds.minY + 30, width: label.intrinsicContentSize.width + 5, height: 25)
            return label
        }()
        
        //General Restrictions Label
        let generalRestrictionsLabel: UILabel = {
            let label = UILabel()
            label.text = "General Restrictions:"
            label.font = .systemFont(ofSize: 15, weight: .bold)
            label.sizeToFit()
            label.frame = CGRect(x: 20, y: sourceToDestinationLabel.bounds.minY + 5, width: label.intrinsicContentSize.width + 5, height: 25)
            return label
        }()
        
        //Add subviews
        self.contentView.addSubview(sourceToDestinationLabel)
        self.contentView.addSubview(generalRestrictionsLabel)
    }
    
}
