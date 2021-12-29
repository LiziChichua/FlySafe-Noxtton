//
//  MainView.swift
//  FlySafe
//
//  Created by Nika Topuria on 29.12.21.
//

import UIKit

class MainView: UIView {
    
    let gap: CGFloat = 20.0
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            createSubviews()
        }

        required init?(coder: NSCoder) {
            fatalError()
        }

        func createSubviews() {
            // all the layout code from above
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
            greetingLabel.frame = CGRect(x: gap, y: menuButton.frame.maxY + 5, width: UIScreen.main.bounds.width-40, height: 30)
            greetingLabel.font = .systemFont(ofSize: 24, weight: .semibold)
            greetingLabel.textColor = .black
            greetingLabel.numberOfLines = 1
            greetingLabel.textAlignment = .left
            greetingLabel.text = "Hello "
            
            
            //Add new flight title
            let newFlightLabel  = UILabel()
            newFlightLabel.text = "Add new flight"
            newFlightLabel.font = .systemFont(ofSize: 18, weight: .bold)
            newFlightLabel.sizeToFit()
            newFlightLabel.frame = CGRect(x: gap, y: greetingLabel.frame.maxY + 40, width: newFlightLabel.intrinsicContentSize.width + 5, height: 25)
            
            
            
            
            self.addSubview(menuButton)
            self.addSubview(greetingLabel)
            self.addSubview(newFlightLabel)
        }

}
