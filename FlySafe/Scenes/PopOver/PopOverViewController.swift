//
//  PopOverViewController.swift
//  FlySafe
//
//  Created by LiziChichua on 12.01.22.
//

import UIKit

class PopOverViewController: UIViewController {
    
    var flightPlan: TripPlan?
    var didpressSave: ((Flight, String) -> (Void))?
    var source: String?
    var destination: String?
    var transfer: String?
    var date: String?
    var airportsList: [String]?
    
    var popOverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.cornerRadius
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = Constants.cornerRadius
        return tableView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.backgroundColor = UIColor(hex: "10A5F9")
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func saveTapped() {
        if let flightPlan = flightPlan, let source = source, let destination = destination, let transfer = transfer, let date = date {
            didpressSave?(Flight(source: source, destination: destination, date: date), flightPlan.planID)
            print ("Variable 'Transfer' not used -> \(transfer)")
            self.dismiss(animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        self.view.addSubview(popOverView)
        popOverView.addSubview(tableView)
        popOverView.addSubview(saveButton)
        
        //Register TV Cell
        tableView.register(HomeTVTopCell.self, forCellReuseIdentifier: "HomeTVTopCell")
        
        //Set TV delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            popOverView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 180),
            popOverView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            popOverView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            popOverView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -260),
            
            tableView.topAnchor.constraint(equalTo: popOverView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: popOverView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: popOverView.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: popOverView.leadingAnchor, constant: 110),
            saveButton.trailingAnchor.constraint(equalTo: popOverView.trailingAnchor, constant: -110),
            saveButton.bottomAnchor.constraint(equalTo: popOverView.bottomAnchor, constant: -20)
        ])
    }

}


extension PopOverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVTopCell", for: indexPath) as! HomeTVTopCell
        cell.delegate = self
        cell.newFlightLabel.text = "Edit Flight"
        cell.airportsList = airportsList
        cell.flightPlan = flightPlan
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PopOverViewController: FlightInfoFieldsDelegate {
    func didSelectFlightDate(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.date = formatter.string(from: date)
    }
    
    func didSelectSource(source: String) {
        let sourceArray = source.components(separatedBy: ",")
        let sourceID = sourceArray.first
        self.source = sourceID
    }
    
    func didSelectDestination(destination: String) {
        let destinationArray = destination.components(separatedBy: ",")
        let destinationID = destinationArray.first
        self.destination = destinationID
    }
    
    func didSelectTransfer(transfer: String) {
        let transferArray = transfer.components(separatedBy: ",")
        let transferID = transferArray.first
        self.transfer = transferID
    }

}
