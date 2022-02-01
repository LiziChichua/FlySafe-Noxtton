//
//  HomeTVPlaceHolderCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 31.01.22.
//

import UIKit
import Lottie

class HomeTVPlaceHolderCell: UITableViewCell {
    
    let topLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To access saved travel plans,\n Please authenticate."
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    
    let animationView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.animation = Animation.named("walkingTraveler")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.animationSpeed = 1.5
        animation.backgroundBehavior = .pauseAndRestore
        animation.play()
        
        return animation
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(topLabel)
        self.contentView.addSubview(animationView)
        
        topLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.gap).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        animationView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10).isActive = true
        animationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        let animationHeight = animationView.heightAnchor.constraint(equalToConstant: 250)
        animationHeight.priority = UILayoutPriority(999)
        animationHeight.isActive = true
        animationView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
