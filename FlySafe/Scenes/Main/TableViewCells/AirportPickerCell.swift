//
//  AirportPickerCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 18.01.22.
//

import UIKit

class AirportPickerCell: UITableViewCell {
    
    var didSelectAirport: ((FlightTypes, String) -> (Void))?
    
    var airportsList: [String]? {
        didSet {
            if let airportsList = airportsList {
                airportPicker.optionArray = airportsList
            }
        }
    }
    
    var flightType: FlightTypes?
    
    
    //Plane icon
    let planeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_takeoff")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //Source flight selector
    let airportPicker: DropDown = {
        let dropDown = DropDown()
        dropDown.checkMarkEnabled = false
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.optionArray = ["No Data"]
        return dropDown
    }()
    
    //Divider line
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
        return view
    }()
    
    
    func makeCell(with flightInfo: (FlightTypes, String)) {
        planeImage.image = UIImage(named: flightInfo.0.rawValue)
        flightType = flightInfo.0
        airportPicker.text = flightInfo.1
        switch flightInfo.0 {
            case .source:
                airportPicker.placeholder = "Departure Airport"
            case .destination:
                airportPicker.placeholder = "Destination Airport"
            case .transfer:
                airportPicker.placeholder = "Transfer Airport (optional)"
            }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(planeImage)
        self.contentView.addSubview(airportPicker)
        self.contentView.addSubview(dividerLine)
        
        
        planeImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        planeImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16).isActive = true
        planeImage.widthAnchor.constraint(equalToConstant: 28).isActive = true
        let imgHeightConstraint = planeImage.heightAnchor.constraint(equalToConstant: 28)
        imgHeightConstraint.priority = UILayoutPriority(999)
        imgHeightConstraint.isActive = true
        
        airportPicker.leadingAnchor.constraint(equalTo: planeImage.trailingAnchor, constant: 12).isActive = true
        airportPicker.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        airportPicker.centerYAnchor.constraint(equalTo: planeImage.centerYAnchor).isActive = true
        airportPicker.heightAnchor.constraint(equalTo: planeImage.heightAnchor).isActive = true
        
        dividerLine.topAnchor.constraint(equalTo: planeImage.bottomAnchor, constant: 14.5).isActive = true
        dividerLine.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        dividerLine.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        dividerLine.heightAnchor.constraint(equalToConstant: Constants.borderWidth).isActive = true
        dividerLine.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        airportPicker.didSelect { [weak self] selectedText, index, id in
            if let flightType = self?.flightType {
                self?.didSelectAirport?(flightType, selectedText)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
