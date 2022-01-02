//
//  HomeTVBottomCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import UIKit

class HomeTVBottomCell: UITableViewCell {
    
    
    
    let summaryViewTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Upcoming Flights"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.sizeToFit()
        return label
    }()
    
    
    let summaryContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    
    func tripSummaryView(viewCount: Int, source: String, connections: [String]?, destination: String) -> UIView {
        
        //Create label for source
        let sourceLabel = UILabel()
        sourceLabel.text = source
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.font = .systemFont(ofSize: 18, weight: .medium)
        sourceLabel.sizeToFit()
        sourceLabel.frame = CGRect(x: summaryContainer.bounds.minX+15, y: summaryContainer.bounds.minY+85, width: sourceLabel.intrinsicContentSize.width+5, height: sourceLabel.intrinsicContentSize.height)
        
        
        //Create label for destination
        let destinationLabel = UILabel()
        destinationLabel.text = destination
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationLabel.font = .systemFont(ofSize: 18, weight: .medium)
        destinationLabel.sizeToFit()
        destinationLabel.frame = CGRect(x: summaryContainer.bounds.maxX-15, y: summaryContainer.bounds.minY+85, width: destinationLabel.intrinsicContentSize.width+5, height: destinationLabel.intrinsicContentSize.height)
        
        summaryContainer.addSubview(sourceLabel)
        summaryContainer.addSubview(destinationLabel)
        
        
        return summaryContainer
    }
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.contentView.addSubview(summaryViewTitle)
        self.contentView.addSubview(summaryContainer)
        
        
        summaryViewTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        summaryViewTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        summaryViewTitle.widthAnchor.constraint(equalToConstant: summaryViewTitle.intrinsicContentSize.width+5).isActive = true
        summaryViewTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        summaryContainer.topAnchor.constraint(equalTo: summaryViewTitle.bottomAnchor, constant: 13).isActive = true
        summaryContainer.heightAnchor.constraint(equalToConstant: 180).isActive = true
        summaryContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        summaryContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.gap).isActive = true
        summaryContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
