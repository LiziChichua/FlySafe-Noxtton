//
//  TableViewCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import UIKit

class HomeTVTopCell: UITableViewCell {


        //Add new flight title
        let newFlightLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Add new flight"
            label.font = .systemFont(ofSize: 18, weight: .bold)
            label.sizeToFit()
            return label
        }()
        
        
        //Add container view for airport selectors
        let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
            view.layer.cornerRadius = Constants.cornerRadius
            return view
        }()
        
        
        //Divider lines for container view
        let dividerLines: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
            return view
        }()
        
        /////MARK: - Source airport field
        
        //imageView for source airport field
        let imgTakeOff: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "ic_takeoff")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        //Source flight selector
        let sourceAirport: DropDown = {
            let dropDown = DropDown()
            dropDown.translatesAutoresizingMaskIntoConstraints = false
            dropDown.placeholder = "Departure Airport"
            dropDown.optionArray = ["Bilbao, Es, BIO", "Madrid, Es, SAN", "Las-Vegas, US, LAS"]
            return dropDown
        }()
        
        /////MARK: - Transfer airport field
        
        //imageView for transfer airport field
        let imgTransfer: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "ic_flight")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        
        //Transfer flight selector
        let transferAirport: DropDown = {
            let dropDown = DropDown()
            dropDown.translatesAutoresizingMaskIntoConstraints = false
            dropDown.placeholder = "Transfer Airport (optional)"
            dropDown.optionArray = ["Bilbao, Es, BIO", "Madrid, Es, SAN", "Las-Vegas, US, LAS"]
            return dropDown
        }()
        
        /////MARK: - Destination airport field
        
        //imageView for destination airport field
        let imgDestination: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "ic_landing")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        
        //Transfer flight selector
        let destinationAirport: DropDown = {
            let dropDown = DropDown()
            dropDown.translatesAutoresizingMaskIntoConstraints = false
            dropDown.placeholder = "Destination Airport"
            dropDown.optionArray = ["Bilbao, Es, BIO", "Madrid, Es, SAN", "Las-Vegas, US, LAS"]
            return dropDown
        }()
        
        
        /////MARK: - Date picker view
        
        //Frame for date picker view
        let pickerContainer: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
            view.contentMode = .center
            view.layer.cornerRadius = Constants.cornerRadius
            return view
        }()
        
        
        //imageView for date picker view
        let imgDatePicker: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "ic_calendar")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        
        //Date picker view
        let datePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.translatesAutoresizingMaskIntoConstraints = false
            picker.timeZone = NSTimeZone.local
            picker.contentHorizontalAlignment = .center
            picker.datePickerMode = .date
            picker.frame.size.width = 150
            picker.preferredDatePickerStyle = .compact
            return picker
        }()
        
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.contentView.addSubview(newFlightLabel)
        containerView.addSubview(dividerLines)
        containerView.addSubview(imgTakeOff)
        containerView.addSubview(sourceAirport)
        containerView.addSubview(imgTransfer)
        containerView.addSubview(transferAirport)
        containerView.addSubview(imgDestination)
        containerView.addSubview(destinationAirport)
        self.contentView.addSubview(containerView)
        pickerContainer.addSubview(imgDatePicker)
        pickerContainer.addSubview(datePicker)
        self.contentView.addSubview(pickerContainer)
        
        
        newFlightLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        newFlightLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        newFlightLabel.widthAnchor.constraint(equalToConstant: newFlightLabel.intrinsicContentSize.width+5).isActive = true
        newFlightLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        containerView.topAnchor.constraint(equalTo: newFlightLabel.bottomAnchor, constant: 13).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.gap).isActive = true
        
        dividerLines.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 60).isActive = true
        dividerLines.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dividerLines.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        dividerLines.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        imgTakeOff.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        imgTakeOff.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        imgTakeOff.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imgTakeOff.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        imgTransfer.topAnchor.constraint(equalTo: dividerLines.topAnchor, constant: 16).isActive = true
        imgTransfer.leadingAnchor.constraint(equalTo: imgTakeOff.leadingAnchor).isActive = true
        imgTransfer.widthAnchor.constraint(equalTo: imgTakeOff.widthAnchor).isActive = true
        imgTransfer.heightAnchor.constraint(equalTo: imgTakeOff.heightAnchor).isActive = true
        
        imgDestination.topAnchor.constraint(equalTo: dividerLines.bottomAnchor, constant: 16).isActive = true
        imgDestination.leadingAnchor.constraint(equalTo: imgTakeOff.leadingAnchor).isActive = true
        imgDestination.widthAnchor.constraint(equalTo: imgTakeOff.widthAnchor).isActive = true
        imgDestination.heightAnchor.constraint(equalTo: imgTakeOff.heightAnchor).isActive = true
        
        sourceAirport.leadingAnchor.constraint(equalTo: imgTakeOff.trailingAnchor, constant: 16).isActive = true
        sourceAirport.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        sourceAirport.centerYAnchor.constraint(equalTo: imgTakeOff.centerYAnchor).isActive = true
        
        transferAirport.leadingAnchor.constraint(equalTo: imgTransfer.trailingAnchor, constant: 16).isActive = true
        transferAirport.trailingAnchor.constraint(equalTo: sourceAirport.trailingAnchor).isActive = true
        transferAirport.centerYAnchor.constraint(equalTo: imgTransfer.centerYAnchor).isActive = true
        
        destinationAirport.leadingAnchor.constraint(equalTo: imgDestination.trailingAnchor, constant: 16).isActive = true
        destinationAirport.trailingAnchor.constraint(equalTo: sourceAirport.trailingAnchor).isActive = true
        destinationAirport.centerYAnchor.constraint(equalTo: imgDestination.centerYAnchor).isActive = true
        
        pickerContainer.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20).isActive = true
        pickerContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        pickerContainer.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        pickerContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        pickerContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        imgDatePicker.topAnchor.constraint(equalTo: pickerContainer.topAnchor, constant: 16).isActive = true
        imgDatePicker.leadingAnchor.constraint(equalTo: pickerContainer.leadingAnchor, constant: 16).isActive = true
        imgDatePicker.widthAnchor.constraint(equalToConstant: 28).isActive = true
        imgDatePicker.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        datePicker.leadingAnchor.constraint(equalTo: imgDatePicker.trailingAnchor, constant: 16).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor, constant: -16-28).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: imgDatePicker.centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
