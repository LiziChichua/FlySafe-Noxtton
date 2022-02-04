//
//  TableViewCell.swift
//  FlySafe
//
//  Created by Nika Topuria on 02.01.22.
//

import UIKit

class HomeTVTopCell: UITableViewCell {
    
    weak var delegate: FlightInfoFieldsDelegate?
    
    var selectorStructure: [(FlightTypes, String)] = [(.source, ""), (.transfer, ""), (.destination, "")]
    
    var flightPlan: TravelPlan? {
        didSet {
            if let flightPlan = flightPlan {
                
                //Full strings of selected airports
                if let source = airportsList?.filter({
                    $0.contains("\(flightPlan.source)")
                }).first {
                    selectorStructure[0].1 = source
                }
                
                let splitTransfers = flightPlan.transfer.split(separator: ",")
                if splitTransfers.count > 0 {
                    selectorStructure.remove(at: 1)
                    splitTransfers.reversed().forEach({ airportName in
                        if let airport = airportsList?.filter({
                            $0.contains("\(airportName)")
                        }).first {
                            selectorStructure.insert((.transfer, airport), at: 1)
                        }
                    })
                    selectorStructure.insert((.transfer, ""), at: selectorStructure.count-1)
                }
                if let destination = airportsList?.filter({
                    $0.contains("\(flightPlan.destination)")
                }).first {
                    selectorStructure[selectorStructure.count-1].1 = destination
                }
                
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
            airportPickersTableView.reloadData()
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
        table.allowsSelection = false
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
        view.contentMode = .left
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
        picker.contentHorizontalAlignment = .leading
        picker.datePickerMode = .date
        picker.date = .now
        
        picker.frame.size.width = 150
        picker.preferredDatePickerStyle = .compact
        picker.addTarget(self, action: #selector(datePicked), for: .valueChanged)
        return picker
    }()
    
    @objc func datePicked() {
        delegate?.didMakeSelection(flightStructure: selectorStructure, date: datePicker.date)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        //Add subviews
        self.contentView.addSubview(newFlightLabel)
        self.contentView.addSubview(airportPickersTableView)
        pickerContainer.addSubview(imgDatePicker)
        pickerContainer.addSubview(datePicker)
        self.contentView.addSubview(pickerContainer)
        
        airportPickersTableView.delegate = self
        airportPickersTableView.dataSource = self
        airportPickersTableView.register(AirportPickerCell.self, forCellReuseIdentifier: "AirportPickerCell")
        
        newFlightLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        newFlightLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        newFlightLabel.widthAnchor.constraint(equalToConstant: newFlightLabel.intrinsicContentSize.width+5).isActive = true
        newFlightLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        airportPickersTableView.topAnchor.constraint(equalTo: newFlightLabel.bottomAnchor, constant: 13).isActive = true
        airportPickersTableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constants.gap).isActive = true
        airportPickersTableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constants.gap).isActive = true
        let tableHeightContraint = airportPickersTableView.heightAnchor.constraint(equalToConstant: 180)
        tableHeightContraint.priority = UILayoutPriority(999)
        tableHeightContraint.isActive = true
        
        pickerContainer.topAnchor.constraint(equalTo: airportPickersTableView.bottomAnchor, constant: 20).isActive = true
        pickerContainer.leadingAnchor.constraint(equalTo: airportPickersTableView.leadingAnchor).isActive = true
        pickerContainer.trailingAnchor.constraint(equalTo: airportPickersTableView.trailingAnchor).isActive = true
        pickerContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        pickerContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        imgDatePicker.topAnchor.constraint(equalTo: pickerContainer.topAnchor, constant: 16).isActive = true
        imgDatePicker.leadingAnchor.constraint(equalTo: pickerContainer.leadingAnchor, constant: 16).isActive = true
        imgDatePicker.widthAnchor.constraint(equalToConstant: 28).isActive = true
        let imgHeightConstraint = imgDatePicker.heightAnchor.constraint(equalToConstant: 28)
        imgHeightConstraint.priority = UILayoutPriority(999)
        imgHeightConstraint.isActive = true
        
        
        datePicker.leadingAnchor.constraint(equalTo: imgDatePicker.trailingAnchor, constant: 0).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: pickerContainer.trailingAnchor, constant: -16).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: imgDatePicker.centerYAnchor).isActive = true
        datePicker.subviews[0].subviews[0].subviews[0].alpha = 0

    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}


protocol FlightInfoFieldsDelegate: AnyObject {
    func didMakeSelection(flightStructure: [(FlightTypes, String)], date: Date)
}


extension HomeTVTopCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectorStructure.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case selectorStructure.count-1:
            break
        case selectorStructure.count-2:
            break
        default:
            if editingStyle == .delete {
                selectorStructure.remove(at: indexPath.row)
                tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: indexPath.section)], with: .fade)
                delegate?.didMakeSelection(flightStructure: selectorStructure, date: datePicker.date)
            }
        }

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AirportPickerCell", for: indexPath) as! AirportPickerCell
        
        cell.airportsList = airportsList
        cell.makeCell(with: selectorStructure[indexPath.row])
        cell.didSelectAirport = { [weak self] (flightType, airport) in
            
            switch flightType {
                
            case .source:
                self?.selectorStructure[0].1 = airport
            case .destination:
                guard let count = self?.selectorStructure.count else {return}
                self?.selectorStructure[count - 1].1 = airport
            case .transfer:
                if self?.selectorStructure[indexPath.row].1 != "" {
                    self?.selectorStructure[indexPath.row].1 = airport
                } else {
                    self?.selectorStructure.insert((flightType, airport), at: indexPath.row)
                    tableView.performBatchUpdates({
                        tableView.insertRows(at: [IndexPath(row: indexPath.row+1, section: indexPath.section)], with: .automatic)
                    }, completion: nil)
                }
            }
            if let date = self?.datePicker.date {
                if let selectorStructure = self?.selectorStructure {
                    self?.delegate?.didMakeSelection(flightStructure: selectorStructure, date: date)
                }
            }
        }
        return cell
    }
}
