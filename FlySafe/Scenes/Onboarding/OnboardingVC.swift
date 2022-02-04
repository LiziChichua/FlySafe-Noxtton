//
//  OnboardingVC.swift
//  FlySafe
//
//  Created by Nika Topuria on 01.02.22.
//

import UIKit

class OnboardingVC: UIViewController {
    
    var didFinishOnboarding: (() -> (Void))?
    var counter = 0
    
    let animationArray = [ OnboardingCellInfo(image: "virusWorldAttack", largeText: "Welcome to FlySafe", smallText: "Covid19 virus has affected\n international traveling regulations"),
                            OnboardingCellInfo(image: "checkList", largeText: "All the information you need", smallText: "We will help you avoid nasty\n surprises at foreign borders"),
                            OnboardingCellInfo(image: "girlList", largeText: "Enjoy your travel", smallText: "With FlySafe you can save your\n travel plans for quick access.")]
    
    let localView = UIView()
    
    let onboardingPages: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = false
        collection.allowsSelection = false
        collection.isPagingEnabled = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        button.contentMode = .left
        button.backgroundColor = .clear
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.addTarget(self, action: #selector(gotoMainVC), for: .touchUpInside)
        
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        button.contentMode = .right
        button.backgroundColor = .clear
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.addTarget(self, action: #selector(gotoNextItem), for: .touchUpInside)
        
        return button
    }()
    
    
    @objc func gotoMainVC() {
        didFinishOnboarding?()
    }
    
    
    @objc func gotoNextItem() {
        if counter < animationArray.count-1 {
                counter += 1
                let newIndexPath = IndexPath(row: counter, section: 0)
                onboardingPages.scrollToItem(at: newIndexPath, at: .centeredHorizontally, animated: true)
            } else {
                gotoMainVC()
            }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view = localView
        view.backgroundColor = .white
        
        onboardingPages.dataSource = self
        onboardingPages.delegate = self
        
        view.addSubview(onboardingPages)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        onboardingPages.register(OnboardingCVCell.self, forCellWithReuseIdentifier: "OnboardingCVCell")
        
        onboardingPages.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        onboardingPages.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        onboardingPages.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        onboardingPages.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*3/4 + 50).isActive = true
        
        skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.gap*2).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.gap*2).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    
}



extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: onboardingPages.frame.width, height: onboardingPages.frame.height)
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animationArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCVCell", for: indexPath) as! OnboardingCVCell
        cell.makeCell(info: animationArray[indexPath.row])
        return cell
    }
    
}

struct OnboardingCellInfo {
    var image: String
    var largeText: String
    var smallText: String
}
