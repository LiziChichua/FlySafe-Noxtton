//
//  HomeTVBottomCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import UIKit

class HomeTVBottomCell: UITableViewCell {
    
    var curvePath: UIBezierPath?
    var delegate: CheckRestrictionsDelegate?
    
    var travelPlan: TripPlan? {
        didSet {
            guard let plan = travelPlan else {return}
            sourceLabel.text = plan.source
            destinationLabel.text = plan.destination
            expandButton.isHidden = true
            restrictionsButton.isHidden = false
            if let connections = plan.connections {
                let stopsCount = connections.count
                if stopsCount == 0 {
                    connectionCount.text = "No Transfers"
                    connectionMap.text = "♥ FlySafe ♥"
                    //expandButton.isHidden = true
                    restrictionsButton.isHidden = false
                } else {
                    connectionCount.text = "\(stopsCount) \(stopsCount == 1 ? "Stop" : "Stops")"
                    
                    connections.forEach({
                        connectionMap.text! += " -> \($0)"
                    })
                    connectionMap.text! += " ->   "
                }
                if let path = curvePath {
                    addConnectionDots(stopCount: Double(stopsCount), path: path, view: summaryContainer)
                }
            }
            flightDate.text = plan.date
        }
    }
    
    let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
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
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    
    //Create label for destination
    let destinationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .semibold)
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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let connectionMap: MarqueeLabel = {
        let label = MarqueeLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = ""
        label.speed = .duration(12)
        label.fadeLength = 15
        label.trailingBuffer = 5
        label.animationDelay = 0
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
    
    let restrictionsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Restrictions", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = UIColor(hex: "EF5D66")
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(buttonTriger), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonTriger() {
        delegate?.checkRestrictionsPressed()
    }
    
    let flightDate: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    func drawDottedCurve(start p0: CGPoint, middle p1: CGPoint, end p2: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: p0)
        path.addQuadCurve(to: p2, controlPoint: p1)
        path.stroke()
        curvePath = path

        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineDashPattern = [7, 3]
        shapeLayer.strokeColor = UIColor.black.cgColor
        
        view.layer.addSublayer(shapeLayer)
    }
    
    func addConnectionDots(stopCount: Double, path: UIBezierPath, view: UIView) {
        if stopCount > 0 {
            let points: [CGPoint] = (1...Int(stopCount)).map({
                path.mx_point(atFractionOfLength: CGFloat(Double($0)/(stopCount+1)))
            })
            points.forEach { point in
                let layer = CALayer()
                layer.frame = CGRect(x: point.x - 10, y: point.y - 10, width: 20, height: 20)
                layer.contents = UIImage(named: "ic_connection")?.cgImage
                layer.contentsGravity = .resizeAspect
                view.layer.addSublayer(layer)
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.contentView.addSubview(mainContainer)
        self.contentView.addSubview(summaryContainer)
        summaryContainer.addSubview(planeImage)
        summaryContainer.addSubview(sourceLabel)
        summaryContainer.addSubview(destinationLabel)
        summaryContainer.addSubview(connectionMap)
        summaryContainer.addSubview(connectionCount)
        summaryContainer.addSubview(flightDate)
        summaryContainer.addSubview(expandButton)
        summaryContainer.addSubview(restrictionsButton)
        
        mainContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        mainContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        summaryContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        summaryContainer.heightAnchor.constraint(equalToConstant: 170).isActive = true
        summaryContainer.leadingAnchor.constraint(equalTo:  mainContainer.leadingAnchor, constant: Constants.gap).isActive = true
        summaryContainer.trailingAnchor.constraint(equalTo:  mainContainer.trailingAnchor, constant: -Constants.gap).isActive = true
        summaryContainer.bottomAnchor.constraint(equalTo:  mainContainer.bottomAnchor).isActive = true
        
        planeImage.centerYAnchor.constraint(equalTo: summaryContainer.centerYAnchor, constant: -5).isActive = true
        planeImage.centerXAnchor.constraint(equalTo: summaryContainer.centerXAnchor).isActive = true
        planeImage.heightAnchor.constraint(equalToConstant: 27).isActive = true
        planeImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        sourceLabel.centerYAnchor.constraint(equalTo: planeImage.bottomAnchor, constant: 5).isActive = true
        sourceLabel.leadingAnchor.constraint(equalTo: summaryContainer.leadingAnchor, constant: 15).isActive = true
        sourceLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        sourceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        destinationLabel.topAnchor.constraint(equalTo: sourceLabel.topAnchor).isActive = true
        destinationLabel.trailingAnchor.constraint(equalTo: summaryContainer.trailingAnchor, constant: -15).isActive = true
        destinationLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        destinationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        connectionCount.topAnchor.constraint(equalTo: summaryContainer.topAnchor, constant: 4).isActive = true
        connectionCount.leadingAnchor.constraint(equalTo: sourceLabel.centerXAnchor).isActive = true
        connectionCount.trailingAnchor.constraint(equalTo: destinationLabel.centerXAnchor).isActive = true
        connectionCount.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        connectionMap.topAnchor.constraint(equalTo: planeImage.bottomAnchor, constant: 5).isActive = true
        connectionMap.leadingAnchor.constraint(equalTo: sourceLabel.trailingAnchor, constant: 10).isActive = true
        connectionMap.trailingAnchor.constraint(equalTo: destinationLabel.leadingAnchor, constant: -10).isActive = true
        connectionMap.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        drawDottedLine(start: CGPoint(x: 0, y:  130), end: CGPoint(x: UIScreen.main.bounds.width - Constants.gap*2, y: 130), view: summaryContainer)
        
        flightDate.bottomAnchor.constraint(equalTo: summaryContainer.bottomAnchor, constant: -11).isActive = true
        flightDate.leadingAnchor.constraint(equalTo: sourceLabel.leadingAnchor).isActive = true
        flightDate.heightAnchor.constraint(equalToConstant: 20).isActive = true
        flightDate.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        expandButton.centerXAnchor.constraint(equalTo: summaryContainer.centerXAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        expandButton.centerYAnchor.constraint(equalTo: flightDate.centerYAnchor).isActive = true
        
        restrictionsButton.centerXAnchor.constraint(equalTo: summaryContainer.centerXAnchor).isActive = true
        restrictionsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        restrictionsButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        restrictionsButton.centerYAnchor.constraint(equalTo: flightDate.centerYAnchor).isActive = true
        restrictionsButton.layer.cornerRadius = 25/2
        
        drawDottedCurve(start: CGPoint(x: UIScreen.main.bounds.minX + 30, y: 80), middle: CGPoint(x: UIScreen.main.bounds.midX - 30, y: 5), end: CGPoint(x: UIScreen.main.bounds.maxX - (Constants.gap*2) - 30, y: 80), view: summaryContainer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
