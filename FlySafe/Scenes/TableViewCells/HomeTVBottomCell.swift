//
//  HomeTVBottomCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import UIKit

class HomeTVBottomCell: UITableViewCell {
    
    var tripPlan: TripPlan? {
        didSet {
            guard let plan = tripPlan else {return}
            sourceLabel.text = plan.source
            destinationLabel.text = plan.destination
            let stopsCount = plan.date.count
            if stopsCount == 0 {
                connectionCount.text = "Direct Flight"
            } else if stopsCount == 1 {
                connectionCount.text = "1 Stop"
            } else {
                connectionCount.text = "\(stopsCount) Stops"
            }
            flightDate.text = plan.date
        }
    }
    
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
    
    //Create label for source
    let sourceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    
    //Create label for destination
    let destinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .right
        return label
    }()
    
    let planeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_plane")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let connectionCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView){
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.gray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3]

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    let expandButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic_more"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = UIColor(hex: "10A5F9")
        return button
    }()
    
    let flightDate: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    func drawDottedCurve(start p0: CGPoint, middle p1: CGPoint, end p2: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: p0)
        path.addQuadCurve(to: p2, controlPoint: p1)
        path.stroke()

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineDashPattern = [7, 3]
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        view.layer.addSublayer(shapeLayer)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.contentView.addSubview(summaryViewTitle)
        self.contentView.addSubview(summaryContainer)
        summaryContainer.addSubview(planeImage)
        summaryContainer.addSubview(sourceLabel)
        summaryContainer.addSubview(destinationLabel)
        summaryContainer.addSubview(connectionCount)
        summaryContainer.addSubview(flightDate)
        summaryContainer.addSubview(expandButton)
        
        summaryViewTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        summaryViewTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        summaryViewTitle.widthAnchor.constraint(equalToConstant: summaryViewTitle.intrinsicContentSize.width+5).isActive = true
        summaryViewTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        summaryContainer.topAnchor.constraint(equalTo: summaryViewTitle.bottomAnchor, constant: 13).isActive = true
        summaryContainer.heightAnchor.constraint(equalToConstant: 170).isActive = true
        summaryContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        summaryContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.gap).isActive = true
        summaryContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        planeImage.centerYAnchor.constraint(equalTo: summaryContainer.centerYAnchor).isActive = true
        planeImage.centerXAnchor.constraint(equalTo: summaryContainer.centerXAnchor).isActive = true
        planeImage.heightAnchor.constraint(equalToConstant: 23).isActive = true
        planeImage.widthAnchor.constraint(equalToConstant: 36).isActive = true
        
        sourceLabel.centerYAnchor.constraint(equalTo: planeImage.bottomAnchor).isActive = true
        sourceLabel.leadingAnchor.constraint(equalTo: summaryContainer.leadingAnchor, constant: 15).isActive = true
        sourceLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sourceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        destinationLabel.topAnchor.constraint(equalTo: sourceLabel.topAnchor).isActive = true
        destinationLabel.trailingAnchor.constraint(equalTo: summaryContainer.trailingAnchor, constant: -15).isActive = true
        destinationLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        destinationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        connectionCount.centerXAnchor.constraint(equalTo: planeImage.centerXAnchor).isActive = true
        connectionCount.topAnchor.constraint(equalTo: planeImage.bottomAnchor).isActive = true
        connectionCount.heightAnchor.constraint(equalToConstant: 30).isActive = true
        connectionCount.widthAnchor.constraint(equalToConstant: 70).isActive = true
        drawDottedLine(start: CGPoint(x: 0, y:  130), end: CGPoint(x: UIScreen.main.bounds.width - Constants.gap*2, y: 130), view: summaryContainer)
        
        flightDate.bottomAnchor.constraint(equalTo: summaryContainer.bottomAnchor, constant: -12).isActive = true
        flightDate.leadingAnchor.constraint(equalTo: sourceLabel.leadingAnchor).isActive = true
        flightDate.heightAnchor.constraint(equalToConstant: 20).isActive = true
        flightDate.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        expandButton.centerXAnchor.constraint(equalTo: summaryContainer.centerXAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        expandButton.centerYAnchor.constraint(equalTo: flightDate.centerYAnchor).isActive = true
        
        print (self.contentView.bounds.maxX)
        drawDottedCurve(start: CGPoint(x: UIScreen.main.bounds.minX + 30, y: 80), middle: CGPoint(x: UIScreen.main.bounds.midX - 30, y: -5), end: CGPoint(x: UIScreen.main.bounds.maxX - (Constants.gap*2) - 30, y: 80), view: summaryContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
