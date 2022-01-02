//
//  MainView.swift
//  FlySafe
//
//  Created by Nika Topuria on 29.12.21.
//

import UIKit

class MainView: UIView {
    
    var authorisedUser: Bool
    let homeTableView = UITableView()
    
    override init(frame: CGRect) {
        authorisedUser = true
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
        
        //Side menu button
        let menuButton = UIButton()
        menuButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        menuButton.contentHorizontalAlignment = .fill
        menuButton.contentVerticalAlignment = .fill
        menuButton.tintColor = .black
        menuButton.frame = CGRect(x: UIScreen.main.bounds.width - 45, y: 50, width: 25, height: 20)
        
        
        //Greeting label
        let greetingLabel = UILabel()
        greetingLabel.sizeToFit()
        greetingLabel.frame = CGRect(x: Constants.gap, y: menuButton.frame.maxY + 5, width: UIScreen.main.bounds.width-(Constants.gap*2), height: 30)
        greetingLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        greetingLabel.textColor = .black
        greetingLabel.numberOfLines = 1
        greetingLabel.textAlignment = .left
        greetingLabel.text = "Hello "
        
        //Create main table view
        homeTableView.frame = CGRect(x: 0, y: greetingLabel.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - greetingLabel.frame.maxY)
        homeTableView.backgroundColor = .yellow
        homeTableView.showsHorizontalScrollIndicator = false
        homeTableView.showsVerticalScrollIndicator = false
        homeTableView.allowsSelection = false
        homeTableView.estimatedRowHeight = 300
        
        //Add subviews
        self.addSubview(menuButton)
        self.addSubview(greetingLabel)
        self.addSubview(homeTableView)
    }
    
    
    
    
    func summaryViewLabel() -> UILabel {
        let summaryLabel = UILabel()
        summaryLabel.text = "Upcoming Flights"
        summaryLabel.font = .systemFont(ofSize: 18, weight: .bold)
        summaryLabel.sizeToFit()
        summaryLabel.frame = CGRect(x: Constants.gap, y: Constants.gap, width: summaryLabel.intrinsicContentSize.width + 5, height: 25)
        
        return summaryLabel
    }
    
    
    func tripSummaryView(viewCount: Int, source: String, connections: [String]?, destination: String) -> UIView {
        let summaryContainer = UIView()
        summaryContainer.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
        summaryContainer.layer.cornerRadius = Constants.cornerRadius
        summaryContainer.frame = CGRect(x: Constants.gap, y: Constants.gap, width: super.frame.maxY - Constants.gap*2, height: 177)
        
        
        //Create label for source
        let sourceLabel = UILabel()
        sourceLabel.text = source
        sourceLabel.font = .systemFont(ofSize: 18, weight: .medium)
        sourceLabel.sizeToFit()
        sourceLabel.frame = CGRect(x: summaryContainer.bounds.minX+15, y: summaryContainer.bounds.minY+85, width: sourceLabel.intrinsicContentSize.width+5, height: sourceLabel.intrinsicContentSize.height)
        
        
        //Create label for destination
        let destinationLabel = UILabel()
        destinationLabel.text = destination
        destinationLabel.font = .systemFont(ofSize: 18, weight: .medium)
        destinationLabel.sizeToFit()
        destinationLabel.frame = CGRect(x: summaryContainer.bounds.maxX-15, y: summaryContainer.bounds.minY+85, width: destinationLabel.intrinsicContentSize.width+5, height: destinationLabel.intrinsicContentSize.height)
  
        summaryContainer.addSubview(sourceLabel)
        summaryContainer.addSubview(destinationLabel)
        
        
        return summaryContainer
    }
    
}
