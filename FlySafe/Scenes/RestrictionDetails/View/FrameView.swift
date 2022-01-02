//
//  FrameView.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class FrameView: UIView {
    
    //Frame Table View
    let frameTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .red
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 300
        tableView.layer.cornerRadius = 20
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Set background color and view appearance
        self.backgroundColor = .white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 20
        
        //Add subviews
        self.addSubview(frameTableView)
        
        //Constraints
        NSLayoutConstraint.activate([
            frameTableView.topAnchor.constraint(equalTo: self.topAnchor),
            frameTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            frameTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            frameTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
