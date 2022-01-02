//
//  FrameView.swift
//  FlySafe
//
//  Created by LiziChichua on 02.01.22.
//

import UIKit

class FrameView: UIView {
    
    let frameTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func createSubviews() {

        self.translatesAutoresizingMaskIntoConstraints = false
        
        //Set background color and view appearance
        self.backgroundColor = .white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 20
    
        
        //Create frame table view
        frameTableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-(20*2), height: UIScreen.main.bounds.height - 200)
        frameTableView.backgroundColor = .yellow
        frameTableView.showsHorizontalScrollIndicator = false
        frameTableView.showsVerticalScrollIndicator = false
        frameTableView.allowsSelection = false
        frameTableView.estimatedRowHeight = 300
        frameTableView.layer.cornerRadius = 20

        //Add subviews
        self.addSubview(frameTableView)
    }
    
}
