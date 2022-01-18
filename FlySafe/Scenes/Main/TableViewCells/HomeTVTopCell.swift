//
//  TableViewCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import UIKit

class HomeTVTopCell: UITableViewCell {
    
    var delegate: FlightInfoFieldsDelegate?
    
    var selectorStructure: [(FlightTypes, String)] = [(.source, ""), (.transfer, ""), (.destination, "")]
    
    var flightPlan: TravelPlan? {
        didSet {
            if let flightPlan = flightPlan {

                //
                //                //Full strings of selected airports
                //                sourceAirport.text = airportsList?.filter({
                //                    $0.contains("\(flightPlan.source)")
                //                }).first
                //
                //                if flightPlan.transfer.split(separator: ",").count == 1 {
                //                    transferAirport.text = airportsList?.filter({
                //                        $0.contains("\(flightPlan.transfer)")
                //                    }).first
                //                }
                //
                //                destinationAirport.text = airportsList?.filter({
                //                    $0.contains("\(flightPlan.destination)")
                //                }).first
                
                let parseStrategy =
                Date.ParseStrategy(
                    format: "\(day: .twoDigits)/\(month: .twoDigits)/\(year: .defaultDigits)",
                    locale: Locale.current,
                    timeZone: .current
                )
                if let date = try? Date(flightPlan.date, strategy: parseStrategy) {
                    datePicker.setDate(date, animated: true)
                }
            }
        }
    }
    
    var airportsList: [String]? {
        didSet {
            airportPickersTableView.reloadData()
        }
    }
    
    //Add new flight title
    let newFlightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add new flight"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.sizeToFit()
        return label
    }()
    
    
    /////MARK: - Airport picker tableview
    
    let airportPickersTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isUserInteractionEnabled = true
        table.backgroundColor = .clear
        table.separatorColor = .clear
        table.viewBorder(borderColor: .black, borderWidth: Constants.borderWidth)
        table.layer.cornerRadius = Constants.cornerRadius
        return table
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
        picker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        return picker
    }()
    
    @objc func datePicked() {
        delegate?.didSelectFlightDate(date: datePicker.date)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Add subviews
        self.contentView.addSubview(newFlightLabel)
        self.contentView.addSubview(airportPickersTableView)
        pickerContainer.addSubview(imgDatePicker)
        pickerContainer.addSubview(datePicker)
        self.contentView.addSubview(pickerContainer)
        
        airportPickersTableView.delegate = self
        airportPickersTableView.dataSource = self
        airportPickersTableView.register(AirportPickerCell.self, forCellReuseIdentifier: "AirportPickerCell")
        
        newFlightLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 25).isActive = true
        newFlightLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        newFlightLabel.widthAnchor.constraint(equalToConstant: newFlightLabel.intrinsicContentSize.width+5).isActive = true
        newFlightLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        airportPickersTableView.topAnchor.constraint(equalTo: newFlightLabel.bottomAnchor, constant: 13).isActive = true
        airportPickersTableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        airportPickersTableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.gap).isActive = true
        airportPickersTableView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        pickerContainer.topAnchor.constraint(equalTo: airportPickersTableView.bottomAnchor, constant: 20).isActive = true
        pickerContainer.leadingAnchor.constraint(equalTo: airportPickersTableView.leadingAnchor).isActive = true
        pickerContainer.trailingAnchor.constraint(equalTo: airportPickersTableView.trailingAnchor).isActive = true
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


protocol FlightInfoFieldsDelegate {
    func didSelectSource(source: String)
    func didSelectDestination(destination: String)
    func didSelectTransfer(transfer: String)
    func didSelectFlightDate(date: Date)
}

extension HomeTVTopCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectorStructure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportPickerCell", for: indexPath) as! AirportPickerCell
        
        cell.airportsList = airportsList
        cell.airportPicker.text = selectorStructure[indexPath.row].1
        cell.flightType = selectorStructure[indexPath.row].0
        
        switch selectorStructure[indexPath.row].0{
            
        case .source:
            cell.didSelectAirport = { [weak self] airport in
                self?.delegate?.didSelectSource(source: airport)
                self?.selectorStructure[indexPath.row].1 = airport
                self?.datePicked()
            }
        case .destination:
            cell.didSelectAirport = { [weak self] airport in
                self?.delegate?.didSelectDestination(destination: airport)
                if let count = self?.selectorStructure.count {
                    self?.selectorStructure[count-1].1 = airport
                }
                
            }
        case .transfer:
            cell.didSelectAirport = { [weak self] airport in
                self?.delegate?.didSelectTransfer(transfer: airport)
                self?.selectorStructure.insert((.transfer, airport), at: indexPath.row)
                tableView.performBatchUpdates({
                    tableView.insertRows(at: [IndexPath(row: indexPath.row+1, section: indexPath.section)], with: .automatic)
                }, completion: nil)
            }
        }
        return cell
    }
}
