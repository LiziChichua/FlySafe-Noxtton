//
//  OnboardingCVCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 01.02.22.
//

import UIKit
import Lottie

class OnboardingCVCell: UICollectionViewCell {
    
    
    let bottomLabelLarge: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.text = ""
         label.font = .systemFont(ofSize: 23, weight: .bold)
         label.numberOfLines = 2
         label.textAlignment = .center
         
         return label
    }()
    
    let bottomLabelSmall: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 2
        label.textAlignment = .center
        
        return label
    }()
    
    
    let animationView: AnimationView = {
        let animation = AnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.contentMode = .scaleAspectFill
        animation.loopMode = .playOnce
        animation.animationSpeed = 1
        
        return animation
    }()
    
    func makeCell(info: OnboardingCellInfo) {
        animationView.animation = Animation.named(info.image)
        animationView.play()
        bottomLabelLarge.text = info.largeText
        bottomLabelSmall.text = info.smallText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(animationView)
        self.contentView.addSubview(bottomLabelLarge)
        self.contentView.addSubview(bottomLabelSmall)
        
        
        animationView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        animationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        let animationHeight = animationView.heightAnchor.constraint(equalTo: animationView.widthAnchor)
        animationHeight.priority = UILayoutPriority(999)
        animationHeight.isActive = true
        
        bottomLabelLarge.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: Constants.gap*2).isActive = true
        bottomLabelLarge.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bottomLabelLarge.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        bottomLabelSmall.topAnchor.constraint(equalTo: bottomLabelLarge.bottomAnchor, constant: Constants.gap).isActive = true
        bottomLabelSmall.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        bottomLabelSmall.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomLabelSmall.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
}
