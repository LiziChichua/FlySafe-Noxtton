//
//  SummaryListTitleCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 08.01.22.
//

import UIKit

class SummaryListTitleCell: UITableViewCell {
    
    let summaryViewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Upcoming Flights"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.sizeToFit()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.contentView.addSubview(summaryViewTitle)
        
        
        summaryViewTitle.topAnchor.constraint(equalTo:  self.contentView.topAnchor, constant: 25).isActive = true
        summaryViewTitle.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        summaryViewTitle.widthAnchor.constraint(equalToConstant: summaryViewTitle.intrinsicContentSize.width + 5).isActive = true
        summaryViewTitle.heightAnchor.constraint(equalToConstant: summaryViewTitle.intrinsicContentSize.height + 5).isActive = true
        summaryViewTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
