//
//  TableViewCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import UIKit

class HomeTVTopCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubviews()
     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func createSubviews() {
        
        //Add new flight title
        let newFlightLabel: UILabel = {
            let label = UILabel()
        label.text = "Add new flight"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.sizeToFit()
        label.frame = CGRect(x: Constants.gap, y: self.bounds.minY + 30, width: label.intrinsicContentSize.width + 5, height: 25)
            return label
        }()
        
        
        //Add container view for airport selectors
//        let containerView = UIView()
//        containerView.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
//        containerView.layer.cornerRadius = Constants.cornerRadius
//        containerView.frame = CGRect(x: Constants.gap, y: newFlightLabel.frame.maxY + 13, width: UIScreen.main.bounds.width - (Constants.gap*2), height: 180)
////        containerView.topAnchor.constraint(equalTo: newFlightLabel.bottomAnchor, constant: 13).isActive = true
////        containerView.heightAnchor.constraint(equalToConstant: 180).isActive = true
////        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.gap).isActive = true
////        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.gap).isActive = true
        
        let containerView: UIView = {
            let view = UIView()
            view.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
            view.layer.cornerRadius = Constants.cornerRadius
            view.topAnchor.constraint(equalTo: newFlightLabel.bottomAnchor, constant: 13).isActive = true
            view.heightAnchor.constraint(equalToConstant: 180).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.gap).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Constants.gap).isActive = true
            return view
        }()
        
        
        
        //Divider lines for container view
        let dividerLines = UIView()
        dividerLines.frame = CGRect(x: containerView.bounds.minX, y: containerView.bounds.minY+60, width: containerView.frame.width, height: 60)
        dividerLines.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
        
        /////MARK: - Source airport field
        
        //imageView for source airport field
        let imgTakeOff = UIImageView()
        imgTakeOff.image = UIImage(named: "ic_takeoff")
        imgTakeOff.frame = CGRect(x: containerView.bounds.minX + 16, y: containerView.bounds.minY + 16, width: 28, height: 28)
        imgTakeOff.contentMode = .scaleAspectFit
        
        //Source flight selector
        let sourceAirport = DropDown()
        sourceAirport.frame = CGRect(x: imgTakeOff.frame.maxX + 16, y: containerView.bounds.minY + 16, width: containerView.bounds.maxX - 80, height: 28)
        sourceAirport.placeholder = "Departure Airport"
        sourceAirport.optionArray = ["Bilbao, Es, BIO", "Madrid, Es, SAN", "Las-Vegas, US, LAS"]
        
        /////MARK: - Transfer airport field
        
        //imageView for transfer airport field
        let imgTransfer = UIImageView()
        imgTransfer.image = UIImage(named: "ic_flight")
        imgTransfer.frame = CGRect(x: containerView.bounds.minX + 16, y: dividerLines.frame.minY + 16, width: imgTakeOff.frame.width, height: imgTakeOff.frame.height)
        imgTransfer.contentMode = .scaleAspectFit
        
        
        //Transfer flight selector
        let transferAirport = DropDown()
        transferAirport.frame = CGRect(x: imgTransfer.frame.maxX + 16, y: imgTransfer.frame.minY, width: sourceAirport.frame.width, height: sourceAirport.frame.height)
        transferAirport.placeholder = "Transfer Airport (optional)"
        transferAirport.optionArray = ["Bilbao, Es, BIO", "Madrid, Es, SAN", "Las-Vegas, US, LAS"]
        
        /////MARK: - Destination airport field
        
        //imageView for destination airport field
        let imgDestination = UIImageView()
        imgDestination.image = UIImage(named: "ic_landing")
        imgDestination.frame = CGRect(x: containerView.bounds.minX + 16, y: dividerLines.frame.maxY + 16, width: imgTakeOff.frame.width, height: imgTakeOff.frame.height)
        imgDestination.contentMode = .scaleAspectFit
        
        
        //Transfer flight selector
        let destinationAirport = DropDown()
        destinationAirport.frame = CGRect(x: imgDestination.frame.maxX + 16, y: imgDestination.frame.minY, width: sourceAirport.frame.width, height: sourceAirport.frame.height)
        destinationAirport.placeholder = "Destination Airport"
        destinationAirport.optionArray = ["Bilbao, Es, BIO", "Madrid, Es, SAN", "Las-Vegas, US, LAS"]
        
        
        /////MARK: - Date picker view
        
        //Frame for date picker view
        let pickerContainer = UIView()
        pickerContainer.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
        pickerContainer.contentMode = .center
        pickerContainer.layer.cornerRadius = Constants.cornerRadius
        pickerContainer.frame = CGRect(x: containerView.frame.minX, y: containerView.frame.maxY + 20, width: containerView.frame.width, height: 60)
        
        
        //imageView for date picker view
        let imgDatePicker = UIImageView()
        imgDatePicker.image = UIImage(named: "ic_calendar")
        imgDatePicker.frame = CGRect(x: pickerContainer.bounds.minX + 16, y: pickerContainer.bounds.minY + 16, width: 28, height: 28)
        imgDatePicker.contentMode = .scaleAspectFit
        
        
        //Date picker view
        let datePicker = UIDatePicker()
        datePicker.timeZone = NSTimeZone.local
        datePicker.contentHorizontalAlignment = .center
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.frame = CGRect(x: imgDatePicker.frame.maxX + 16, y: imgDatePicker.frame.minY, width: pickerContainer.bounds.width - 28 - 32-20, height: sourceAirport.frame.height)
  //      datePicker.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        
        //Add subviews
        self.contentView.addSubview(newFlightLabel)
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(pickerContainer)
        containerView.addSubview(dividerLines)
        containerView.addSubview(imgTakeOff)
        containerView.addSubview(sourceAirport)
        containerView.addSubview(imgTransfer)
        containerView.addSubview(transferAirport)
        containerView.addSubview(imgDestination)
        containerView.addSubview(destinationAirport)
        pickerContainer.addSubview(imgDatePicker)
        pickerContainer.addSubview(datePicker)
        
    }

}
