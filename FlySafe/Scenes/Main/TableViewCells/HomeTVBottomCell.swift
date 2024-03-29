//
//  HomeTVBottomCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import UIKit

class HomeTVBottomCell: UITableViewCell {
    
    var curvePath: UIBezierPath?
    var restrictionsDidGetPressed: ((TravelPlan?) -> (Void))?
    var editPressed: ((TravelPlan) -> (Void))?
    var deletePressed: ((String) -> (Void))?
    
    var travelPlan: TravelPlan? {
        didSet {
            blurView.isHidden = true
            guard let plan = travelPlan else {return}
            sourceLabel.text = plan.source
            destinationLabel.text = plan.destination
            expandButton.isHidden = true
            restrictionsButton.isHidden = false
            
            let connections = plan.transfer.split(separator: ",")
            
            let stopsCount = connections.count
            
            if stopsCount == 0 {
                connectionCount.text = "No Transfers"
                connectionMap.text = "♥ FlySafe ♥"
                restrictionsButton.isHidden = false
            } else {
                
                connectionCount.text = "\(stopsCount) \(stopsCount == 1 ? "Stop" : "Stops")"
                
                connections.forEach({
                    connectionMap.text! += " -> \($0)"
                })
                connectionMap.text! += " ->   "
            }
            if let path = curvePath {
                addConnectionDots(stopCount: Double(stopsCount), path: path, view: viewForLines)
            }
            flightDate.text = plan.date
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view != self.blurView {
            hideBlurView()
        }
    }
    
    let viewForLines: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let summaryContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
        restrictionsDidGetPressed?(travelPlan)
    }
    
    let flightDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func drawDottedCurve(start p0: CGPoint, middle p1: CGPoint, end p2: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = view.bounds
        let path = UIBezierPath()
        path.move(to: p0)
        path.addQuadCurve(to: p2, controlPoint: p1)
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
    
    let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.layer.opacity = 0.98
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = Constants.cornerRadius - 1
        blurView.clipsToBounds = true
        return blurView
    }()
    
    
    let editButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let centerImage = UIImage(systemName: "pencil.circle.fill")?.withTintColor(UIColor(hex: "10A5F9"), renderingMode: .alwaysOriginal)
        button.setImage(centerImage, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.configuration?.contentInsets = .zero
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func editTapped() {
        if let travelPlan = travelPlan {
            editPressed?(travelPlan)
            hideBlurView()
        }
    }
    
    let editLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Edit Plan"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let centerImage = UIImage(systemName: "x.circle.fill")?.withTintColor(UIColor(hex: "EF5D66"), renderingMode: .alwaysOriginal)
        button.setImage(centerImage, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.configuration?.contentInsets = .zero
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteTapped() {
        if let travelPlan = travelPlan {
            if let id = travelPlan.id {
                deletePressed?(id)
                hideBlurView()
            }
        }
    }
    
    
    let deleteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Delete Plan"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    
    private func setupLongGestureRecognizerOnCollection(on view: UIView) {
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        view.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            blurView.layer.opacity = 0
            blurView.isHidden = false
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.blurView.layer.opacity = 0.98
            })
        }
    }
    
    func hideBlurView() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.blurView.layer.opacity = 0.0
        })
        let seconds = 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.blurView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        sourceLabel.text = ""
        connectionMap.text = ""
        destinationLabel.text = ""
        flightDate.text = ""
        viewForLines.layer.sublayers?.removeAll()
    }
    
    func allignSubviews() {
        
        //Add subviews
        self.contentView.addSubview(mainContainer)
        mainContainer.addSubview(summaryContainer)
        summaryContainer.addSubview(viewForLines)
        summaryContainer.addSubview(planeImage)
        summaryContainer.addSubview(sourceLabel)
        summaryContainer.addSubview(destinationLabel)
        summaryContainer.addSubview(connectionMap)
        summaryContainer.addSubview(connectionCount)
        summaryContainer.addSubview(flightDate)
        summaryContainer.addSubview(expandButton)
        summaryContainer.addSubview(restrictionsButton)
        mainContainer.addSubview(blurView)
        blurView.contentView.addSubview(editButton)
        blurView.contentView.addSubview(editLabel)
        blurView.contentView.addSubview(deleteButton)
        blurView.contentView.addSubview(deleteLabel)
        
        setupLongGestureRecognizerOnCollection(on: summaryContainer)
        
        mainContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        mainContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        mainContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        mainContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        summaryContainer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        let containerHeightConstraint = summaryContainer.heightAnchor.constraint(equalToConstant: 170)
        containerHeightConstraint.priority = UILayoutPriority(999)
        containerHeightConstraint.isActive = true
        summaryContainer.leadingAnchor.constraint(equalTo:  mainContainer.leadingAnchor, constant: Constants.gap).isActive = true
        summaryContainer.trailingAnchor.constraint(equalTo:  mainContainer.trailingAnchor, constant: -Constants.gap).isActive = true
        summaryContainer.bottomAnchor.constraint(equalTo:  mainContainer.bottomAnchor).isActive = true
        
        viewForLines.topAnchor.constraint(equalTo: summaryContainer.topAnchor).isActive = true
        viewForLines.bottomAnchor.constraint(equalTo: summaryContainer.bottomAnchor).isActive = true
        viewForLines.leadingAnchor.constraint(equalTo: summaryContainer.leadingAnchor).isActive = true
        viewForLines.trailingAnchor.constraint(equalTo: summaryContainer.trailingAnchor).isActive = true
        
        blurView.topAnchor.constraint(equalTo: summaryContainer.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: summaryContainer.bottomAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: summaryContainer.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: summaryContainer.trailingAnchor).isActive = true
        
        deleteButton.centerYAnchor.constraint(equalTo: blurView.centerYAnchor, constant: -10).isActive = true
        deleteButton.centerXAnchor.constraint(equalTo: blurView.centerXAnchor, constant: 70).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        deleteButton.layer.cornerRadius = 35
        
        deleteLabel.centerXAnchor.constraint(equalTo: deleteButton.centerXAnchor).isActive = true
        deleteLabel.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 10).isActive = true
        
        editButton.centerYAnchor.constraint(equalTo: deleteButton.centerYAnchor).isActive = true
        editButton.centerXAnchor.constraint(equalTo: blurView.centerXAnchor, constant: -70).isActive = true
        editButton.heightAnchor.constraint(equalTo: deleteButton.heightAnchor).isActive = true
        editButton.widthAnchor.constraint(equalTo: deleteButton.widthAnchor).isActive = true
        editButton.layer.cornerRadius = deleteButton.layer.cornerRadius
        
        editLabel.centerXAnchor.constraint(equalTo: editButton.centerXAnchor).isActive = true
        editLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 10).isActive = true
        
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
        
        drawDottedLine(start: CGPoint(x: 0, y:  130), end: CGPoint(x: UIScreen.main.bounds.width - Constants.gap*2, y: 130), view: viewForLines)
        
        expandButton.centerXAnchor.constraint(equalTo: summaryContainer.centerXAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalToConstant: 15).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        expandButton.centerYAnchor.constraint(equalTo: flightDate.centerYAnchor).isActive = true
        
        restrictionsButton.centerXAnchor.constraint(equalTo: summaryContainer.centerXAnchor).isActive = true
        restrictionsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        restrictionsButton.widthAnchor.constraint(equalToConstant: 110).isActive = true
        restrictionsButton.centerYAnchor.constraint(equalTo: flightDate.centerYAnchor).isActive = true
        restrictionsButton.layer.cornerRadius = 25/2
        
        flightDate.bottomAnchor.constraint(equalTo: summaryContainer.bottomAnchor, constant: -11).isActive = true
        flightDate.leadingAnchor.constraint(equalTo: sourceLabel.leadingAnchor).isActive = true
        flightDate.heightAnchor.constraint(equalToConstant: 20).isActive = true
        flightDate.trailingAnchor.constraint(equalTo: restrictionsButton.leadingAnchor, constant: -10).isActive = true
        
        drawDottedCurve(start: CGPoint(x: UIScreen.main.bounds.minX + 30, y: 80), middle: CGPoint(x: UIScreen.main.bounds.midX - 30, y: 5), end: CGPoint(x: UIScreen.main.bounds.maxX - (Constants.gap*2) - 30, y: 80), view: viewForLines)
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
