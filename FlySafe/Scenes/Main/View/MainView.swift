//
//  MainView.swift
//  FlySafe
//
//  Created by Nika Topuria on 29.12.21.
//

import UIKit

class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func createSubviews() {
        // all the layout code from above
        self.translatesAutoresizingMaskIntoConstraints = false
        
        //Set background color
        self.backgroundColor = .white
        
        //Side menu button
        let menuButton = UIButton()
        menuButton.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        menuButton.contentHorizontalAlignment = .fill
        menuButton.contentVerticalAlignment = .fill
        menuButton.tintColor = .black
        menuButton.frame = CGRect(x: UIScreen.main.bounds.width - 45, y: 50, width: 25, height: 20)
        
        
        //Greeting label
        let greetingLabel = UILabel()
        greetingLabel.sizeToFit()
        greetingLabel.frame = CGRect(x: Constants.gap, y: menuButton.frame.maxY + 5, width: UIScreen.main.bounds.width-(Constants.gap*2), height: 30)
        greetingLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        greetingLabel.textColor = .black
        greetingLabel.numberOfLines = 1
        greetingLabel.textAlignment = .left
        greetingLabel.text = "Hello "
        
        
        //Add new flight title
        let newFlightLabel  = UILabel()
        newFlightLabel.text = "Add new flight"
        newFlightLabel.font = .systemFont(ofSize: 18, weight: .bold)
        newFlightLabel.sizeToFit()
        newFlightLabel.frame = CGRect(x: Constants.gap, y: greetingLabel.frame.maxY + 40, width: newFlightLabel.intrinsicContentSize.width + 5, height: 25)
        
        
        //Add container view for airport selectors
        let containerView = UIView()
        containerView.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.frame = CGRect(x: Constants.gap, y: newFlightLabel.frame.maxY + 13, width: greetingLabel.frame.width, height: 180)
        
        
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
        pickerContainer.layer.cornerRadius = Constants.cornerRadius
        pickerContainer.frame = CGRect(x: containerView.frame.minX, y: containerView.frame.maxY + 20, width: containerView.frame.width, height: 60)
        
        
        //imageView for date picker view
        let imgDatePicker = UIImageView()
        imgDatePicker.image = UIImage(named: "ic_calendar")
        imgDatePicker.frame = CGRect(x: pickerContainer.bounds.minX + 16, y: pickerContainer.bounds.minY + 16, width: 28, height: 28)
        imgDatePicker.contentMode = .scaleAspectFit
        
        
        //Date picker view
        let datePicker = UIDatePicker()
//        datePicker.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
//        datePicker.timeZone = NSTimeZone.local
//        datePicker.contentMode = .scaleAspectFit
//        datePicker.backgroundColor = .white
//        datePicker.datePickerMode = .date
//        datePicker.preferredDatePickerStyle = .inline
        datePicker.frame = CGRect(x: imgDatePicker.frame.maxX + 16, y: imgDatePicker.frame.minY, width: sourceAirport.frame.width, height: sourceAirport.frame.height)
        
        
        
        
        //Add subviews
        self.addSubview(menuButton)
        self.addSubview(greetingLabel)
        self.addSubview(newFlightLabel)
        self.addSubview(containerView)
        self.addSubview(pickerContainer)
        containerView.addSubview(dividerLines)
        containerView.addSubview(imgTakeOff)
        containerView.addSubview(sourceAirport)
        containerView.addSubview(imgTransfer)
        containerView.addSubview(transferAirport)
        containerView.addSubview(imgDestination)
        containerView.addSubview(destinationAirport)
        pickerContainer.addSubview(imgDatePicker)
       // pickerContainer.addSubview(datePicker)
    }
    
    
    func tripSummaryView(source: String, connections: [String]?, destination: String) {
        let summaryContainer = UIView()
        summaryContainer.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
        summaryContainer.layer.cornerRadius = Constants.cornerRadius
        summaryContainer.frame = CGRect(x: Constants.gap, y: super.containerView?.frame.maxY + 20, width: super.containerView?.frame.width, height: 60)
        
    }
    
}
